import Foundation

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
  
    private let backendURL = "http://localhost:3000/ai-content"
    
    func fetchCurriculum(for topic: String, completion: @escaping (CurriculumData?) -> Void) {
        
        guard let url = URL(string: backendURL) else {
            print("Invalid backend URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["topic": topic]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Network error:", error)
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            // 🔍 Debug raw response
            if let raw = String(data: data, encoding: .utf8) {
                print("Raw backend response:\n", raw)
            }
            
            do {
                // Parse backend JSON
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
                    // Handle backend error
                    if let error = json["error"] as? [String: Any] {
                        print("Backend error:", error)
                        DispatchQueue.main.async { completion(nil) }
                        return
                    }
                    
                    // Extract OpenAI content
                    if let choices = json["choices"] as? [[String: Any]],
                       let message = choices.first?["message"] as? [String: Any],
                       let content = message["content"] as? String {
                        
                        let curriculum = CurriculumData(
                            topic: topic,
                            readingContent: content,
                            videoURLs: [], // we add later
                            flashcards: [] // we add later
                        )
                        
                        DispatchQueue.main.async {
                            completion(curriculum)
                        }
                        
                    } else {
                        print("Unexpected JSON structure:", json)
                        DispatchQueue.main.async { completion(nil) }
                    }
                    
                }
            } catch {
                print(" JSON parse error:", error)
                DispatchQueue.main.async { completion(nil) }
            }
            
        }.resume()
    }
}
