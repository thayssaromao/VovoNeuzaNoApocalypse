//
//  FirstDialogue.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 02/08/25.
//

import SwiftUI

struct FirstDialog: View {
    @State private var currentScene: GameScene = ScenesDictionary["FirstDialog"]!
    @State private var currentDialogueIndex: Int = 0
    @State private var xOffset: CGFloat = 0
    @State private var isTypingFinished: Bool = false
    
    @State private var isDialogueFinished = false
    @State private var fadeOut = false
    
    var body: some View {
        if isDialogueFinished {
            FirstChoice()
        } else {
            ZStack {
                Image("backgroundDialoguePink")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea()

                HStack {
                    ZStack {
                        Image("ballon")
                            .resizable()
                            .scaleEffect(1)
                            .offset(x: 100, y: 30)
                        
                        TypewriterText(
                            fullText: currentScene.dialogues[currentDialogueIndex].text
,
                            speed: 0.05,
                            isTypingFinished: $isTypingFinished
                        )
                        .offset(x: 162, y: 130)
                        .id(currentDialogueIndex)
                    }
                    
                }
                
                Image("assetVo")
                    .resizable()
                    .scaleEffect(6)
                    .frame(width: 100, height: 100)
                    .offset(x: xOffset, y: 90)
                    .animation(
                        Animation
                            .easeInOut(duration: 1.6)
                            .repeatForever(autoreverses: true),
                        value: xOffset
                    )
                    .onAppear {
                        xOffset = -9
                    }
                    .offset(x: -190)
                
                // Essa é a view que cria o fade preto
                Color.black
                    .opacity(fadeOut ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: fadeOut)
                    .ignoresSafeArea()
            }.contentShape(Rectangle())
                .onTapGesture {
                    if isTypingFinished {
                        if currentDialogueIndex < currentScene.dialogues.count - 1 {
                            currentDialogueIndex += 1
                            isTypingFinished = false
                        } else {
                            // Inicia o fade out para a próxima cena
                            withAnimation(.easeOut(duration: 0.6)) {
                                fadeOut = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                isDialogueFinished = true
                            }
                        }
                    }
                }
        }
    }
}



#Preview {
    FirstDialog()
}
