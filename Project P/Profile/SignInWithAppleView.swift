import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
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
                        print("Authorization successful.")
                        guard let credential = authResults.credential as? ASAuthorizationAppleIDCredential else { return }
                        print(credential.user)
                        authenticate(appleID: credential.user) {
                            self.isButtonPressed = true
                            self.dismiss()
                        }
                    case .failure(let error):
                        print("Authorization failure" + error.localizedDescription)
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
    
    func authenticate(appleID: String, completion: @escaping () -> Void) {
        ServerService.shared.authenticate(appleID: appleID) { response in
            switch response {
                case .success(let user):
                    let userAppleID = user.appleID
                    let userAvatar = user.avatar
                    let userOrganizationName = user.organizationName
                    let userOrganizationCategory = user.organizationCategory
                    let userOrganizationZipCode = user.organizationZipCode
                    let userEmail = user.email
                    let userPhone = user.phone
                    let userWebsite = user.website
                    UserDefaults.standard.set(userAppleID, forKey: "userAppleID")
                    UserDefaults.standard.set(userAvatar, forKey: "userAvatar")
                    UserDefaults.standard.set(userOrganizationName, forKey: "userOrganizationName")
                    UserDefaults.standard.set(userOrganizationCategory, forKey: "userOrganizationCategory")
                    UserDefaults.standard.set(userOrganizationZipCode, forKey: "userOrganizationZipCode")
                    UserDefaults.standard.set(userEmail, forKey: "userEmail")
                    UserDefaults.standard.set(userPhone, forKey: "userPhone")
                    UserDefaults.standard.set(userWebsite, forKey: "userWebsite")
                    print("Authentication successful.")
                    completion()
                case .failure(let error):
                    print("Error Authenticate")
                    print(error.localizedDescription)
            }
        }
    }
}

struct SignInWithAppleView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleView(isButtonPressed: .constant(false))
    }
}
