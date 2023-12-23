import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    @StateObject private var homeModel = HomeViewModel()
    @StateObject private var profileModel = ProfileViewModel()
    
    var body: some View {
        let hasUserData = UserDefaults.standard.data(forKey: "userData").flatMap {
            try? JSONDecoder().decode(UserData.self, from: $0)
        } != nil
        
        if hasUserData {
            HomeView(homeViewModel: homeModel, profileViewModel: profileModel)
                .onReceive(homeModel.$shouldNavigateToHome) { shouldNavigate in
                    if !shouldNavigate {
                        homeModel.isLoggedIn = false
                    }
                }
        } else {
            LoginView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
