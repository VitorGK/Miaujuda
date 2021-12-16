import Foundation

class PostViewModel: ObservableObject {
    @Published private var posts: [PetPost]
    @Published var isLoading: Bool
    @Published var errorMessage: String?
    @Published var pickerSelectedItem: Int = 1
    private var postFilter: PostFilter
    var filteredPosts: [PetPost] {
        return postFilter.filter(pickerValue: pickerSelectedItem, posts: posts)
    }

    
    
    init(postFilter: PostFilter) {
        self.posts = []
        self.isLoading = false
        self.postFilter = postFilter
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


protocol PostFilter {
    func filter(pickerValue: Int, posts: [PetPost]) -> [PetPost]
}

struct TypePostFilter: PostFilter {
    func filter(pickerValue: Int, posts: [PetPost]) -> [PetPost] {
        if pickerValue == 1 {
            return posts.filter {$0.type == "Necessidade"}
        }
        else {
            return posts.filter {$0.type == "Doação"}
        }
    }
}

struct TypeAndCategoryPostFilter: PostFilter {
    let category: String
    
    func filter(pickerValue: Int, posts: [PetPost]) -> [PetPost] {
        if pickerValue == 1 {
            return posts.filter {$0.type == "Necessidade" && $0.itemCategory == category}
        }
        else {
            return posts.filter {$0.type == "Doação" && $0.itemCategory == category}
        }
    }
}

struct UserAndStatusPostFilter: PostFilter {
    let userID: String = UserDefaults.standard.string(forKey: "userID") ?? ""
    
    func filter(pickerValue: Int, posts: [PetPost]) -> [PetPost] {
        if pickerValue == 1 {
            return posts.filter {$0.userID == userID && $0.status == PetPostStatus.active.rawValue}
        }
        else {
            return posts.filter {$0.userID == userID && $0.status == PetPostStatus.concluded.rawValue}
        }
    }
}
