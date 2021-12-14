//
//  Widget.swift
//  Widget
//
//  Created by Bianca Maciel Matos on 14/12/21.
//

import WidgetKit
import SwiftUI

struct Model : TimelineEntry {
    var date: Date
    var widgetData: [JSONModel]
}
    
struct JSONModel : Decodable, Hashable {
    var date = Date()
    var item : Item
}

struct Provider : TimelineProvider {
//    func placeholder(in context: Context) -> Model {
//        <#code#>
//    }
    
    typealias Entry = Model
    
    
    func getSnapshot(in context: Context, completion: @escaping (Model) -> ()) {
        let loadingData = Model(date: Date(), widgetData:Array(repeating: JSONModel(date: Date(), item: .init(_id: "1", name: "a", quantity: "2", category: "c", expirationDate: Date())), count: 6))
        
        completion(loadingData)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Model>) -> ()) {
        
        getData{ (modelData) in
            let date = Date()
            let data = Model(date: date, widgetData: modelData)
            
            let nextUpdate = Calendar.current.date(byAdding: .minute,value: 15 ,to: date)
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            
            completion(timeline)
        }
    }
}

struct WidgetView: View {
    var data : Model
    var body: some View {
        VStack{
            Text("Post Card")
                .foregroundColor(.red)
            
            HStack{
                
            }
        }
    }
}

@main
struct MainWidget : Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "aaaaa", provider: Provider()) { data in
            WidgetView(data: data)
        }
        .description(Text("Daily Status"))
        .configurationDisplayName(Text("Daily Updates"))
        .supportedFamilies([.systemLarge])
    }
}

func getData(completion: @escaping ([JSONModel]) -> ()) {
    
    let url = "https://project-pets.herokuapp.com/petpost/"
    
    let session = URLSession(configuration: .default)
    
    session.dataTask(with: URL(string: url)!) { (data, _, err) in
        
        if err != nil {
            print(err!.localizedDescription)
            return
        }
        
        do {
            
            let jsonData = try JSONDecoder().decode([JSONModel].self, from: data!)
            completion(jsonData)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
