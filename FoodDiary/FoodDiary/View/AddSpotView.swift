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
                Form{
                    Section(header: Text("What is this Task about?")) {
                        TextField("Title", text: $title)
                        TextField("Description of the task", text: $description)
                    }
                    // Agrega el boton para agregar imagenes ya se de la galeria o de la camara.
                    Button(action: {
                        showImagePicker = true
                        sourceType = .photoLibrary
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
                    
                    //Mapa
//                    if locationManager.isAuthorized {
//                        Map(initialPosition: MapCameraPosition.region(locationManager.region))
//                            .frame(height: 200)
//                    }
                    
                }
            }
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(selectedImage: $image, sourceType: sourceType)
//            }
            .navigationTitle("Add new Task")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                // Recuerda guardar la ubicacion y la imagen cuando le pique save
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        spotViewModel.add(title: title, description: description, image: image, latitude: userLatitude, longitude: userLongitude)
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
