//
//  Object_DetectorApp.swift
//  Object Detector
//
//  Created by Vurukuti Dheeraj on 2/17/25.
//

import SwiftUI
import Firebase


@main
struct Object_DetectorApp: App {
    
    init(){
        FirebaseApp.configure()
        print("Configured Firebase")
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
