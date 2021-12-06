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
                        self.isButtonPressed = true
                        self.dismiss()
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
    
//    func authorize(authResults: ASAuthorization) {
//        guard let credentials = authResults.credential as? ASAuthorizationAppleIDCredential, let identityToken = credentials.identityToken, let identityTokenString = String(data: identityToken, encoding: .utf8) else { return }
//        let body = ["appleIdentityToken": identityTokenString]
//        guard let jsonData = try? JSONEncoder().encode(body) else { return }
//        // This is where you'd fire an API request to your server to authenticate with the identity token attached in the request headers.
//    }
}

//struct SignInWithAppleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInWithAppleView()
//    }
//}
