
import SwiftUI
import Foundation

struct FlipCard: View {
    
    let card: Flashcard
    @State private var flipped = false
    
    var body: some View {
        
        ZStack {
            
            // FRONT (QUESTION)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .overlay(
                    VStack {
                        Text("QUESTION")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(card.question)
                            .font(.title3)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                )
                .opacity(flipped ? 0 : 1)
            
            // BACK (ANSWER)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange)
                .overlay(
                    VStack {
                        Text("ANSWER")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(card.answer)
                            .font(.title3)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                )
                .opacity(flipped ? 1 : 0)
        }
        .frame(height: 220)
        .rotation3DEffect(
            .degrees(flipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.4), value: flipped)
        .onTapGesture {
            flipped.toggle()
        }
    }
}
#Preview {
    FlipCard(card: Flashcard(question: "What is AI?", answer: "AI is the simulation of human intelligence in machines."))
        .padding()
}

