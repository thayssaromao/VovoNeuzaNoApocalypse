//
//  Reward.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 02/08/25.
//

import SwiftUI

struct Reward: View {
    let rewardImage: String
    let onAnimationFinished: () -> Void
    
    @State private var yOffset: CGFloat = -600
    @State private var scale: CGFloat = 0.3
    @State private var showText: Bool = false
    @State private var tilt: Bool = false
    @State private var opacity: Double = 1.0


        
    var body: some View {
        ZStack {
            Image("backgroundDialoguePink")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
                
            VStack(spacing: 40) {
                Image(rewardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .scaleEffect(scale)
                    .offset(y: yOffset)
                    .rotationEffect(.degrees(tilt ? 5 : -5))
                    .animation(
                        tilt ? Animation
                            .easeInOut(duration: 0.1)
                            .repeatForever(autoreverses: true) : .default,
                        value: tilt
                    )
                    .opacity(opacity)
                    .shadow(radius: 50)
                    .onAppear {
                        SoundManager.shared.play(sound: .sparkle, from: 3)

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {                            SoundManager.shared.pause(sound: .sparkle)
                        }
                        withAnimation(
                            .interpolatingSpring(stiffness: 120, damping: 12)
                            .delay(0.2)
                        ) {
                            yOffset = 0
                            scale = 3.5
                        }
                        withAnimation(.easeIn.delay(1.0)) {
                            showText = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            tilt = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation(.easeOut(duration: 1)) {
                                opacity = 0
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            onAnimationFinished()
                        }
                    }

                if showText {
                        
                    Text("Você encontrou \(rewardImage) !")
                        .font(.title)
                        .fontWeight(.bold)
                        .transition(.opacity).offset(y:60)
                }
            }
        }
    }
}

#Preview {
    Reward(rewardImage: "Pão", onAnimationFinished: {})
}
