//
//  FinalScene.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 03/08/25.
//

import SwiftUI

struct FinalScene: View {
    
    @State private var currentScene: GameScene = ScenesDictionary["FinalScene"]!
    @State private var currentDialogueIndex: Int = 0
    @State private var isTypingFinished: Bool = false
    @State private var isDialogueFinished = false
    @State private var fadeOut = false
    @State private var xOffset: CGFloat = 0
    @State private var goToNextScene: Bool = false
    @State private var getReward: Bool = false
    let selectedRewardImage: String?
    @State private var zombieSoundPlayedIndices: Set<Int> = []
    @State private var showBalloon: Bool = false
    
    @AppStorage("checkpointSceneId") private var checkpointSceneId: String = "Initial"
    @AppStorage("hasStartedGame") private var hasStartedGame: Bool = true


    
    var body: some View {
        let line = currentScene.dialogues[currentDialogueIndex]
        let speaker = line.speaker
        if isDialogueFinished {
            InicialMenu()
        } else {
            ZStack {
                Image("backgroundFinal")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea()
                
                if let imageName = selectedRewardImage {
                    VStack {
                        Spacer()
                        Image(imageName)
                            .resizable()
                    }.offset(y:20)
                }
                
                // Balão de fala com texto
                if showBalloon {
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
                }
                
                // Tela preta de transição
                Color.black
                    .opacity(fadeOut ? 1 : 0)
                    .animation(.easeOut(duration: 1), value: fadeOut)
                    .ignoresSafeArea()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if !showBalloon {
                    showBalloon = true
                    return
                }
                
                if isTypingFinished {
                    if currentDialogueIndex < currentScene.dialogues.count - 1 {
                        currentDialogueIndex += 1
                        isTypingFinished = false
                    } else {
                        withAnimation {
                            fadeOut = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            hasStartedGame = false

                            isDialogueFinished = true
                        }

                    }
                }
            }
            .onChange(of: currentDialogueIndex) { newIndex in
                let currentLine = currentScene.dialogues[newIndex]
                if currentLine.triggersZombieSound && !zombieSoundPlayedIndices.contains(newIndex) {
                    zombieSoundPlayedIndices.insert(newIndex)
                    SoundManager.shared.play(sound: .diedSound)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        SoundManager.shared.fadeOutAndStop(sound: .diedSound, duration: 1)
                    }
                }
            }
        }
    }
}
#Preview {
    FinalScene(selectedRewardImage: "Pão")
}
