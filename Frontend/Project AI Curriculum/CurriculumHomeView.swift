import SwiftUI

struct CurriculumHomeView: View {
    
    let topic: String
    let content: String
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            Spacer().frame(height: 20)
            
            // TITLE
            Text(topic)
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color(red: 0.10, green: 0.20, blue: 0.45))
            
            Spacer().frame(height: 10)
            
            // READ
            NavigationLink {
                ReadView(content: content)
            } label: {
                sectionCard(
                    title: "READ",
                    color: Color(hex: "A3E3F6")
                )
            }
            
            // WATCH
            NavigationLink {
                WatchView(topic: topic)
            } label: {
                sectionCard(
                    title: "WATCH VIDEOS",
                    color: Color(hex: "CFF4FF")
                )
            }
            
            // STUDY
            NavigationLink {
                StudyFlashcardsView(content: content)
            } label: {
                sectionCard(
                    title: "STUDY (FLASHCARDS)",
                    color: Color(hex: "5693A6")
                )
            }
            
            Spacer()
            
            // BOTTOM NAV BAR
            HStack(spacing: 50) {
                
                Image("check_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Image("home_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Image("book_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background( LinearGradient(
                colors: [
                    Color(red: 0.60, green: 0.78, blue: 0.85),
                    Color(red: 0.74, green: 0.86, blue: 0.90)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            )
            .cornerRadius(40)
            
            Spacer().frame(height: 10)

        }
        .padding()
        .navigationBarHidden(true) // hides top nav bar
    }
    
    //  CARD UI
    func sectionCard(title: String, color: Color) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(25)
            .background(color)
            .cornerRadius(18)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}


import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


