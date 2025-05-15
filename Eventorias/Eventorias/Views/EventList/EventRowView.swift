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
            WebImage(url: URL(string: event.urlPictureUser )) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(.horizontal)
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .frame(width: 40, height: 40)
            .padding(.horizontal,10)
            
            VStack (alignment: .leading)  {
                Text(event.title)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .minimumScaleFactor(0.8)
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
                    .cornerRadius(12)
            } placeholder: {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 136, height: 80)
                    .cornerRadius(12)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .frame(width: 136, height: 80)
        }
        .background(Color("BackgroundGray"))
        .cornerRadius(12)
        .accessibilityHidden(true)
        
    }
}

#Preview {
    let eventData = EventViewData(id: "1", idUser: "", title: "Art exhibition Art exhibition Art exhibition", dateEvent: Date(), description: "xxxxxx yy zzzzzzz", imageUrl: "", address: "123 Rue des Métiers 60880 Jaux, France", latitude:  49.404519000000001, longitude: 2.7849428999999999, category: .exhibition, urlPictureUser: "")
    EventRowView(event: .constant(eventData))
}
