//
//  TheirdDialog.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 02/08/25.
//

import SwiftUI

struct TheirdDialog: View {
    @State private var currentScene: GameScene = ScenesDictionary["TheirdDialog"]!
    @State private var currentDialogueIndex: Int = 0
    @State private var isTypingFinished: Bool = false
    @State private var isDialogueFinished = false
    @State private var fadeOut = false

    var body: some View {
        if isDialogueFinished {
           ChoiceThree()
        } else{
            ZStack {
                Image("padariaBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea()
                
                ZStack {
                    Image("ballon")
                        .resizable()
                        .scaleEffect(0.65)
                        .offset(x: -270, y: 50)
                    
                    TypewriterText(
                        fullText: currentScene.dialogues[currentDialogueIndex].text
,
                        speed: 0.05,
                        isTypingFinished: $isTypingFinished
                    )
                    .id(currentDialogueIndex)
                    .padding(EdgeInsets(top: 80, leading: 100, bottom: 80, trailing: 100))
                    .frame(width: 510) // Ajuste para que o texto caiba
                    .multilineTextAlignment(.leading) // Alinhamento para o texto
                    .offset(x: -250, y: 110)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if isTypingFinished {
                        if currentDialogueIndex < currentScene.dialogues.count - 1 {
                            currentDialogueIndex += 1
                            isTypingFinished = false
                        } else {
                            withAnimation(.easeOut(duration: 0.6)) {
                                fadeOut = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                isDialogueFinished = true
                            }
                        }
                    }
                }
                Color.black
                    .opacity(fadeOut ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: fadeOut)
                    .ignoresSafeArea()
            }
        }
    }
}


#Preview {
    TheirdDialog()
}
