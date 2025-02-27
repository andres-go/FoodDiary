//
//  ListView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 25/02/25.
//

import SwiftUI
struct ListView: View {
    
    @ObservedObject var spotsViewModel = SpotViewModel()
    @State private var showAddTaskView:Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(spotsViewModel.spots) { spot in
                    NavigationLink(destination: SpotDetailView(spot: spot)) {
                        Text(spot.title)
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Lista de Spots")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showAddTaskView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddTaskView) {
                AddSpotView(spotViewModel: spotsViewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func deleteTask(at offset: IndexSet) {
        spotsViewModel.delete(offset: offset)
    }
}

#Preview {
    ListView(spotsViewModel: SpotViewModel())
}
