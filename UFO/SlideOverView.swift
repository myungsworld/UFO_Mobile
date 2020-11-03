//
//  SlideOverView.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/28.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import SwiftUI

struct SlideOverView<Content>: View where Content : View {
    
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ModifiedContent(content: self.content(), modifier: CardView())
    }
}

struct CardView: ViewModifier {
    @State private var dragging = false
    @GestureState private var dragTracker: CGSize = CGSize.zero
    @State private var position: CGFloat = UIScreen.main.bounds.height/1.8
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 2.5)
                    .frame(width: 40, height: 5.0)
                    .foregroundColor(Color.secondary)
                    .padding(10)
                content.padding(.top, 30)
            }
            .frame(minWidth: UIScreen.main.bounds.width)
            .scaleEffect(x: 1, y: 1, anchor: .center)
            .background(Color.white)
            .cornerRadius(15)
        }
        .offset(y: max(0, position + self.dragTracker.height))
        .animation(dragging ? nil : {
            Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)
        }())
        .gesture(DragGesture()
            .updating($dragTracker) { drag, state, transaction in state = drag.translation }
            .onChanged { _ in self.dragging = true}
            .onEnded(onDragEnded))
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        dragging = false
        let high = UIScreen.main.bounds.height / 1.8
        let low: CGFloat = 100
        let dragDirection = drag.predictedEndLocation.y - drag.location.y
        
        if dragDirection > 0 {
            position = high
        } else {
            position = low
        }
    }
}

//struct SlideOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        SlideOverView()
//    }
//}
