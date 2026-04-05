
import SwiftUI

struct StartupView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                // Background Image
                Image("image 4")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .offset(x: -22)
                
                
                VStack {
                    
                    Spacer().frame(height: 38)
                    
                    // Title
                    Text("Learn Anything.\nStructured")
                        .font(.system(size: 35, weight: .regular))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    Spacer().frame(height: 19)
                    
                    // Text
                    Text("AI builds your personal\ncurriculum from scratch")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black.opacity(0.8))
                    
                    Spacer()
                    
                    // Button
                    NavigationLink(destination: HomeView()) {
                        Text("Get Started")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 16)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(20)
                    }
                    
                    Spacer().frame(height: 60)
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

#Preview {
    StartupView()
}
