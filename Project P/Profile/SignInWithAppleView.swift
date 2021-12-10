import SwiftUI
import AuthenticationServices
import CoreLocation

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
                    let location = CLLocation(latitude: -22.963451, longitude: -43.198242)
                    location.geocode { placemark, error in
                        if let error = error as? CLError {
                            print("CLError:", error)
                            return
                        } else if let placemark = placemark?.first {
                            // you should always update your UI in the main thread
                            DispatchQueue.main.async {
                                //  update UI here
                                print("name:", placemark.name ?? "unknown")
                                
                                print("address1:", placemark.thoroughfare ?? "unknown")
                                print("address2:", placemark.subThoroughfare ?? "unknown")
                                print("neighborhood:", placemark.subLocality ?? "unknown")
                                print("city:", placemark.locality ?? "unknown")
                                
                                print("state:", placemark.administrativeArea ?? "unknown")
                                print("subAdministrativeArea:", placemark.subAdministrativeArea ?? "unknown")
                                print("zip code:", placemark.postalCode ?? "unknown")
                                print("country:", placemark.country ?? "unknown", terminator: "\n\n")
                                
                                print("isoCountryCode:", placemark.isoCountryCode ?? "unknown")
                                print("region identifier:", placemark.region?.identifier ?? "unknown")
                        
                                print("timezone:", placemark.timeZone ?? "unknown", terminator:"\n\n")

                                // Mailind Address
                                print(placemark.mailingAddress ?? "unknown")
                            }
                        }
                    }
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
