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
                    PostDetailsView(post: PetPost(_id: "id", createdAt: Date(), userID: User(_id: "dsf", createdAt: Date(), avatar: 1, organizationName: "orgname", organizationCategory: "orgact", organizationZipCode: "zipcode", email: "kjdshfj", phone: "sdf", website: "fesfe"), status: "active", type: "Doação", title: "fdsf", description: "desc", item: Item(_id: "fdsf", name: "sdfds", quantity: "2", category: "food", expirationDate: Date())), item: Item(_id: "fdsf", name: "sdff", quantity: "3ewf", category: "food", expirationDate: Date()))
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
