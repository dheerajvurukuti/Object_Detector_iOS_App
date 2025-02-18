//
//  LoginView.swift
//  Object Detector
//
//  Created by Vurukuti Dheeraj on 2/17/25.
//

//import SwiftUI
//import FirebaseAuth
//
//struct LoginView: View {
//    @State private var email = ""
//    @State private var password = ""
//    @State private var showError = false
//    @State private var errorMessage = ""
//    @State private var isLoginComplete = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Login")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//
//            Spacer()
//
//            TextField("Email", text: $email)
//                .keyboardType(.emailAddress)
//                .autocapitalization(.none)
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(8)
//
//            SecureField("Password", text: $password)
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(8)
//
//            Button(action: login) {
//                Text("Login")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal)
//
//            if showError {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .multilineTextAlignment(.center)
//                    .padding()
//            }
//
//            Spacer()
//
//            NavigationLink(destination: MainPageView(), isActive: $isLoginComplete) {
//                EmptyView()
//            }
//        }
//        .padding()
//    }
//
//    func login() {
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            if let error = error {
//                showError = true
//                errorMessage = error.localizedDescription
//            } else {
//                isLoginComplete = true
//            }
//        }
//    }
//}

// --UI--

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isLoginComplete = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Title
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                Spacer()

                // Input fields
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding(.horizontal)

                // Login button
                Button(action: login) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                }
                .padding(.horizontal)

                // Error message
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()

                // Navigation to main page after successful login
                NavigationLink(destination: MainPageView(), isActive: $isLoginComplete) {
                    EmptyView()
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                showError = true
                errorMessage = error.localizedDescription
            } else {
                isLoginComplete = true
            }
        }
    }
}



#Preview {
    LoginView()
}
