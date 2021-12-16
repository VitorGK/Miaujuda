import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
    @AppStorage("jwtToken") var jwtToken: String = ""
    @AppStorage("appleID") var appleID: String = ""
    @AppStorage("userID") var userID: String = ""
    @AppStorage("avatar") var avatar: Int = 0
    @AppStorage("organizationName") var organizationName: String = ""
    @AppStorage("organizationCategory") var organizationCategory: String = ""
    @AppStorage("organizationZipCode") var organizationZipCode: String = ""
    @AppStorage("email") var email: String?
    @AppStorage("phone") var phone: String?
    @AppStorage("website") var website: String?
    
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
                                            // MARK: --- Usuário não encontrado / novo usuário
                                            print("User not found.")
                                            self.isButtonPressed = true
                                        default:
                                            // MARK: --- Usuário já existente
                                            print("User found.")
                                            guard let userID = data["_id"] as? String else { return }
                                            self.userID = userID
                                            print(self.userID)
                                            guard let jwtToken = data["access_token"] as? String else { return }
                                            self.jwtToken = jwtToken
                                            print(self.jwtToken)
                                            ServerService.shared.getUser(by: userID) { result in
                                                switch result {
                                                    case .success(let response):
                                                        self.avatar = response.avatar
                                                        self.organizationName = response.organizationName
                                                        self.organizationCategory = response.organizationCategory
                                                        self.organizationZipCode = response.organizationZipCode
                                                        self.email = response.email
                                                        self.phone = response.phone
                                                        self.website = response.website
                                                        print("User logged in.")
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
