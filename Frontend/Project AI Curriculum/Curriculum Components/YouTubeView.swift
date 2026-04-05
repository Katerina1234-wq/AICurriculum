//
//  YouTubeView.swift
//  Project AI Curriculum
//
//  Created by Katerina Borisova on 05/04/2026.
//

//
//  YouTubeView.swift
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoID: String

    func makeCoordinator() -> Coordinator {
        Coordinator(videoID: videoID)
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.preferences.javaScriptEnabled = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .clear
        webView.isOpaque = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>body { margin:0; background-color: transparent; }</style>
        </head>
        <body>
        <iframe width="100%" height="100%" 
        src="https://www.youtube.com/embed/\(videoID)?playsinline=1" 
        frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
        allowfullscreen></iframe>
        </body>
        </html>
        """
        uiView.loadHTMLString(html, baseURL: nil)
    }

    // Coordinator detects if video fails and opens YouTube app instead
    class Coordinator: NSObject, WKNavigationDelegate {
        let videoID: String

        init(videoID: String) {
            self.videoID = videoID
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            openInYouTubeApp()
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            openInYouTubeApp()
        }

        func openInYouTubeApp() {
            if let url = URL(string: "https://youtu.be/\(videoID)") {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}
