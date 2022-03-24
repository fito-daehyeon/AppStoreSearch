//
//  RatingStar.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/18.
//

import SwiftUI


public struct FiveStarView: View {
    var rating: Decimal
    var color: Color
    var backgroundColor: Color
    var size: CGFloat


    public init(
        rating: Decimal,
        color: Color = .gray,
        backgroundColor: Color = .gray,
        size : CGFloat = 12
        
    ) {
        self.rating = rating
        self.color = color
        self.backgroundColor = backgroundColor
        self.size = size
    }


    public var body: some View {
        ZStack {
            BackgroundStars(backgroundColor,size: size)
            ForegroundStars(rating: rating, color: color,size: size)
        }
       
    }
}


struct RatingStar: View {
    var rating: CGFloat
    var color: Color
    var index: Int
    
    
    var maskRatio: CGFloat {
        let mask = rating - CGFloat(index)
        
        switch mask {
        case 1...: return 1
        case ..<0: return 0
        default: return mask
        }
    }


    init(rating: Decimal, color: Color, index: Int) {
        
        self.rating = CGFloat(Double(rating.description) ?? 0)
        self.color = color
        self.index = index
    }


    var body: some View {
        GeometryReader { star in
            StarImage()
                .foregroundColor(self.color)
                .mask(
                    Rectangle()
                        .size(
                            width: star.size.width * self.maskRatio,
                            height: star.size.height
                        )
                    
                )
                
        }
    }
}


private struct StarImage: View {


    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
          
            
    }
}

private struct BackgroundStars: View {
    var color: Color
    var size : CGFloat

    init(_ color: Color,size:CGFloat) {
        self.color = color
        self.size = size
    }


    var body: some View {
        HStack(spacing:3) {
            ForEach(0..<5) { _ in
                Image(systemName: "star")
                    .resizable()
                    .frame(width: size, height: size)
            }
        }.foregroundColor(color)
    }
}


private struct ForegroundStars: View {
    var rating: Decimal
    var color: Color
    var size : CGFloat


    init(rating: Decimal, color: Color,size:CGFloat) {
        self.rating = rating
        self.color = color
        self.size = size
    }


    var body: some View {
        HStack(spacing:3) {
            ForEach(0..<5) { index in
                RatingStar(
                    rating: self.rating,
                    color: self.color,
                    index: index
                )
                    .frame(width: size, height: size)
            }
        }
    }
}
