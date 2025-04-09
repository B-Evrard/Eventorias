//
//  EventRowView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 05/04/2025.
//

import SwiftUI

struct EventRowView: View {
    @Binding var event: EventViewData
    
    var body: some View {
        //VStack  {
            HStack {
                Image("profil")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.horizontal)
                
                VStack (alignment: .leading)  {
                    Text(event.title)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .padding(.vertical,5)
                    Text(event.dateFormatter)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
                Spacer()
                Image("event")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 136, height: 80)
                    .background(Color("BackgroundColor"))
                    .cornerRadius(12)
            }
            .background(Color("BackgroundGray"))
            .cornerRadius(12)
            
        //}
//        .padding(.vertical,5)
//        .listRowInsets(EdgeInsets())
//        .listRowBackground(Color("BackgroundColor"))
    }
}

#Preview {
    let event = EventViewData(id: "123", title: "Ligne de titre", dateEvent: Date())
    EventRowView(event: .constant(event))
}
