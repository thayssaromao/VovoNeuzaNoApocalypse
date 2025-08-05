//
//  ChoiceButtonView.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 01/08/25.
//

import SwiftUI

struct ChoiceButtonView: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: {
            SoundManager.shared.play(sound: .choiceSound) // ⬅️ TOCA O SOM
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 90)
                    .foregroundColor(Color.white.opacity(0.7))
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)

                Text(title)
                    .font(.system(size: 15, weight: .bold, design: .monospaced))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 25)
            }
            .fixedSize()
        }
    }
}


#Preview {
    // Para pré-visualizar, você cria uma instância da sua View
    // e passa as propriedades necessárias.
    // A ação aqui pode ser uma closure vazia ou uma ação de exemplo.
    HStack {
        ChoiceButtonView(title: "Verificar a geladeira") {
            print("Botão de escolha pressionado!")
        }
        .padding()
        
        // Você pode adicionar outras visualizações para testar
        ChoiceButtonView(title: "Fazer um cafezinho") {
            print("Botão 2 pressionado!")
        }
        .padding()
    }
}
