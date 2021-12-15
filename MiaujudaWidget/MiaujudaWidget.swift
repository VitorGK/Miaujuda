//
//  MiaujudaWidget.swift
//  MiaujudaWidget
//
//  Created by Bianca Maciel Matos on 15/12/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), petPost: PetPost(__v: 0, _id: "", createdAt: "", userID: "", status: "", type: "", title: "", description: "", itemName: "", itemQuantity: "", itemCategory: "", itemExpirationDate: ""), user: User(__v: 0, _id: "", createdAt: "", appleID: "", avatar: 0, organizationName: "", organizationCategory: "", organizationZipCode: "", email: "", phone: "", website: ""))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        ServerService.shared.getLatestPetPost { result in
            switch result{
            case .success(let data) :
                ServerService.shared.getUser(by: data.userID) { result in
                    switch result {
                    case .success(let user):
                        let entry = SimpleEntry(date: Date(), petPost: data, user: user)
                        completion(entry)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        ServerService.shared.getLatestPetPost { result in
            switch result{
            case .success(let data) :
                ServerService.shared.getUser(by: data.userID) { result in
                    switch result {
                    case .success(let user):
                        let entry = SimpleEntry(date: Date(), petPost: data, user: user)
                        let timeline = Timeline(entries: [entry], policy: .atEnd)
                        completion(timeline)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var petPost: PetPost
    var user: User
}

struct MiaujudaWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                VStack {
                    Text(entry.petPost.title)
                        .bold()
                    Text(entry.user.organizationName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                if entry.petPost.status == "Active" { // status = ativo
                    Image(systemName: "clock.fill")
                } else { // status = inativo
                    Image(systemName: "checkmark.circle.fill")
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 0)
                            .fill((entry.petPost.status == "Active") ? Color.activePostYellow : Color.concludedPostGray))
            
            VStack (alignment: .leading) {
                Text("\(entry.petPost.itemName) - \(entry.petPost.itemQuantity)")
                    .padding(.leading)
                
                HStack{
                    Spacer()
                    Text(entry.user.organizationZipCode)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.trailing)
                
                HStack{
                    Spacer()
                    Text(String(entry.petPost.createdAt))
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.trailing)
            }
            
        }
        .padding(.bottom)
        .background(Color.backgroundPost)
        .cornerRadius(15)
        .shadow(radius: 4)
    }
}

@main
struct MiaujudaWidget: Widget {
    let kind: String = "MiaujudaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MiaujudaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct MiaujudaWidget_Previews: PreviewProvider {
    static var previews: some View {
        MiaujudaWidgetEntryView(entry: SimpleEntry(date: Date(), petPost: PetPost(__v: 0, _id: "", createdAt: "", userID: "", status: "", type: "", title: "", description: "", itemName: "", itemQuantity: "", itemCategory: "", itemExpirationDate: ""), user: User(__v: 0, _id: "", createdAt: "", appleID: "", avatar: 0, organizationName: "", organizationCategory: "", organizationZipCode: "", email: "", phone: "", website: "")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
