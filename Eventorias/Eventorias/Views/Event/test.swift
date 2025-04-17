//
//  test.swift
//  Eventorias
//
//  Created by Bruno Evrard on 17/04/2025.
//

import SwiftUI

struct test: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://maps.googleapis.com/maps/api/staticmap?enter=49.404519,2.7849429&markers=color:red%7Csize:tiny%7C49.404519,2.7849429&zoom=12&size=149x72&maptype=roadmap&key=AIzaSyBj-dLHQKsbFCPdBtM5a73hQFa61tRmDGg") ) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 72)
                .cornerRadius(10)
                .accessibilityLabel("Map event location")

   
        } placeholder: {
            ProgressView()
                //.tint(.white)
                //.foregroundColor(.white)
                .frame(width: 150, height: 72)
                .clipShape(Circle())
        }
    }
}

#Preview {
    test()
}
