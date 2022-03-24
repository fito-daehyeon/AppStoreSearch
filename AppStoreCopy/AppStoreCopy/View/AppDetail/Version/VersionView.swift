//
//  VersionView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/20.
//

import SwiftUI

struct VersionView: View {
    var AppData : AppDataInfo?
    @EnvironmentObject var viewModel : AppDetailModel
    @State var addlinelimit : Int = 3
    var body: some View {
        
            ScrollView
            {
                LazyVStack
                {
                    Text("버전 기록")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
                    
                    Divider()
                        .padding(.bottom,5)
                    
                    
                    HStack
                    {
                        Text((AppData!.version!))
                            .bold()
                        
                        Spacer()
                        
                        
                        Text(viewModel.compareDate(appversion: AppData!.currentVersionReleaseDate!))
                            .foregroundColor(.gray)
                    }
                    .font(.system(size: 17))
                    
                    VStack(spacing:10)
                    {
                        
                        AddContentView(limit: $addlinelimit, content: AppData!.releaseNotes!)
                         
                        
                    }
                    
                    
                    
                    Spacer()
                    
                }
                .padding(.horizontal,20)
                
            }
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
           
        
       
        
    }

    
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView()
    }
}
