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
    @Published var locationGranted = false
    private var locationManager = LocationManager()
    
    init() {
        self.locationManager.$status
            .assign(to: &self.$locationGranted)
    }
    
    var areAllPermissionsGranted: Bool {
        return cameraGranted && locationGranted
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

