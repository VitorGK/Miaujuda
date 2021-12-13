import SwiftUI

struct ProfileView: View {
    var user: User = User(createdAt: Date(), appleID: "", avatar: 1, organizationName: "organization name", organizationCategory: "categoria", organizationZipCode: "zip code", email: "email@gmail.com", website: "tito.com")
    var body: some View {
        VStack {
            HStack{
                Spacer()
//                Button{
//                    print("Edit button was tapped")
//                } label: {
//                    Image(systemName: "pencil.circle")
//                } .padding()
//                
            }
        
            Image("profileCat2")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 20)
    
            
            Text("\(user.organizationName)")
                .font(.title.bold())
            Text("\(user.organizationCategory)")
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
                
            
            VStack (alignment: .leading){
                if let email = user.email {
                    Label("\(email)", systemImage: "envelope.fill")
                }
                
                if let phone = user.phone {
                    Label("\(phone)", systemImage: "phone.fill")
                }
                
                if let website = user.website {
                    Label("\(website)", systemImage: "link")
                }
            }
            
 
            
        } .padding(.bottom, 20)
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
                print("Edit button was tapped")
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
