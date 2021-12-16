import SwiftUI

struct ProfileView: View {
    @AppStorage("userID") var userID: String = ""
    @AppStorage("avatar") var avatar: Int = 0
    @AppStorage("organizationName") var organizationNameDefault: String = ""
    @AppStorage("organizationCategory") var organizationCategoryDefault: String = ""
    @AppStorage("organizationZipCode") var organizationZipCodeDefault: String = ""
    @AppStorage("email") var emailDefault: String?
    @AppStorage("phone") var phoneDefault: String?
    @AppStorage("website") var websiteDefault: String?
    
    @State var user: User? = nil
    
    let profileImages: [String] = [
        "profileCat1",
        "profilePug",
        "profileDog",
        "profileCat2"
    ]
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                //                Button{
                //                    print("Edit button was tapped")
                //                } label: {
                //                    Image(systemName: "pencil.circle")
                //                }
                //                .padding()
            }
            
            Image(profileImages[avatar])
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 20)
            
            Text(organizationNameDefault)
                .font(.title.bold())
            Text(organizationCategoryDefault)
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            
            VStack (alignment: .leading){
                if let email = emailDefault, !email.isEmpty {
                    Label("\(email)", systemImage: "envelope.fill")
                }
                if let phone = phoneDefault, !phone.isEmpty {
                    Label("\(phone)", systemImage: "phone.fill")
                }
                if let website = websiteDefault, !website.isEmpty {
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
            NavigationLink(destination: MyPostsView()){
                Text ("Minhas Postagens")
            }
            
            Button{
                print("Log Out")
            } label: {
                Text("Sair").foregroundColor(Color.red)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
