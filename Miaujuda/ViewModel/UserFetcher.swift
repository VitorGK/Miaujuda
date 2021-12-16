import Foundation

class UserFetcher: ObservableObject {
    @Published var user: User?
    @Published var isLoading: Bool
    @Published var errorMessage: String?
    
    init() {
        self.isLoading = false
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            self.getUserByID(userID)
        }
    }
    
    func getUserByID(_ userID: String) {
        self.isLoading = true
        self.errorMessage = nil
        ServerService.shared.getUserByID(userID) { result in
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
