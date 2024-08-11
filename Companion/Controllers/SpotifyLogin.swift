//
//  SpotifyLogin.swift
//
//  Created by Tyler Davis on 8/2/24.
//

import UIKit
import WebKit
import SwiftUI

// MARK: - SpotifyLogin

/// This struct allows for the ViewController to be embedded in the ContentView.
struct SpotifyLogin: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    /// Whether the SpotifyLogin screen is presented or not.
    @Binding var isPresented: Bool
    
    /// Coordinator class for controlling when the SpotifyLogin is presented.
    class Coordinator: NSObject {
        var parent: SpotifyLogin
            
        init(_ parent: SpotifyLogin) {
            self.parent = parent
        }
        
        /// Dismisses the SpotifyLogin by setting isPresented to false.
        func dismiss() {
            parent.isPresented = false
        }
    }
    
    /// Initializer for the coordinator.
    /// - Returns: The coordinator for the SpotifyLogin.
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    /// Makes a ViewController instance in order to embed it in the ContentView.
    /// - Parameter context: A struct containing context of the current system state.
    /// - Returns: A ViewController instance for connecting a user's Spotify account.
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = ViewController()
        vc.coordinator = context.coordinator
        return vc
    }
    
    /// An update function for the ViewController instance.
    /// - Parameters:
    ///   - uiViewController: A UIViewController to update.
    ///   - context: A struct containing context of the current system state.
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - ViewController

/// ViewController class for the user to log in to spotify in a WebView for account connection.
class ViewController: UIViewController {
    /// The coordinator for the ViewController to dismiss it.
    var coordinator: SpotifyLogin.Coordinator?
    
    /// Gets the AccessToken needed to access to SpotifyWebAPI unless it is already saved in UserDefaults.
    override func viewDidLoad() {
        super.viewDidLoad()

        getAccessTokenFromWebView()
    }
    
    /// Gets the Access Token using a WebView screen to log the user in.
    private func getAccessTokenFromWebView() {
        //if UserDefaults.standard.value(forKey: "Authorization") == nil {
            guard let urlRequest = APIService.shared.getAccessTokenURL() else { return }
            let webview = WKWebView()
            
            webview.load(urlRequest)
            webview.navigationDelegate = self
            view = webview
        //}
    }
    
    /// This function closes the ViewController by calling the coordinator's dismiss function.
    @objc func close() {
        coordinator?.dismiss()
    }
}

// MARK: - WebView

extension ViewController: WKNavigationDelegate {
    /// WebView for letting the user log in to their Spotify account to connect it. Extracts the access token after the user logs in to be used by the APIService class.
    /// - Parameters:
    ///   - webView: WebView used to hold the Spotify login screen.
    ///   - navigation: The navigation for the WebView.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else { return }
        
        var tokenString = ""
        if urlString.contains("#access_token=") {
            let range = urlString.range(of: "#access_token=")
            guard let index = range?.upperBound else { return }
            
            tokenString = String(urlString[index...])
        }
        
        if !tokenString.isEmpty {
            let range = tokenString.range(of: "&token_type=Bearer")
            guard let index = range?.lowerBound else { return }
            
            tokenString = String(tokenString[..<index])
            UserDefaults.standard.setValue(tokenString, forKey: "Authorization")
            close()
        }
    }
}
