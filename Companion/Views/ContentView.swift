//
//  ContentView.swift
//
//  @author Tyler Davis
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScreen: Bool = false
    
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
            
            Button(action: {
                showScreen.toggle()
            }, label: {
                Text("Click Here")
            })
            .sheet(isPresented: $showScreen, content: {
                SpotifyLogin()
            })
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
