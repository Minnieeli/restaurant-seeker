//
//  Wheel.swift
//  Restaurant Seeker
//
//  Created by Minnie on 11/19/20.
//

import SwiftUI

struct Wheel: View {
    private var segments: Int = 7
    @State var angle = 0.0
    var offset = 0.0
    var colors = [Color.red, Color.blue, Color.yellow, Color.green]
    
    var body: some View {
        VStack {
            ZStack {
                ForEach((0..<segments), id: \.self) { n in
                    Segment(segments: self.segments, restaurant: String(n)).foregroundColor(self.colors[n%(self.colors.count)]).rotationEffect(Angle(degrees:Double(n)*360/Double(segments)+self.angle), anchor: .center)
                }
            }.animation(.easeInOut(duration:5))
        }
    }
}

struct Segment: View {
    let segments: Int
    let restaurant: String
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Arc(segments: self.segments)
                    Arc(segments: self.segments).stroke(lineWidth: 3.0).foregroundColor(.black)
                    
                    VStack {
                        Text(self.restaurant).foregroundColor(.black).lineLimit(3)
                            
                        .rotationEffect(Angle(degrees: 90.0)).frame(width: geometry.size.height/2, height: geometry.size.width/2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(y: 160)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct Arc: Shape {
    let segments: Int
    
    func path(in rect: CGRect) -> Path {
        var arcPath = Path()
        let angle = 360.0/Double(self.segments)
        let radius = CGFloat(Double(rect.size.height)/2.0)
        let center = CGPoint(x: rect.size.width/2, y: rect.size.height/2)
        arcPath.move(to: center)
        arcPath.addArc(center: center, radius: radius, startAngle: .degrees(270 - (angle/2)), endAngle: .degrees(270 + (angle/2)), clockwise: false)
        return arcPath
    }
}

struct Wheel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Wheel()
        }
    }
}
