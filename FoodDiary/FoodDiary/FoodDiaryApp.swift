//
//  FoodDiaryApp.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 24/02/25.
//

import SwiftUI

@main
struct FoodDiaryApp: App {
    @StateObject private var onboardingManager = StorageViewModel()
    var body: some Scene {
        WindowGroup {
            if onboardingManager.hasCompletedOnboarding {
                ListView()
            } else {
                Onboarding1View()
            }
        }
    }
}
