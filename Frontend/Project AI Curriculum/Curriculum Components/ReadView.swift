
import SwiftUI

struct ReadView: View {
    
    let content: String
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // TITLE
            Text("READ")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 0.10, green: 0.20, blue: 0.45))
                .padding(.top, 20)
            
            Divider()
                .padding(.horizontal)
                .padding(.top, 10)
            
            // CONTENT
            ScrollView {
                Text(cleanText(content))
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // REMOVE MARKDOWN SYMBOLS
    func cleanText(_ text: String) -> String {
        text
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "##", with: "")
            .replacingOccurrences(of: "###", with: "")
            .replacingOccurrences(of: "**", with: "")
    }
}

