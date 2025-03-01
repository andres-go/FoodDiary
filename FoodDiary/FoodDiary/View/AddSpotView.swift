//
//  AddTaskView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 25/02/25.
//


import SwiftUI
import MapKit

struct AddSpotView: View {
    @ObservedObject var spotViewModel: SpotViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    @State private var review = 1
    @State private var image: UIImage?
    
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    // Nuevos estados
    @State private var locationManager = LocationManager()
    @State private var userLatitude: Double?
    @State private var userLongitude: Double?
    
    var body: some View {
        NavigationView{
            VStack {
                // Restaurant and description
                TextField("Restaurant name", text: $title)
                TextField("Describe your meal", text: $description)
                        
                        
                // Photo Library
//                Button(action: {
//                    showImagePicker = true
//                    sourceType = .photoLibrary
//                }) {
//                    Label("Select an image", systemImage: "photo")
//                    
//                }
                    // Review your meal
                    Text("How was your meal?")
                    ReviewView(review: $review)
                    
                    if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height:200)
                                .frame(maxWidth: .infinity, alignment: .center)
                    }
            }
            .navigationTitle("Add new Task")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                // Saves the "spot" in the array of spots
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        spotViewModel.add(title: title, description: description, review: review, image: image, latitude: userLatitude, longitude: userLongitude)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    AddSpotView(spotViewModel: SpotViewModel())
}
