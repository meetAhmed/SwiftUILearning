//
// CustomShapesBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct CustomShapesBootcamp: View {
    var body: some View {
        VStack {
            Spacer()
            
            Triangle()
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .square, dash: [10]))
                .foregroundColor(.yellow)
                .frame(width: 150, height: 150)
            
            Spacer()
            
            Image("image")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(
                    Triangle()
                        .rotation(Angle(degrees: 180))
                )
            
            Spacer()
            
            Diamond()
                .fill(LinearGradient(colors: [.red, .green, .blue], startPoint: .leading, endPoint: .trailing))
                .frame(width: 150, height: 150)
            
            Spacer()
        }
    }
}

struct CustomShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesBootcamp()
    }
}
