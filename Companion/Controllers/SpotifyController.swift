//
//  SpotifyController.swift
//  Companion
//
//  Created by Tyler Davis on 7/31/24.
//

import SwiftUI
import SpotifyiOS
import Combine

class SpotifyController: NSObject, ObservableObject {
    let spotifyClientID = "dd0ed5073e794beda6d89ac5040bff23"
    let spotifyRedirectURL = URL(string:"spotify-ios-quick-start://spotify-login-callback")!
    
    var accessToken: String? = nil
        
    var playURI = ""
    
    private var connectCancellable: AnyCancellable?
        
        private var disconnectCancellable: AnyCancellable?
        
        override init() {
            super.init()
            connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    self.connect()
                }
            
            disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    self.disconnect()
                }

        }
            
        lazy var configuration = SPTConfiguration(
            clientID: spotifyClientID,
            redirectURL: spotifyRedirectURL
        )

        lazy var appRemote: SPTAppRemote = {
            let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
            appRemote.connectionParameters.accessToken = self.accessToken
            appRemote.delegate = self
            return appRemote
        }()
        
        func setAccessToken(from url: URL) {
            let parameters = appRemote.authorizationParameters(from: url)
            
            if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
                appRemote.connectionParameters.accessToken = accessToken
                self.accessToken = accessToken
            } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
                print(errorDescription)
            }
            
        }
        
        func connect() {
            guard let _ = self.appRemote.connectionParameters.accessToken else {
                self.appRemote.authorizeAndPlayURI("")
                return
            }
            
            appRemote.connect()
        }
        
        func disconnect() {
            if appRemote.isConnected {
                appRemote.disconnect()
            }
        }
    }

    extension SpotifyController: SPTAppRemoteDelegate {
        func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
            self.appRemote.playerAPI?.delegate = self
            self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                
            })
        }
        
        func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
            print("failed")
        }
        
        func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
            print("disconnected")
        }
    }

    extension SpotifyController: SPTAppRemotePlayerStateDelegate {
        func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
            // noop
        }

}
