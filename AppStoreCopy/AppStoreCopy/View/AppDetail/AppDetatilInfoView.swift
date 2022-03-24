//
//  AppDetatilInfoView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import SwiftUI

struct AppDetatilInfoView : View
{
    var ratring = ""
    var AppData : AppDataInfo
    let digit: Double = pow(10, 1) // 10의 3제곱
    var body: some View
    {
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack(alignment: .top,spacing:0)
            {
                VStack(alignment: .leading)
                {
                    HStack(spacing:0)
                    {
                        Text("\(String(format: "%.1f",round(AppData.averageUserRating! * digit) / digit))")
                            .font(.system(size: 23,design: .rounded))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .frame(maxWidth:.infinity)
                        
                        FiveStarView(rating: Decimal(string: "\(round(AppData.averageUserRating! * digit) / digit)")!,size: 16)
                            .foregroundColor(.secondary)
                            .padding(.horizontal,10)
                    }
                    
                    Text(ratring)
                        .font(.system(size: 13,weight: .medium)).foregroundColor(.gray.opacity(0.4))
                }
               
                VStack
                {
                    HStack(alignment: .top,spacing:0)
                    {
                        Text("#")
                            .font(.system(size: 15,design: .rounded))
                            .fontWeight(.semibold)
                        Text("2")
                            .font(.system(size: 23,design: .rounded))
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    
                    Text(AppData.genres![0])
                        .font(.system(size: 13,weight: .medium)).foregroundColor(.gray.opacity(0.4))
                }
                .padding(.horizontal,50)
                
                VStack
                {
                    HStack(alignment: .top,spacing:0)
                    {
                        Text(AppData.contentAdvisoryRating!)
                            .font(.system(size: 23,design: .rounded))
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    
                    Text("연령")
                        .font(.system(size: 13,weight: .medium)).foregroundColor(.gray.opacity(0.4))
                }
                .padding(.horizontal,50)
                
                
                if !AppData.languageCodesISO2A!.isEmpty
                {
                    VStack
                    {
                       
                        HStack(alignment: .top,spacing:0)
                        {
                            Text(AppData.languageCodesISO2A![0])
                                .font(.system(size: 23,design: .rounded))
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.gray)
                        
                        Text("언어")
                            .font(.system(size: 13,weight: .medium)).foregroundColor(.gray.opacity(0.4))
                    }
                    .padding(.horizontal,50)
                }
              
 
                
//                AppDetatilInfoView(data: "person.crop.square", type: AppData.sellerName!)
//                if !AppData.languageCodesISO2A!.isEmpty
//                {
//
//                    AppDetatilInfoView(data: AppData.languageCodesISO2A![0] ,type: "한국어")
//                }
      
            }
            .padding(.horizontal,20)
            
        }
        .padding(.top,10)
       
       
       
    }
}
