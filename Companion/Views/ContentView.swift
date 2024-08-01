//
//  ContentView.swift
//  Companion
//
//  Created by Tyler Davis on 7/26/24.
//

//
//  ViewController.swift
//  easyplay
//
//  Created by jrasmusson on 2022-03-21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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

/**
 * Preview for views
 */
#Preview {
    ContentView()
}
