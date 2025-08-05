import SwiftUI

struct ImageButtonView: View {

    var imageName: String
    var action: () -> Void
    @State private var isPressed: Bool = false

    var body: some View {
        Button(action: {
            SoundManager.shared.play(sound: .choiceSound)
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                action()
            }
        }) {
            Image(imageName)                
                .scaleEffect(isPressed ? 0.85 : 1.0)
                .animation(.easeOut(duration: 0.1), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
#Preview {
    ImageButtonView(imageName: "novoJogo", action: { })
}
