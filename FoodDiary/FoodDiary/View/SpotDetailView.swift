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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(spot.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.foodGreen)
                    .cornerRadius(12)
                ZStack(alignment: .center) {
                    Color(.foodGreen)
                        .frame(height: 45)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    HStack {
                        ForEach(0 ..< spot.review, id: \.self) { star in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .frame(width: CGFloat(spot.review)*40+20)
                VStack() {
                    Text(spot.description)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(5)
                }
                .frame(height: 100, alignment: .topLeading)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack {
                    if let image = spot.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height:200)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    // Mostrar la ubicación utilizando un mapa:
                    if let latitude = spot.latitude, let longitude = spot.longitude {
                        let coords = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                        Map(initialPosition: MapCameraPosition.region(coords)) {
                            Annotation("", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                            {
                                Image(.burger)
                                    .resizable()
                                    .frame(width:40, height: 40)
                                    .clipShape(Circle())
                            }
                        }
                        .frame(height: 200)
                    }
                    
                }
            }
            .padding()
        }
        .background(Color(.systemGray5))
        .navigationTitle("Task Details")
    }
}

#Preview {
    SpotDetailView(spot: Spot(title: "Ejemplo de spot", description: "Dato falso aaaaaaaaaa  aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa", review: 5, latitude: 40.7128, longitude: -74.0060)
    )
}
