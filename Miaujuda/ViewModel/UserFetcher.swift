//
//  UserFetcher.swift
//  Helpets
//
//  Created by Caroline Taus on 14/12/21.
//

import Foundation

class UserFetcher: ObservableObject {
    @Published var isLoading: Bool
    @Published var errorMessage: String?
    @Published var user: User?
    
    
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
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .success (let user):
                self.user = user
                    UserDefaults.standard.set(user._id, forKey: "userID")
                }
            }
            
        }
    }
}
