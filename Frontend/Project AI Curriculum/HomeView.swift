import SwiftUI

struct HomeView: View {
    
    @State private var topic = ""
    @State private var curriculum: String = ""
    @State private var isLoading = false
    @State private var navigate = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    
                    Spacer().frame(height: 30)
                    
                    Text("What do you want\nto learn today?")
                        .font(.system(size: 34))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    // INPUT
                    VStack(alignment: .leading) {
                        Text("Enter topic:")
                            .foregroundColor(.gray)
                        
                        TextField("For example: Planet life", text: $topic)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.18, green: 0.36, blue: 0.47), lineWidth: 2)
                            )
                    }
                    .padding(.horizontal, 30)
                    
                    // BUTTON
                    Button(action: generateCurriculum) {
                        Text("Generate curriculum")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 260)
                            .background(Color(red: 0.18, green: 0.36, blue: 0.47))
                            .cornerRadius(12)
                    }
                    
                    // LOADING
                    if isLoading {
                        ProgressView("Generating...")
                            .padding()
                    }
                    
                    Spacer()
                    
                    // BOTTOM BAR
                    HStack(spacing: 45) {
                        Image("check_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Image("home_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Image("book_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    .padding(11)
                    .frame(width: 300)
                    .background(
                        LinearGradient(
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
            }
            .navigationDestination(isPresented: $navigate) {
                CurriculumHomeView(topic: topic, content: curriculum)
            }
        }
    }
    
    // Backend API Call
    func generateCurriculum() {
        
        let trimmedTopic = topic.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTopic.isEmpty else { return }
        
        isLoading = true
        curriculum = ""
        
        // ⚡ Your backend URL
        guard let url = URL(string: "http://localhost:3000/ai-content") else {
            print("Invalid backend URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["topic": trimmedTopic]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                print("Network error:", error)
                return
            }
            
            guard let data = data else {
                print("No data received from backend")
                return
            }
            
            do {
                // The backend can return the raw AI content string or a structured JSON
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
                    // If you returned "choices[0].message.content" from backend
                    if let choices = json["choices"] as? [[String: Any]],
                       let message = choices.first?["message"] as? [String: Any],
                       let content = message["content"] as? String {
                        DispatchQueue.main.async {
                            self.curriculum = content
                            self.navigate = true
                        }
                    } else if let content = json["content"] as? String {
                        // Optional: if backend sends simplified JSON
                        DispatchQueue.main.async {
                            self.curriculum = content
                            self.navigate = true
                        }
                    } else {
                        print("Unexpected backend response:", json)
                    }
                    
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
}

#Preview {
    HomeView()
}
