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
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(12)
                HStack {
                    ForEach(0 ..< spot.review, id: \.self) { star in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Descripción de mi trabajo")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Text(spot.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding()
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
                        Map(initialPosition: MapCameraPosition.region(coords))
                        .frame(height: 200)
                    }
                    
                }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.2))
        .navigationTitle("Task Details")
    }
}

#Preview {
    SpotDetailView(spot: Spot(title: "Ejemplo", description: "Ejemplo de una descripcion",review: 4)
    )
}
