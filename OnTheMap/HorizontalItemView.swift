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
        HStack {
            Text(title).bold()
            Text(value.description)
                .alignmentGuide(.customAlignment, computeValue: { dimension in
                    dimension[.leading]
                })
            Spacer()
        }
    }
}

struct HorizontalItemView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalItemView(title: "Title", value: "Value")
            .padding()
    }
}
