//
//  ErrorView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 07/04/2025.
//

import SwiftUI

struct ErrorView: View {
    let onTryAgain: () -> Void
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .padding(20)
                .background(
                    Circle()
                        .fill(Color("BackgroundGray"))
                )
                .frame(width: 64, height: 64)
            
            Text("Error")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
            
            Text("An error has occured,")
                .font(.callout)
                .foregroundColor(.white)
            Text("please try again later")
                .font(.callout)
                .foregroundColor(.white)
            
            Button(action: onTryAgain) {
                Text("Try Again")
                    .foregroundColor(.white)
                    .font(.callout)
                    .bold(true)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(Color("RedEventorias"))
                    .cornerRadius(4)
            }
        }
        
    }
}

#Preview {
    ErrorView(onTryAgain: {})
}
