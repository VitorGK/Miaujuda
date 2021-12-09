//
//  PostsGrid.swift
//  Helpets
//
//  Created by Caroline Taus on 09/12/21.
//

import SwiftUI

struct PostsGrid: View {
    @State var posts: [PetPost]
    let columns = [
            GridItem(.adaptive(minimum: 180))
        ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<posts.count, id: \.self) { p in
                NavigationLink {
                    PostDetailsView(postItems: [ItemCard(itemName: posts[p].item.name, quantity: posts[p].item.quantity, category: posts[p].item.category, expDate: Date())])
                } label: {
                    PostCard(title: posts[p].title, organization: posts[p].userID.organizationName, item: PostItem(name: posts[p].item.name, quantity: posts[p].item.quantity), status: posts[p].status, timeStamp: posts[p].createdAt, type: posts[p].type, localization: posts[p].userID.organizationZipCode)
                }

            }
        }
    }
}

//struct PostsGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsGrid()
//    }
//}
