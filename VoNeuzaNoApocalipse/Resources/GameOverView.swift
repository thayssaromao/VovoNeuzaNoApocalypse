//
//  GameOverView.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 01/08/25.
//

import SwiftUI

struct GameOverView: View {
    @AppStorage("checkpointSceneId") private var checkpointSceneId: String = "Initial"
    
    @State private var isShowing = false
    @State private var showButtons = false
    @State private var goToCheckpoint = false
    @State private var goToMenu = false
    
    var message: String = "VOCÊ MORREU VOVÓ"
    
    var body: some View {
        if goToCheckpoint {
            // Usa o DialogueRouter para a cena do checkpoint salvo
            DialogueRouter(sceneId: checkpointSceneId)
                .onAppear {
                    SoundManager.shared.playLoop(sound: .background) // Retoma música
                }
        } else if goToMenu {
            InicialMenu()
                .onAppear {
                    SoundManager.shared.playLoop(sound: .background) // Retoma música
                }
        } else {
            ZStack {
                Group {
                    Color.black
                        .ignoresSafeArea(.all)
                    
                    Text(message)
                        .font(.system(size: 62, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .padding()
                        .opacity(isShowing ? 1 : 0)
                        .animation(.easeIn(duration: 1.5).delay(1.0), value: isShowing)
                    
                    Image("blood1")
                        .opacity(isShowing ? 1 : 0)
                        .animation(.easeIn(duration: 1.5).delay(1.0), value: isShowing)
                        .offset(x: -300, y: 100)
                    
                    Image("blood2")
                        .opacity(isShowing ? 1 : 0)
                        .animation(.easeIn(duration: 1.5).delay(1.0), value: isShowing)
                        .offset(x: 270, y: -50)
                }
                .opacity(showButtons ? 0 : 1)
                .animation(.easeOut(duration: 1.0), value: showButtons)
                
                if showButtons {
                    ContinueButton(
                        onContinue: {
                            goToCheckpoint = true
                        },
                        onQuit: {
                            goToMenu = true
                        }
                    )
                    .transition(.opacity.animation(.easeIn(duration: 1.0)))
                    .frame(maxHeight: .infinity)
                }
            }
            .onAppear {
                SoundManager.shared.play(sound: .diedSound, from: 4)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    SoundManager.shared.fadeOutAndStop(sound: .diedSound, duration: 2)
                }
                withAnimation(.easeInOut(duration: 3)) {
                    self.isShowing = true
                }
                withAnimation(.easeInOut(duration: 3)) {
                    self.isShowing = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        self.showButtons = true
                    }
                }
                // Pausa música ao mostrar Game Over
                SoundManager.shared.pause(sound: .background)
            }
        }
    }
}


struct ContinueButton: View {
    let onContinue: () -> Void
    let onQuit: () -> Void // Corrigido de onQuite
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                Button(action: onContinue) {
                    Text("Continuar")
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button(action: onQuit) {
                    Text("Sair")
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .padding()
                }
            }
            
            // As imagens de sangue foram transferidas para a GameOverView
            // para que a animação de opacidade funcione corretamente.
        }
    }
}
struct DialogueRouter: View {
    let sceneId: String

    var body: some View {
        switch sceneId {
        case "FirstDialog":
            FirstDialog()
        case "SecondDialog":
            SecondDialog()
        case "SecondZombie":
            SecondChoice()
        case "Initial":
            FirstDialog()
        default:
            Text("Cena não encontrada para o checkpoint '\(sceneId)'")
        }
    }
}

#Preview {
    GameOverView()
}
