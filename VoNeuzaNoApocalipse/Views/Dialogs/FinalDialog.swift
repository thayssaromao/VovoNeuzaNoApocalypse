//
//  FinalDialog.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 03/08/25.
//


import SwiftUI

struct FinalDialog: View {
    @State private var currentScene: GameScene = ScenesDictionary["FinalDialog"]!
    @State private var currentDialogueIndex: Int = 0
    @State private var isTypingFinished: Bool = false
    @State private var isDialogueFinished = false
    @State private var fadeOut = false
    @State private var xOffset: CGFloat = 0
    @State private var goToNextScene: Bool = false
    @State private var getReward: Bool = false
    let selectedRewardImage: String?
    
    @State private var zombieSoundPlayedIndices: Set<Int> = []


    var body: some View {
        let line = currentScene.dialogues[currentDialogueIndex]
        let speaker = line.speaker
        if isDialogueFinished {
           FinalScene(selectedRewardImage: selectedRewardImage)

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
                } else {
                    HStack {
                        ZStack {
                            Image("ballon")
                                .resizable()
                                .scaleEffect(1)
                                .offset(x: -60, y: 20)
                            
                            TypewriterText(
                                fullText: line.text,
                                speed: 0.05,
                                isTypingFinished: $isTypingFinished
                            )
                            .id(currentDialogueIndex)
                            .frame(width: 400)
                            .multilineTextAlignment(.leading)
                            .offset(x: -90, y: 120)
                        }
                        Spacer()
                    }
                }
                
                if speaker == "vovo" {
                    Image("assetVo")
                        .resizable()
                        .scaleEffect(5)
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
                } else if speaker == "crianças" {
                    Image("criancas")
                        .resizable()
                        .offset(x: xOffset, y:0)
                        .animation(
                            Animation
                                .easeInOut(duration: 0.2)
                                .repeatForever(autoreverses: true),
                            value: xOffset
                        )
                        .onAppear {
                            xOffset = -9
                        }.offset(x:460, y:22)
                }else if speaker == "zumbi" {
                    Image("zumbi")
                        .resizable()
                        .scaleEffect(1.1)
                        .offset(x: xOffset, y:0)
                        .animation(
                            Animation
                                .easeInOut(duration: 0.2)
                                .repeatForever(autoreverses: true),
                            value: xOffset
                        )
                        .onAppear {
                            xOffset = -9
                        }.offset(x:10, y:50)
                }
               
                
                
                Color.black
                    .opacity(fadeOut ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: fadeOut)
                    .ignoresSafeArea()
            }
            .contentShape(Rectangle())
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
            }.onChange(of: currentDialogueIndex) { newIndex in
                let currentLine = currentScene.dialogues[newIndex]
                
                if currentLine.triggersZombieSound && !zombieSoundPlayedIndices.contains(newIndex) {
                    zombieSoundPlayedIndices.insert(newIndex) // marca como já tocado
                    SoundManager.shared.play(sound: .diedSound)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        SoundManager.shared.fadeOutAndStop(sound: .diedSound, duration: 1)
                    }
                }
            }}
    }
}

#Preview {
    FinalDialog(selectedRewardImage: "Cookie")
}
