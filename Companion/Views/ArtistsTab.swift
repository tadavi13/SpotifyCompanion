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
                VStack(spacing: 0) {
                    if let artists = controller.artists {
                        ForEach(artists.items) { item in
                            Button(action: {
                                
                            }, label: {
                                AsyncImage(url: item.images[0].url, content: { returnedImage in
                                    returnedImage
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 55, height: 55)
                                        .clipShape(Circle())
                                }, placeholder: {
                                    ProgressView()
                                })
                                Text(item.name)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                                    .padding(.leading, 5)
                            })
                        }
                    }
                }
                .padding(.leading, 20)
                .background(Color("Background").edgesIgnoringSafeArea(.all))
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

#Preview {
    ArtistsTab()
}
