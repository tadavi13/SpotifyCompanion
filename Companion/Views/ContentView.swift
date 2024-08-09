//
//  ContentView.swift
//
//  Created by Tyler Davis on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    
    /// Presentation Manager for the visibility of the SpotifyLogin screen.
    @ObservedObject var presentationManager = PresentationManager.shared
    
    var body: some View {
        ZStack {
            TabView {
                ArtistsTab()
                //            AlbumsTab()
                //
                //            ReleasesTab()
                //
                //            RadarTab()
            }
        }
        .fullScreenCover(isPresented: $presentationManager.isPresented) {
            SpotifyLogin()
        }
    }
}

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

//struct AlbumsTab: View {
//    var body: some View {
//        NavigationStack() {
//            ScrollView() {
//                VStack {
//                    Rectangle()
//                        .fill(Color("BackgroundGrey"))
//                        .frame(minHeight: 800, maxHeight: .infinity)
//                }
//            }
//            .navigationTitle("Albums")
//        }
//        .tabItem {
//            Text("Albums")
//        }
//    }
//}
//
//struct ReleasesTab: View {
//    var body: some View {
//        NavigationStack() {
//            ScrollView() {
//                VStack {
//                    Rectangle()
//                        .fill(Color("BackgroundGrey"))
//                        .frame(minHeight: 800, maxHeight: .infinity)
//                }
//            }
//            .navigationTitle("Releases")
//        }
//        .tabItem {
//            Text("Releases")
//        }
//    }
//}
//
//struct RadarTab: View {
//    var body: some View {
//        NavigationStack() {
//            ScrollView() {
//                VStack {
//                    Rectangle()
//                        .fill(Color("BackgroundGrey"))
//                        .frame(minHeight: 800, maxHeight: .infinity)
//                }
//            }
//            .navigationTitle("Radar")
//        }
//        .tabItem {
//            Text("Radar")
//        }
//    }
//}

/// Preview for the Content View
#Preview {
    ContentView()
}
