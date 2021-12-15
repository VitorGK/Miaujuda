import Foundation

class UserFetcher: ObservableObject {
    @Published var user: User?
    @Published var isLoading: Bool
    @Published var errorMessage: String?
    
    init() {
        self.isLoading = false
        if UserDefaults.standard.string(forKey: "userID") != "" {
            let userID = UserDefaults.standard.string(forKey: "userID")
            self.getUserByID(user: userID ?? "")
        }
    }
    
    func getUserByID(user id: String) {
        isLoading = true
        errorMessage = nil
        
        ServerService.shared.getUser(by: id) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                    case .success (let user):
                        self.user = user
                        UserDefaults.standard.set(user._id, forKey: "userID")
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
