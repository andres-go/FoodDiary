//
//  ReviewView.swift
//  FoodDiary
//
//  Created by Nicolas Septien on 28/02/25.
//

import SwiftUI

struct ReviewView: View {
    @Binding var review: Int
    private let starWidth = 30.0
    private let padding = 5.0
    
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing:0) {
                    // Have a selector for the review system and change the fill for selected.
                    ForEach(0..<5) { index in
                        let isFilled = index < Int(review)
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(isFilled ? .yellow : Color(.systemGray6))
                            .frame(width: starWidth, height: starWidth)
                            .padding(.horizontal, padding)
                    }
                }
                .gesture(
                    // Draggable selection of stars
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let offset = 30+(padding*2)
                            let dragPosition = value.location.x + offset
                            let newRating = min(5,max(1,dragPosition/offset))
                            review = Int(newRating)
                        }
                )
            }
        }
    }
}


#Preview {
    @Previewable @State var review = 1
    ReviewView(review: $review)
}
