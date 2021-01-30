//
//  HorizontalItemView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 30/01/21.
//

import SwiftUI

struct HorizontalItemView: View {
    let title: String
    let value: CustomStringConvertible

    var body: some View {
        Group {
            HStack {
                Text(title).bold()
                Spacer()
            }
            HStack {
                Text(value.description)
                    .alignmentGuide(.customAlignment, computeValue: { dimension in
                        dimension[.leading]
                    })
                Spacer()
            }
        }
    }
}

struct HorizontalItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            HorizontalItemView(title: "Title", value: "Value")
        }
        .padding()
    }
}
