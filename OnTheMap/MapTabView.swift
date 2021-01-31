//
//  MapTabView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 28/01/21.
//

import SwiftUI
//import MapKit

struct MapTabView<T: ApiClient>: View {
    @State private var selection = 1
    let studentLocations: [StudentLocation]

    @EnvironmentObject var apiClient: T

    var body: some View {
        TabView(selection: $selection) {
            VStack {
                MapStudentLocationsView(studentLocations: studentLocations)
            }.tabItem {
                Image(systemName: "map")
                Text("Map")
            }.tag(1)
            ListStudentLocationsView(studentLocations: studentLocations)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }.tag(2)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("OnTheMap")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    apiClient.logout()
                }, label: {
                    Text("Logout")
                        .font(.caption)
                })
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MapTabView<MockApiClient>(studentLocations: StudentLocation.sampleArray)
                .environmentObject(MockApiClient())
        }
    }
}
