//
//  FirstChoice.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 02/08/25.


import SwiftUI

struct FirstChoice: View {
    @AppStorage("checkpointSceneId") private var checkpointSceneId: String = "FirstDialog"

    @State private var currentScene: GameScene = ScenesDictionary["Initial"]!
    @State private var xOffset: CGFloat = 0
    @State private var currentDialogueIndex: Int = 0
    @State private var isTypingFinished: Bool = false
    
    @State private var isFloatingUp = true
    @State private var isSelected: Bool = false
    
    // Variáveis para controlar a navegação e o fade out
    @State private var goToNextScene: Bool = false
    @State private var goToGameOver: Bool = false
    @State private var fadeOut = false
    
    var body: some View {
        if goToNextScene {
            SecondDialog()
        } else if goToGameOver {
            GameOverView()
        } else {
            // A ZStack principal contém todo o conteúdo da tela
            ZStack {
                Image("choiceOneBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea()
                
                Image("assetOne")
                    .resizable()
                    .scaleEffect(1.4)
                    .frame(width: 200)
                    .offset(x: xOffset, y: 90)
                    .animation(
                        Animation
                            .easeInOut(duration: 2)
                            .repeatForever(autoreverses: true),
                        value: xOffset
                    )
                    .onAppear {
                        xOffset = -5
                    }
                
                HStack {
                    ZStack {
                        Image("ballon")
                            .resizable()
                            .scaleEffect(0.7)
                            .offset(x: 60, y: 90)
                        
                        TypewriterText(fullText: currentScene.dialogues[currentDialogueIndex].text
, speed: 0.05, isTypingFinished: $isTypingFinished)
                            .offset(x: 60, y: 160)
                        
                        HStack(spacing: 300) {
                            ForEach(currentScene.choices, id: \.destinationId) { choice in
                                ChoiceButtonView(title: choice.textButton) {
                                    // Ação do botão: Iniciar o fade out e depois a navegação
                                    withAnimation(.easeOut(duration: 0.6)) {
                                        fadeOut = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        if choice.destinationId == "SecondDialog" {
                                            self.goToNextScene = true
                                            checkpointSceneId = "SecondDialog"

                                        }
                                        if choice.destinationId == "Não Salvar Netos" {
                                            checkpointSceneId = "FirstDialog"
                                            self.goToGameOver = true
                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: 20, height: 20)
                    }
                }
                
                // Camada de fade out que cobre toda a tela
                Color.black
                    .opacity(fadeOut ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: fadeOut)
                    .ignoresSafeArea()
            }
        }
    }
}
#Preview {
    FirstChoice()
}
