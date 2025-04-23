//
//  EventRowView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 05/04/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventRowView: View {
    @Binding var event: EventViewData
    
    var body: some View {
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
                    .font(.callout)
                    .padding(.vertical,5)
                Text(event.dateFormatter)
                    .foregroundColor(.white)
                    .font(.callout)
            }
            Spacer()
            
            WebImage(url: URL(string: event.imageUrl )) { image in
                    image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 136, height: 80)
                    .background(Color("BackgroundColor"))
                    .cornerRadius(12)
               } placeholder: {
                   ProgressView()
                       .frame(width: 136, height: 80)
               }
               .indicator(.activity)
            
            
//            AsyncImage(url: event.url ) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 136, height: 80)
//                    .background(Color("BackgroundColor"))
//                    .cornerRadius(12)
//                
//            } placeholder: {
//                ProgressView()
//                    .frame(width: 136, height: 80)
//                    
//            }
           
                
        }
        .background(Color("BackgroundGray"))
        .cornerRadius(12)
        .accessibilityHidden(true)
    }
}

#Preview {
    let eventData = EventViewData(id: "1", title: "Art exhibition", dateEvent: Date(), description: "xxxxxx yy zzzzzzz", imageUrl: "", address: "123 Rue des Métiers 60880 Jaux, France", latitude:  49.404519000000001, longitude: 2.7849428999999999, category: .exhibition)
    EventRowView(event: .constant(eventData))
}
