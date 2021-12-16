//
//  CategorySearch.swift
//  Helpets
//
//  Created by Caroline Taus on 08/12/21.
//

import SwiftUI

struct CategorySearch: View {
    @ObservedObject var postViewModel: PostViewModel
    
    
    
    var category: String
    
    //TODO: Exibir os posts filtrados para cada categoria
    var body: some View {
        ScrollView {
            VStack{
                Picker(selection: $postViewModel.pickerSelectedItem, label: Text("Picker"), content: {
                    Text("Necessidades").tag(1)
                    Text("Doações").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                PostsGrid(posts: postViewModel.filteredPosts)
                
//                if pickerSelectedItem == 1 {
//                    PostsGrid(posts: filterPosts(category: "\(category)", posts: postViewModel.posts, type: "Necessidade"))
//                } else {
//                    PostsGrid(posts: filterPosts(category: "\(category)", posts: postViewModel.posts, type: "Doação"))
//                }
            }
            .navigationTitle("\(category)")
            .padding()
        }
    }
    
    func filterPosts(category: String, posts: [PetPost], type: String) -> [PetPost] {
        var filteredPosts: [PetPost] = []
        filteredPosts = posts.filter { $0.itemCategory == "\(category)" && $0.type == "\(type)" }
        return filteredPosts
    }
}

//struct CategorySearch_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorySearch(category: "Alimentos")
//    }
//}
