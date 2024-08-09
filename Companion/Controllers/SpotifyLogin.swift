//
//  SpotifyLogin.swift
//
//  Created by Tyler Davis on 8/2/24.
//

import UIKit
import WebKit
import SwiftUI

// MARK: - SpotifyLogin

/// PresentationManager for managing the visibility of the SpotifyLogin screen.
class PresentationManager: ObservableObject {
    static let shared = PresentationManager()
    /// Whether the SpotifyLogin screen is presented or not.
    @Published var isPresented: Bool = true
}

/// This struct allows for the ViewController to be embedded in the ContentView.
struct SpotifyLogin: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    /// Makes a ViewController instance in order to embed it in the ContentView.
    /// - Parameter context: A struct containing context of the current system state.
    /// - Returns: A ViewController instance for connecting a user's Spotify account.
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = ViewController()
        var navigationController = UINavigationController(rootViewController: vc)
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
    /// Gets the AccessToken needed to access to SpotifyWebAPI unless it is already saved in UserDefaults.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = UserDefaults.standard.value(forKey: "Authorization") {
            makeNetworkCall()
        } else {
            getAccessTokenFromWebView()
        }
    }
    
    /// Gets the Access Token using a WebView screen to log the user in.
    private func getAccessTokenFromWebView() {
        guard let urlRequest = APIService.shared.getAccessTokenURL() else { return }
        let webview = WKWebView()
        
        webview.load(urlRequest)
        webview.navigationDelegate = self
        view = webview
    }
    
    /// TEMP makes a network call for current functions
    private func makeNetworkCall() {
        Task {
            let artists = try await APIService.shared.getFollowedArtists()
            print(artists)
            PresentationManager.shared.isPresented = false
        }
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
            PresentationManager.shared.isPresented = false
            makeNetworkCall()
        }
    }
}
