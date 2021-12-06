import SwiftUI

struct TestView: View {
    @State private var isPresented: Bool = false
    @State private var isButtonPressed: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: PushedView(), isActive: $isButtonPressed) {
                    EmptyView()
                }.hidden()
                
                Button(action: {
                    self.isPresented = true
                }, label: {
                    Text("Present Modal")
                })
                
                .sheet(isPresented: $isPresented, onDismiss: {
                    self.isPresented = false
                }) {
                    ModalView(isButtonPressed: self.$isButtonPressed)
                }
            }
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding private var isButtonPressed: Bool
    
    init(isButtonPressed: Binding<Bool>) {
        _isButtonPressed = isButtonPressed
    }
    
    var body: some View {
        NavigationView {
            Button(action: {
                self.isButtonPressed = true
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Dismiss and push")
            })
        }
    }
}

struct PushedView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Yeah!!!")
                Spacer()
            }
        }
        .navigationBarTitle("Pushed View")
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
