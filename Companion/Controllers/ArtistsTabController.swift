//
//  ArtistsTabController.swift
//  Companion
//
//  Created by TylerDavis on 8/10/24.
//

import Foundation

class ArtistsTabController: ObservableObject {
    
    @Published var artists: Artists? = nil
    
    func getFollowedArtists() async {
        let artists = try? await APIService.shared.getFollowedArtists()
        await MainActor.run {
            self.artists = artists
        }
    }
}
