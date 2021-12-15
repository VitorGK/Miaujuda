import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [PetPost]
    @Published var isLoading: Bool
    @Published var errorMessage: String?
    
    init() {
        self.posts = []
        self.isLoading = false
        
        self.getAllPosts()
    }
    
    func getAllPosts() {
        self.isLoading = true
        self.errorMessage = nil
        ServerService.shared.getAllPetPosts { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                    case .success(let data):
                        self.posts = data
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}
