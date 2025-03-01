//
//  StorageViewModel.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 01/03/25.
//

import SwiftUI

class StorageViewModel: ObservableObject {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
}
