//
//  CustomDivder.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/23.
//

import SwiftUI

struct CustomDivder: View {
    var edge : Edge.Set = .bottom
    var length : CGFloat = 10
    var body: some View {
        
        Divider()
            .frame(maxWidth:.infinity)
            .padding(.horizontal,20)
            .padding(edge,length)
    }
}

struct CustomDivder_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivder()
    }
}
