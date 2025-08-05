import SwiftUI
import AVKit

struct TelaDoJogo: View {
    var body: some View {
        FirstDialog()
        
    }
}

struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL
    var onFinish: () -> Void

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false
        playerViewController.videoGravity = .resizeAspectFill // ESSENCIAL!

        // Detectar fim do vídeo
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem,
                                               queue: .main) { _ in
            self.onFinish()
        }

        player.play()
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.videoGravity = .resizeAspectFill
    }
}


struct InicialScene: View {
    @State private var showGame = false
    @State private var videoURL: URL?
    @State private var fadeOut = false

    var onVideoStart: () -> Void = {}
    var onVideoEnd: () -> Void = {}

    var body: some View {
        if showGame {
            TelaDoJogo()
        } else if let url = videoURL {
            ZStack {
                VideoPlayerView(videoURL: url) {
                    withAnimation(.easeOut(duration: 2.5)) {
                        fadeOut = true
                    }
                    onVideoEnd()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        self.showGame = true
                    }
                }
                .onAppear {
                    onVideoStart()
                }
                .ignoresSafeArea()

                Rectangle()
                    .foregroundColor(.black)
                    .opacity(fadeOut ? 1 : 0)
                    .animation(.easeOut(duration: 2.5), value: fadeOut)
                    .ignoresSafeArea()
            }
        } else {
            Text("Carregando...")
                .onAppear {
                    if let path = Bundle.main.path(forResource: "IntroVideo", ofType: "mov") {
                        self.videoURL = URL(fileURLWithPath: path)
                    } else {
                        self.showGame = true
                    }
                }
        }
    }
}

#Preview {
    InicialScene()
}
