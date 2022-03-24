//
//  InformationView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import SwiftUI


struct InformationView: View {
  
    var infoArray:Array<String> = ["제공자","크기","카테고리","호환성","언어","연령등급","저작권"]
    var appData : AppDataInfo?
    var body: some View {
        VStack
        {
            Customtitle(title: "정보")
                .padding(.bottom,10)
            
            
            infoview(infotype: infoArray[0], data: appData!.sellerName!)
            infoview(infotype: infoArray[1], data: "273.3MB")
            infoview(infotype: infoArray[2], data: appData!.genres![0])
            infoview(infotype: infoArray[3], data: "이 iPhone와(과) 호환")
            infoview(infotype: infoArray[4], data: "한국어")
            infoview(infotype: infoArray[5], data: appData!.contentAdvisoryRating!)
            infoview(infotype: infoArray[6], data: appData!.sellerName!)
          
            
            
            
        }
        .padding(.horizontal,20)
        
       
    }
}

struct infoview : View
{
    var infotype = ""
    var data = ""
    var body: some View
    {
        HStack
        {
            Text(infotype)
                .font(.system(size: 15))
                .foregroundColor(.black.opacity(0.7))
            
            Spacer()
            
            Text(data)
                .font(.system(size: 15))
        }
        
        Divider()
            .padding(.vertical,5)
            .padding(.bottom,3)
        
    }
}


struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
