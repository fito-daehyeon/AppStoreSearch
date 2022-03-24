//
//  ActivityIndicator.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/22.
//

import SwiftUI


struct ActivityIndicator: UIViewRepresentable {
    let animated: Bool
    
    func makeUIView(context: Context) -> UIView {
        let ai = UIActivityIndicatorView()
        ai.startAnimating()
        ai.translatesAutoresizingMaskIntoConstraints = false

        let view = UIView()
        view.addSubview(ai)
        ai.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ai.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }

    func updateUIView(_ uiView: UIView,context: Context){}
}
