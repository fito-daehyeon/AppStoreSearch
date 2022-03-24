//
//  ThemeColor.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/18.
//

import SwiftUI


enum ThemeColor {
 
    case btn_bg

    
    func getUIColor() -> UIColor {
        switch self {
        case .btn_bg:
            return UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.00)
            
        }
    }
    
    func getSwiftUIColor() -> Color {
        return Color(self.getUIColor())
    }
}


extension View {
  func navigationBarTitle<Content>(
    @ViewBuilder content: () -> Content
  ) -> some View where Content : View {
    self.toolbar {
      ToolbarItem(placement: .principal, content: content)
    }
  }
}
