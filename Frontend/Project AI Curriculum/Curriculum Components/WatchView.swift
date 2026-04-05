

import SwiftUI

struct WatchView: View {
    
    let topic: String
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            // TITLE
            Text("WATCH")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 0.10, green: 0.20, blue: 0.45))
            
            Text("Videos for \(topic)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            // VIDEO SECTION
            YouTubeView(videoID: getVideoID(for: topic))
                .aspectRatio(16/9, contentMode: .fit) // ✅ scales nicely
                .cornerRadius(12)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Temporary mapping: replace with real API later
    func getVideoID(for topic: String) -> String {
        return "LinWJsangs4" // placeholder video
    }
}

// Preview
struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WatchView(topic: "SwiftUI")
        }
    }
}
