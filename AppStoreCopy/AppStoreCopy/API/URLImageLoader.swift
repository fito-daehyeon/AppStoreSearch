//
//  URLImageLoader.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/19.
//

import Foundation
import Combine
import SwiftUI


struct CustomImageView: View {
    var urlString: String
    @StateObject var imageLoader = ImageLoaderService()
    var width : CGFloat = 0
    var height : CGFloat = 0
    var cornerRadius : CGFloat = 10
 
    
    @State var image: UIImage = UIImage()
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(minWidth:0,maxWidth: width,minHeight: 0,maxHeight: height)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(for: urlString)
            }
    }
}

class ImageLoaderService: ObservableObject {
    @Published var image: UIImage = UIImage()
    
    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
    
}
