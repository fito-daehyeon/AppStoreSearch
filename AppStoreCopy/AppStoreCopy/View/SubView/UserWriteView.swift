//
//  UserWriteView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import SwiftUI

struct UserWriteView: View {
    var data : UserWriteData?
    var body: some View {
        
        VStack(alignment: .leading)
        {
            HStack
            {
                Text(data!.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(getDate())
                    .foregroundColor(.black.opacity(0.7))
            }
            HStack
            {
                FiveStarView(rating: Decimal(4),color: Color.orange,backgroundColor: Color.orange)
                
                Spacer()
                
                Text(data!.name)
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding(.bottom,10)
            
            Text(data!.content)
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        
    }
    
    func getDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        let current_date_string = formatter.string(from: Date())
        return current_date_string
    }
}

struct UserWriteView_Previews: PreviewProvider {
    static var previews: some View {
        UserWriteView()
    }
}
