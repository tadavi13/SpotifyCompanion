//
//  CompanionApp.swift
//  Companion
//
//  Created by Tyler Davis on 7/26/24.
//

import SwiftUI

@main
struct CompanionApp: App {
    
    @StateObject var spotifyController = SpotifyController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    spotifyController.setAccessToken(from: url)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
                    spotifyController.connect()
                })
        }
    }
}
