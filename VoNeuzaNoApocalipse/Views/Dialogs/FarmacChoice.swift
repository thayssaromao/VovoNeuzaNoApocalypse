//
//  Farmacol.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 02/08/25.
//

import SwiftUI

struct FarmacChoice: View {
    @State private var currentScene: GameScene = ScenesDictionary["Farmacol"]!
    @State private var currentDialogueIndex: Int = 0
    @State private var isTypingFinished: Bool = false
    @State private var isDialogueFinished = false
    @State private var fadeOut = false
    @State private var xOffset: CGFloat = 0
    @State private var goToNextScene: Bool = false
    @State private var getReward: Bool = false
    @State private var goToGameOver: Bool = false
    
    var body: some View {
        let line = currentScene.dialogues[currentDialogueIndex]
        let speaker = line.speaker
        if goToNextScene {
            Reward(rewardImage: "pilula") {
                goToNextScene = false
                getReward = true

            }
        } else if getReward {
            
            TheirdDialog()
        }
else if goToGameOver {
            GameOverView()
        
        } else {
            ZStack {
                Image("backgroundDialogueYellow")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea()
                
                
                // Balão de fala com texto
                if speaker == "vovo" {
                    HStack {
                        Spacer()
                        ZStack {
                            Image("ballon")
                                .resizable()
                                .scaleEffect(1)
                                .offset(x: 60, y: 20)
                            
                            TypewriterText(
                                fullText: line.text,
                                speed: 0.05,
                                isTypingFinished: $isTypingFinished
                            )
                            .id(currentDialogueIndex)
                            .frame(width: 400)
                            .multilineTextAlignment(.leading)
                            .offset(x: 100, y: 120)
                        }
                    }
                }
                if speaker == "vovo" {
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
                }
                if isDialogueFinished {
                    HStack(spacing: 9) {
                        ForEach(currentScene.choices, id: \.destinationId) { choice in
                            ChoiceButtonView(title: choice.textButton) {
                                withAnimation(.easeOut(duration: 0.6)) {
                                    fadeOut = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    if choice.destinationId == "Tem remedio" {
                                        self.goToNextScene = true
                                    }
                                    if choice.destinationId == "sem remedio" {
                                        self.goToGameOver = true
                                    }
                                }
                            }
                        }
                    }.offset(x:190)
                    
                }
                Color.black
                    .opacity(fadeOut ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: fadeOut)
                    .ignoresSafeArea()
                
            } .contentShape(Rectangle())
                .onTapGesture {
                    if isTypingFinished {
                        if currentDialogueIndex < currentScene.dialogues.count - 1 {
                            currentDialogueIndex += 1
                            isTypingFinished = false
                        } else {
                            withAnimation(.easeOut(duration: 0.6)) {
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
    FarmacChoice()
}
