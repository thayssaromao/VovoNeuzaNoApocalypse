//
//  TypewriterText.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 03/08/25.
//

import SwiftUI

struct TypewriterText: View {
    let fullText: String
    let speed: Double // tempo entre cada letra
    @State private var displayedText: String = ""
    
    @Binding var isTypingFinished: Bool
    
    // Propriedade para controlar o número máximo de caracteres por linha
    let charactersPerLine: Int = 30 // Ajuste este número conforme a largura do seu balão

    var body: some View {
        Text(displayedText)
            .font(.system(size: 18, weight: .medium, design: .monospaced))
            .onAppear {
                displayedText = ""
                isTypingFinished = false // Garante que começa como falso

                // Formata o texto para inserir quebras de linha
                let formattedText = formatTextForLineBreaks(fullText, after: charactersPerLine)
                
                var charIndex = 0.0
                for letter in formattedText {
                    DispatchQueue.main
                        .asyncAfter(deadline: .now() + charIndex * speed) {
                            displayedText.append(letter)
                            if displayedText.count == formattedText.count {
                                isTypingFinished = true
                            }
                        }
                    charIndex += 1
                }
                if isTypingFinished == false {SoundManager.shared.play(sound: .Typing, from: 5)}else{DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    SoundManager.shared.fadeOutAndStop(sound: .Typing, duration: 1)
                }}
                

            }
    }
    
    // Função auxiliar para inserir quebras de linha
    private func formatTextForLineBreaks(_ text: String, after count: Int) -> String {
        guard count > 0 else { return text }
        
        var result = ""
        var currentCount = 0
        
        for char in text {
            result.append(char)
            if char != " " {
                currentCount += 1
            }
            if currentCount >= count && char == " " {
                result.append("\n")
                currentCount = 0
            }
        }
        
        return result
    }
}
