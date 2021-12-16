import SwiftUI

struct ProfileView: View {
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
    
    @Environment(\.dismiss) private var dismiss
    
    @State var user: User? = nil
    @State private var showingAlert: Bool = false
    
    let profileImages: [String] = [
        "profileCat1",
        "profilePug",
        "profileDog",
        "profileCat2"
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
//                Button{
//                    print("Edit button was tapped")
//                } label: {
//                    Image(systemName: "pencil.circle")
//                }
//                .padding()
            }
            
            Image(avatar > -1 ? profileImages[avatar] : "signOut")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 20)
            
            Text(organizationName)
                .font(.title.bold())
            
            Text(organizationCategory)
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            
            VStack (alignment: .leading) {
                if let email = email, !email.isEmpty {
                    Label("\(email)", systemImage: "envelope.fill")
                }
                if let phone = phone, !phone.isEmpty {
                    Label("\(phone)", systemImage: "phone.fill")
                }
                if let website = website, !website.isEmpty {
                    Label("\(website)", systemImage: "link")
                }
            }
        }
        .padding(.bottom, 20)
        .background(Color .backgroundPost)
        .cornerRadius(20)
        .shadow(radius: 4)
        .padding()
        .navigationTitle("Perfil")
        
        List {
            NavigationLink {
                MyPostsView()
            } label: {
                Text("Minhas Postagens")
            }
            
            Button {
                self.showingAlert = true
            } label: {
                Text("Sair")
                    .foregroundColor(Color.red)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Sair"),
                    message: Text("Você realmente deseja sair?"),
                    primaryButton: .destructive(Text("Sair")) {
                        print("User logged out.")
                        self.jwtToken = ""
                        self.appleID = ""
                        self.userID = ""
                        self.avatar = -1
                        self.organizationName = ""
                        self.organizationCategory = ""
                        self.organizationZipCode = ""
                        self.email = ""
                        self.phone = ""
                        self.website = ""
                        self.dismiss()
                    },
                    secondaryButton: .cancel(Text("Cancelar"))
                )
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
