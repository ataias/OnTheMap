//
//  MapTabView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 28/01/21.
//

import SwiftUI
import PartialSheet

struct MapTabView<T: ApiClient>: View {
    let studentLocations: [StudentLocation]

    @State private var selection = 1
    @State private var isAddingLocation = false

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
        .fullScreenCover(isPresented: $isAddingLocation) {
            NavigationView {
                AddLocationView<T>(isAddingLocation: $isAddingLocation)
                    .navigationTitle("Add Location")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                isAddingLocation = false
                            }
                        }
                    }
            }
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
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        // TODO
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    })
                    .disabled(true)
                    Button(action: {
                        isAddingLocation = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static let sheetManager: PartialSheetManager = PartialSheetManager()

    static var previews: some View {
        NavigationView {
            MapTabView<MockApiClient>(studentLocations: StudentLocation.sampleArray)
                .environmentObject(MockApiClient())
                .environmentObject(sheetManager)
        }
    }
}
