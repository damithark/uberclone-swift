//
//  LocationSearchActivationView.swift
//  UberClone
//
//  Created by Damitha Raveendra on 2023-09-17.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.horizontal)

            Text("Where to?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width-64, height: 50)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .gray, radius: 6)
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
