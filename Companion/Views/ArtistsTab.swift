//
//  ArtistsTab.swift
//  Companion
//
//  Created by Tyler Davis on 8/9/24.
//

import SwiftUI

struct ArtistsTab: View {
    var body: some View {
        NavigationStack() {
            ScrollView() {
                VStack {
                    Rectangle()
                        .fill(Color("BackgroundGrey"))
                        .frame(minHeight: 800, maxHeight: .infinity)
                }
            }
            .navigationTitle("Artists")
        }
        .tabItem {
            Text("Artists")
        }
    }
}

func createArtistsTab() {
    Task {
        let artists = try await APIService.shared.getFollowedArtists()
        artists.forEach {_ in 
            
        }
    }
}

#Preview {
    ArtistsTab()
}
