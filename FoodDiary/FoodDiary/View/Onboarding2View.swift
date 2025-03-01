//
//  MainView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 24/02/25.
//

import SwiftUI
import MapKit

struct Onboarding2View: View {
    @StateObject private var permissionsModel = PermissionsViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        NavigationView() {
            ZStack {
                Color(.systemGray5)
                    .ignoresSafeArea()
                VStack(spacing:20) {
                    Spacer()
                    Text("Almost there!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.foodGreen)
                    Text("We require location access to store the location of the spots you visit and want to save.")
                        .padding(.horizontal, 60)
                        .multilineTextAlignment(.center)
                    
                    
                    ZStack(alignment:.bottomTrailing) {
                        Map()
                            
                        Image(systemName: "pin.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                            .padding(10)
                    }
                    
                    Button(action: {
                        permissionsModel.requestLocationAccess()
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
                    NavigationLink(destination: ListView()) {
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
    Onboarding2View()
}
