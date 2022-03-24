//
//  ContentView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/18.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("today")
                        .renderingMode(.template)
                            .foregroundColor(.white)
                    Text("투데이")
                }
            GameView()
                .tabItem {
                    Image("KakaoTalk_Photo")
                        .renderingMode(.template)
                            .foregroundColor(.white)
                    Text("게임")
                }
            
            AppView()
                .tabItem {
                    Image(systemName: "square.stack.3d.up.fill")
                    Text("앱")
                }
            AppView()
                .tabItem {
                    Image("icons8-apple-arcade-30")
                        .renderingMode(.template)
                            .foregroundColor(.white)
                    Text("Arcade")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
        }
        
    }
}

struct HomeView: View {
    var body: some View {
        Text("투데이")
            .padding()
    }
}

struct GameView: View {
    var body: some View {
        Text("게임")
            .padding()
    }
}

struct AppView: View {
    var body: some View {
        Text("앱")
            .padding()
    }
}

struct ArcadeView: View {
    var body: some View {
        Text("Arcade")
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
