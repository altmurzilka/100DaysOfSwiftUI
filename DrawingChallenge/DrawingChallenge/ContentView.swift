//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by алтынпончик on 6/14/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ColorCyclingRect : View {
    
    var steps = 300
    var amount = 0.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors:
                        [self.color(for: value, brightness: 1),
                         self.color(for: value, brightness: 2)]),
                                                 startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)),
                                  lineWidth: 5)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct Arrow: Shape {
    
    var thichkness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let triangle = Triangle()
        let rectangle = Rectangle()
        
        path.addPath(triangle.path(in: CGRect(x: 0,
                                              y: 0,
                                              width: thichkness,
                                              height: rect.height / 2)))
        path.addPath(rectangle.path(in: CGRect(x: rect.width / 2 - rect.width / 4,
                                               y: rect.height / 2,
                                               width: thichkness / 2,
                                               height: rect.height / 3)))
        return path
    }
    
}

struct ContentView: View {
    
    @State private var thickness: CGFloat = 100
    @State private var borderWidth: CGFloat = 15
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            
            ZStack {
                ColorCyclingRect(amount: self.colorCycle)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Arrow(thichkness: thickness)
                        .stroke(Color.black, style: StrokeStyle(lineWidth: borderWidth, lineCap: .round))
                        .frame(width: thickness, height: 250)
                    
                    Text("Line Thickness")
                        .fontWeight(.bold)
                        .textStyle()
                    Slider(value: $borderWidth, in: 1...30).accentColor(Color.black)
                    
                    Text("Arrow Width")
                        .fontWeight(.bold)
                        .textStyle()
                    Slider(value: $thickness, in: 100...300).accentColor(Color.black)
                    
                    Text("Color")
                        .fontWeight(.bold)
                        .textStyle()
                    Slider(value: $colorCycle).accentColor(Color.black)
                    
                }.padding(40)
            }
        }
    }
}

struct TextStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(.title)
            .padding(.horizontal, 7)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

extension View {
    func textStyle() -> some View {
        self.modifier(TextStyling())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

