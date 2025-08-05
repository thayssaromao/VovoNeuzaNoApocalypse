import SwiftUI

struct InicialMenu: View {
    @AppStorage("hasSeenIntro") private var hasSeenIntro: Bool = false
    @AppStorage("hasStartedGame") private var hasStartedGame: Bool = false
    @AppStorage("checkpointSceneId") private var checkpointSceneId: String = "Initial"

    @State private var startGame = false
    @State private var continueGame = false
    @State private var musicStarted = false

    var body: some View {
        if startGame {
            InicialScene(
                onVideoStart: {
                    SoundManager.shared.pause(sound: .background)
                },
                onVideoEnd: {
                    SoundManager.shared.playLoop(sound: .background)
                }
            )
        } else if continueGame {
            DialogueRouter(sceneId: checkpointSceneId)
        } else {
            ZStack {
                Image("backgroundDialogueYellow")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack (spacing:50){
          
                    ImageButtonView(
                        imageName: "novoJogo",
                       
                    ) {
                        hasSeenIntro = false
                        startGame = true
                        hasStartedGame = true

                    }
                    ImageButtonView(
                        imageName: "continuar"
                    ) {
                        if hasStartedGame {
                            SoundManager.shared.play(sound: .choiceSound)
                            continueGame = true
                        }
                    }
                    .disabled(!hasStartedGame)
                    .opacity(hasStartedGame ? 1.0 : 0.5)


                }
               
            }
            .onAppear {
                if !musicStarted {
                    SoundManager.shared.playLoop(sound: .background)
                    musicStarted = true
                }
            }
        }
    }
}


#Preview {
    InicialMenu()
}
