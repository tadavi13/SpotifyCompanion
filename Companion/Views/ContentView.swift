//
//  ContentView.swift
//
//  Created by Tyler Davis on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented = true
    
    var body: some View {
        if isPresented {
            SpotifyLogin(isPresented: $isPresented)
                .edgesIgnoringSafeArea(.all)
        } else {
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
