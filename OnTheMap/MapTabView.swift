//
//  MapTabView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 28/01/21.
//

import SwiftUI
//import MapKit

struct MapTabView: View {
    @State private var selection = 1

    var body: some View {
        TabView(selection: $selection) {
            VStack {
                Text("hi")
//                Map()
            }.tabItem {
                Image(systemName: "map")
                Text("Map")
            }.tag(1)
            Text("Tab 2").tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }.tag(2)
        }
        .navigationTitle("OnTheMap")
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MapTabView()
        }
    }
}
