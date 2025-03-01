//
//  SpotViewModel.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 25/02/25.
//
import SwiftUI

class SpotViewModel: ObservableObject {
    // Default spots, delete on release
    @Published var spots: [Spot] = [
        Spot(title: "Ejemplo de spot", description: "Dato falso", review: 5, latitude: 40.7128, longitude: -74.0060),
    Spot(title: "Mala comida",
         description: "Terrible wakala~", review: 1)
    ];
    
    func add(title: String, description: String, review: Int, image: UIImage?, latitude: Double?, longitude: Double?) {
        spots.append(Spot(title: title, description: description, review: review, image: image, latitude: latitude, longitude: longitude))
    }
    func delete(offset: IndexSet) {
        spots.remove(atOffsets: offset)
    }
}
