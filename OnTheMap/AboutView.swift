//
//  AboutView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("Logo icon made by Freepik from Flaticon")
            Spacer()
        }
        .padding()
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView()
        }
    }
}
