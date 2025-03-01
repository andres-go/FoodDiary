//
//  TaskDetailView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 25/02/25.
//

import SwiftUI
import MapKit
struct SpotDetailView: View {
    var spot: Spot
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGray5)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 5) {
                    Text(spot.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.foodGreen)
                        .cornerRadius(12)
                    
                    ZStack {
                        Color(.foodGreen)
                            .frame(height: 3)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .opacity(0.05)
                            .frame(width: CGFloat(spot.review)*32)
                            .padding(.top, 25)
                        HStack {
                            ForEach(0 ..< spot.review, id: \.self) { star in
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    .padding(.top, -5)
                    .padding(.bottom, 30)
                    
                    VStack() {
                        Text(spot.description)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(10)
                    }
                    .frame(width: 350, height: 100, alignment: .topLeading)
                    .background(.foodGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(.systemGray3), radius: 4, x: 5, y: 5)
                    
                    VStack() {
                        
                        if let image = spot.image {
                            Text("My tasty food:")
                                .font(.title2)
                                .bold(true)
                                .foregroundStyle(.foodGreen)
                            
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .frame(height:300)
                                .shadow(color: Color(.systemGray2), radius: 2, x: 3, y: 3)
                        }
                    }
                    .padding()
                    
                    if let latitude = spot.latitude, let longitude = spot.longitude {
                        ZStack {
                            Color.foodGreen
                                .ignoresSafeArea()
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                            VStack {
                        // Mostrar la ubicación utilizando un mapa:
                                let coords = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                                
                                Text("Where I got it:")
                                    .font(.title2)
                                    .bold(true)
                                    .foregroundStyle(.white)
                                Map(initialPosition: MapCameraPosition.region(coords)) {
                                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                                    {
                                        if spot.image != nil {
                                            Image(uiImage: spot.image!)
                                                .resizable()
                                                .frame(width:40, height: 40)
                                                .clipShape(Circle())
                                        } else {
                                            Image(systemName: "mappin.circle.fill")
                                                .resizable()
                                                .frame(width:40, height: 40)
                                                .clipShape(Circle())
                                        }
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 320, height: 300)
                                .shadow(color: Color(.systemGray2), radius: 2, x: 3, y: 3)
                            }
                                .frame(width: 370)
                                .padding(.top, 20)
                                .padding(.bottom, 40)
                        }
                    }
                }
                .padding()
            }
        } 
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                
                    Button(action: {
                        dismiss()
                    }){
                        Image(systemName: "arrowshape.backward.fill")
                            .foregroundStyle(.foodGreen)
                    
                }
            }
        }
        .toolbarBackgroundVisibility(.hidden)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SpotDetailView(spot: Spot(title: "Ejemplo de spot", description: "Dato falso ", review: 5, image: .burger, latitude: 40.7128, longitude: -74.0060)
    )
}
