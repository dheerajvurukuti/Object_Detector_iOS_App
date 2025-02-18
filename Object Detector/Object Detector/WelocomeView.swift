//
//  WelocomeView.swift
//  Object Detector
//
//  Created by Vurukuti Dheeraj on 2/17/25.
//

//import SwiftUI
//
//struct WelcomeView: View {
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Text("Welcome to Object Detector!")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding()
//
//                Spacer()
//
//                NavigationLink(destination: LoginView()) {
//                    Text("Login")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                }
//
//                NavigationLink(destination: SignupView()) {
//                    Text("Sign Up")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                }
//
//                Spacer()
//            }
//            .padding()
//            .navigationBarHidden(true)
//        }
//    }
//}

// --UI--


import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Text("Welcome to Object Detector!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: SignupView()) {
                        Text("Sign Up")
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
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}



#Preview {
    WelcomeView()
}
