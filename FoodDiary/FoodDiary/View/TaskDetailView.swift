//
//  TaskDetailView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 25/02/25.
//

import SwiftUI
import MapKit
struct TaskDetailView: View {
    var task: Spot
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(task.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(12)
                    .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Descripción de mi trabajo")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Text(task.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding()
                    if let image = task.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height:200)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    // Mostrar la ubicación utilizando un mapa:
                    if let latitude = task.latitude, let longitude = task.longitude {
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
    TaskDetailView(task: Spot(title: "Ejemplo", description: "Ejemplo de una descripcion")
    )
}
