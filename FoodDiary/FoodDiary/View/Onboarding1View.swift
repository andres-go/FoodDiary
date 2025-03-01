//
//  MainView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 24/02/25.
//

import SwiftUI

struct Onboarding1View: View {
    @StateObject private var permissionsModel = PermissionsViewModel()
    var body: some View {
        NavigationStack() {
            ZStack {
                Color(.systemGray5)
                    .ignoresSafeArea()
                VStack(spacing:20) {
                    Spacer()
                    Text("Welcome!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.foodGreen)
                    Text("We require camera access to save the pictures of the meals you pick, at your favorite spots.")
                        .padding(.horizontal, 26)
                        .multilineTextAlignment(.center)
                    
                    
                    ZStack(alignment:.bottomTrailing) {
                        Image(.burger)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: Color(.systemGray2), radius: 2, x: 3, y: 3)
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                            .padding(10)
                    }
                    
                    Button(action: {
                        permissionsModel.requestCameraAccess()
                    }) {
                        ZStack {
                            Rectangle()
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .foregroundStyle(.white)
                                .shadow(color:  Color(.systemGray2), radius: !permissionsModel.cameraGranted ? 2 : 0, x: !permissionsModel.cameraGranted ? 3 : 0, y: !permissionsModel.cameraGranted ? 3 : 0)
                            VStack {
                                Text("Camera Access.")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.foodGreen)
                            }
                        }
                        .opacity(!permissionsModel.cameraGranted ? 1 : 0.3)
                        .frame(width: 280, height: 40)
                        .padding(.top, -10)
                        
                    }
                    .disabled(permissionsModel.cameraGranted)
                    
                    Spacer()
                    NavigationLink(destination: Onboarding2View()) {
                        ZStack {
                            Rectangle()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .foregroundStyle(permissionsModel.cameraGranted ? Color.foodGreen : Color.gray)
                                .shadow(color: Color(.systemGray2), radius: 2, x: 3, y: 3)
                            VStack {
                                Text("Next")
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .foregroundStyle(.white)
                            }
                        }
                        .frame(width: 180, height: 60)
                    }
                    .disabled(!permissionsModel.cameraGranted)
                    
                    Spacer()
                }
            }
            
        }
    }
}

#Preview {
    Onboarding1View()
}
