//
//  PermissionsViewModel.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 24/02/25.
//


import Foundation
import Photos
import CoreLocation
import AVFoundation

class PermissionsViewModel: ObservableObject {
    @Published var cameraGranted = false
    private var locationManager = LocationManager()
    
    
    var areAllPermissionsGranted: Bool {
        return cameraGranted && locationManager.showLocationAlert
    }
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                self.cameraGranted = granted
            }
        }
    }
    func requestLocationAccess() {
        locationManager.requestLocation()
        
    }
}

