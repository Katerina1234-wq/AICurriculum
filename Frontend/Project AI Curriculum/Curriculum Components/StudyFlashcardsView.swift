import SwiftUI

struct StudyFlashcardsView: View {
    
    let content: String
    
    
    var cards: [Flashcard] {
        generateCards(from: content)
    }
    
    var body: some View {
        
        VStack {
            
            Text("FLASHCARDS")
                .font(.title)
                .foregroundColor(Color(red: 0.10, green: 0.20, blue: 0.45))
                .padding(.top)
            
            Spacer()
            
            if cards.isEmpty {
                Text("No flashcards available")
                    .foregroundColor(.gray)
            } else {
                
                // ONE CARD EXPERIENCE (better UX)
                TabView {
                    ForEach(cards) { card in
                        FlipCard(card: card)
                            .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: - SIMPLE PARSER (AI text → Q/A)
    func generateCards(from text: String) -> [Flashcard] {
        
        let lines = text.components(separatedBy: "\n").filter { !$0.isEmpty }
        
        var result: [Flashcard] = []
        
        var i = 0
        while i < lines.count - 1 {
            
            let question = clean(lines[i])
            let answer = clean(lines[i + 1])
            
            result.append(Flashcard(question: question, answer: answer))
            
            i += 2
        }
        
        return result
    }
    
    func clean(_ text: String) -> String {
        text
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "**", with: "")
    }
}

