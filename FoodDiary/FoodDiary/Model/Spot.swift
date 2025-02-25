//
//  Task.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 25/02/25.
//

import SwiftUI

struct Spot: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var image: UIImage?
    var latitude: Double?
    var longitude: Double?
}
