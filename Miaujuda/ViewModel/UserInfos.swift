import Foundation
class UserInfos: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    
    
    //    init(post: PetPost) {
    //
    //        self.getUserFromPost(post: post)
    //    }
    
    func getUserFromPost(post: PetPost){
        print(post.userID)
        ServerService.shared.getUser(by: post.userID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.user = user
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        
    }
}






