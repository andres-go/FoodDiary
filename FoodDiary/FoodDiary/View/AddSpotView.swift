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
    
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    @State private var review = 1
    @State private var image: UIImage?
    
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    // map states
    @State private var locationManager = LocationManager()
    @State private var userLatitude: Double?
    @State private var userLongitude: Double?
    
    var body: some View {
        NavigationView{
            VStack {
                
                // Header (Could be its own view)
                ZStack {
                    Color.foodGreen
                        .clipShape(.rect(bottomLeadingRadius: 10, bottomTrailingRadius: 10))
                        .shadow(color: Color(.systemGray3), radius: 4, x: 5, y: 5)
                        .ignoresSafeArea()
                    VStack {
                        // Title
                        HStack {
                            Text("Add a meal")
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        // Restaurant and description
                        TextField("Restaurant name", text: $title)
                            .frame(height: 35)
                            .padding(.horizontal, 10)
                            .background(Color(.white))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $description)
                                .frame(height: 100)
                                .padding(.horizontal, 8)
                                .background(Color(.white))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            if description.isEmpty {
                                Text("Food decription")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(.systemGray3))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                            }
                        }
                        
                        // Review your meal
                        Spacer()
                        Text("How was your meal?")
                            .foregroundStyle(.white)
                            .bold()
                        ReviewView(review: $review)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 330)
                Spacer()
                 
                
                // Additional stuff
                // image and camera
                VStack{
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    }
                    
                    Button("Agregar foto") {
                        sourceType = .camera  // Use the camera
                        showImagePicker = true
                    }
                    .padding()
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $image, sourceType: sourceType)
                    }
                }
                // Map
                Section(header: Text("Choose Location")) {
                    Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                        .frame(height: 200)

                }
                
                
                // Photo Library
                Button(action: {
                    
                }) {
                    Label("Select an image", systemImage: "photo")
                }
                
                if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height:200)
                            .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
                
                // Saves the "spot" in the array of spots
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        spotViewModel.add(title: title, description: description, review: review, image: image, latitude: userLatitude, longitude: userLongitude)
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    AddSpotView(spotViewModel: SpotViewModel())
}
