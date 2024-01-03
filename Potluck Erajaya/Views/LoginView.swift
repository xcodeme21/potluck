import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "http://localhost:8000/images/logo/logo.png")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .foregroundColor(.blue)
                        .padding()
                case .failure(_):
                    Text("Failed to load image")
                case .empty:
                    ProgressView()
                @unknown default:
                    Text("Unknown state")
                }
            }
            
            TextField("Email", text: $viewModel.email)
                           .padding()
                           .background(
                               RoundedRectangle(cornerRadius: 10)
                                   .fill(Color.orange.opacity(0.1))
                                   
                           )
                           .frame(height: 50)
                           .padding(.horizontal)
                           .autocapitalization(.none)
                           .focused($isFocused)
                           .onAppear {
                               self.isFocused = true
                           }

            HStack {
                            if viewModel.isPasswordHidden {
                                SecureField("Password", text: $viewModel.password)
                                    .autocapitalization(.none)
                                    .padding(.leading, 30)
                                    .foregroundColor(viewModel.isPasswordValid ? .primary : .red)
                                    .frame(height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.orange.opacity(0.1))
                                            .padding(.leading, 15)
                                    )
                                    .padding(.top,10)
                            } else {
                                TextField("Password", text: $viewModel.password)
                                    .autocapitalization(.none)
                                    .padding(.leading, 30)
                                    .foregroundColor(viewModel.isPasswordValid ? .primary : .red)
                                    .frame(height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.orange.opacity(0.1))
                                            .padding(.leading, 15)
                                    )
                                    .padding(.top,10)
                            }
                            
                Button(action: {
                    viewModel.togglePasswordVisibility()
                }) {
                    Image(systemName: viewModel.isPasswordHidden ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .padding(.top,10)
                }
                .padding(.trailing, 8)
                .frame(width: 35, height: 50)

                        }
            
            Button(action: {
                            viewModel.login()
                        }) {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 40)
                                .font(.headline)
                                .foregroundColor(.white)
                                .background(viewModel.isValidCredentials ? Color.blue : Color.gray)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 15)
                        .padding(.top,10)
                        .disabled(!viewModel.isValidCredentials)
            .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Login Failed"), message: Text("Please check your email and password."), dismissButton: .default(Text("OK")))
                    }
            
            Spacer()
            
            VStack {
                Spacer()
                Text("Powered by Eraspace.com")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
            }
        }
        .padding(.bottom, 0)
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LoginViewModel()
        return LoginView(viewModel: viewModel)
    }
}
