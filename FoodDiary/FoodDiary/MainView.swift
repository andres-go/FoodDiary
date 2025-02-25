//
//  MainView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 24/02/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var permissionsModel = PermissionsViewModel()
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        NavigationView() {
            VStack(spacing:30) {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Please accept the following agreements to use the app.")
                    .multilineTextAlignment(.center)
                VStack(spacing:20) {
                    Button(action: {
                        permissionsModel.requestCameraAccess()
                    }) {
                        Text("Camera access.")
                    }
                    .disabled(permissionsModel.cameraGranted)
                    
                    Button(action: {
                        permissionsModel.requestLocationAccess()
                    }) {
                        Text("Location access.")
                    }
                    .disabled(locationManager.showLocationAlert)
                }
                Spacer()
                NavigationLink(destination: ContentView()) {
                    Text("Next")
                }
                .disabled(!permissionsModel.areAllPermissionsGranted)
            }
        }
    }
}

#Preview {
    MainView()
}
