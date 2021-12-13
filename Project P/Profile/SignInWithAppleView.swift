import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
    @AppStorage("jwtToken") var jwtToken: String = ""
    @AppStorage("userID") var userID: String = ""
    @AppStorage("appleID") var appleID: String = ""
    @AppStorage("avatar") var avatar: Int = 0
    @AppStorage("organizationName") var organizationName: String = ""
    @AppStorage("organizationCategory") var organizationCategory: String = ""
    @AppStorage("organizationZipCode") var organizationZipCode: String = ""
    @AppStorage("email") var email: String?
    @AppStorage("phone") var phone: String?
    @AppStorage("website") var website: String?
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isButtonPressed: Bool
    
    var body: some View {
        VStack {
            Text("Bem Vindo!")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            Text("Para fazer sua postagem você deve preencher um cadastro.\n\nTodas as informações cadastradas serão públicas para todos os usuários do aplicativo.")
            
            SignInWithAppleButton { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                    case .success(let authResults):
                        print("Sign in with Apple successful.")
                        guard let credential = authResults.credential as? ASAuthorizationAppleIDCredential else { return }
                        self.appleID = credential.user
                        ServerService.shared.authenticate(appleID: appleID) { response in
                            switch response {
                                case .success(let data):
                                    switch data["statusCode"] as? Int {
                                        case 401:
                                            print("User not found.")
                                            self.isButtonPressed = true
                                        default:
                                            // USUÁRIO JÁ EXISTENTE
                                            print("User found.")
                                            guard let userID = data["_id"] as? String else { return }
                                            guard let jwtToken = data["access_token"] as? String else { return }
                                            self.userID = userID
                                            self.jwtToken = jwtToken
                                            ServerService.shared.getRequest(route: .user, id: userID) { result in
                                                switch result {
                                                    case .success(let response):
                                                        guard let avatar = response["avatar"] as? Int else { return }
                                                        guard let organizationName = response["organizationName"] as? String else { return }
                                                        guard let organizationCategory = response["organizationCategory"] as? String else { return }
                                                        guard let organizationZipCode = response["organizationZipCode"] as? String else { return }
                                                        let email = response["email"] as? String
                                                        let phone = response["phone"] as? String
                                                        let website = response["website"] as? String
                                                        self.avatar = avatar
                                                        self.organizationName = organizationName
                                                        self.organizationCategory = organizationCategory
                                                        self.organizationZipCode = organizationZipCode
                                                        self.email = email
                                                        self.phone = phone
                                                        self.website = website
                                                        print("User logged in.")
                                                        self.isUserLoggedIn = true
                                                    case .failure(let error):
                                                        print(error.localizedDescription)
                                                }
                                            }
                                    }
                                    self.dismiss()
                                case .failure(let error):
                                    print(error.localizedDescription)
                            }
                        }
                    case .failure(let error):
                        print("Sign in with Apple failure" + error.localizedDescription)
                }
            }
            .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
            .frame(width: 280, height: 60, alignment: .center)
            .padding()
            
            Image("signInCat")
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 220)
                .padding()
        }
        .padding(.trailing)
        .padding(.leading)
    }
}

struct SignInWithAppleView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleView(isButtonPressed: .constant(false))
    }
}
