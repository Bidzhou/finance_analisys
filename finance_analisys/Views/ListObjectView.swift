//
//  ListObjectView.swift
//  finance_analisys
//
//  Created by Frederico del' Bidzho on 15.07.2024.
//

import SwiftUI

struct ListObjectView: View {
    @State var name: String
    @State var price: Int
    var body: some View {
        HStack() {
            Text(name)
                .frame(maxWidth: screen.width*0.89, alignment: .leading)
                .lineLimit(0)
                .truncationMode(.tail)
            Text("\(price)")
        }.padding(10)
            .background(Color("Siren_60"))

    }
}

#Preview {
    ListObjectView(name: "idpfmpfkdfpmsdpfkmsdfkmfpsmfomg", price: 100)
}
