//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Damitha Raveendra on 2023-09-17.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subTitle: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.black)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack (alignment: .leading) {
                Text(title)
                    .font(.body)
                Text(subTitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(title: "Title", subTitle: "Subtitle")
    }
}
