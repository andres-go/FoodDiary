//
//  ListView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 25/02/25.
//

import SwiftUI
struct ListView: View {
    @Namespace var namespace
    
    @ObservedObject var spotsViewModel = SpotViewModel()
    @State private var showAddTaskView:Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Color.foodGreen
                        .ignoresSafeArea()
                    VStack {
                        // Title
                        Text("Saved Spots")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .foregroundStyle(.white)
                            .padding(.top, -20)
                    }
                }
                .frame(height: 80)
                List {
                    ForEach(spotsViewModel.spots) { spot in
                        NavigationLink(destination: SpotDetailView(spot: spot)) {
                            HStack {
                                Text(spot.title)
                                    .foregroundStyle(.foodGreen)
                                    .bold()
                                Spacer()
                                ForEach(0..<spot.review, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .frame(width: 10, height: 10)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: AddSpotView(spotViewModel: spotsViewModel)) {
                            Button(action: {
                                showAddTaskView = true
                            }){
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                            .foregroundStyle(.white)
                    }
                }
                .sheet(isPresented: $showAddTaskView) {
                    AddSpotView(spotViewModel: spotsViewModel)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func deleteTask(at offset: IndexSet) {
        spotsViewModel.delete(offset: offset)
    }
}

extension UIWindow {
    open override func didAddSubview(_ subview: UIView) {
        if !(backgroundColor == nil) {
            backgroundColor = UIColor(Color.foodGreen.mix(with: .black, by: 0.2))
        } else {
            backgroundColor = .clear
        }
    }
}

#Preview {
    ListView(spotsViewModel: SpotViewModel())
}
