//
//  ArtistsTab.swift
//  Companion
//
//  Created by Tyler Davis on 8/9/24.
//

import Foundation
import SwiftUI

struct ArtistsTab: View {
    
    @StateObject private var controller = ArtistsTabController()
    
    var body: some View {
        NavigationStack() {
            ScrollView() {
                VStack {
//                    Rectangle()
//                        .fill(Color("BackgroundGrey"))
//                        .frame(minHeight: 800, maxHeight: .infinity)
                    if let artists = controller.artists {
                        ForEach(artists.items) { item in
                            Rectangle()
                                .fill(Color("BackgroundGrey"))
                                .frame(height: 25)
                            Text(item.name)
                        }
                    }
                }
            }
            .navigationTitle("Artists")
        }
        .tabItem {
            Text("Artists")
        }
        .onAppear {
            Task {
                await controller.getFollowedArtists()
            }
        }
    }
}

//#Preview {
//    ArtistsTab()
//}
