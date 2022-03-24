//
//  ReleaseAppView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import SwiftUI

struct ReleaseAppView: View {
    var AppData : AppDataInfo?
    var body: some View {
        ScrollView(showsIndicators: false)
        {
            LazyVStack
            {
                Divider()
                    .padding(.top,20)
                
                DetailReleaseApp(title: "최신 출시 앱")
                
                
                Divider()
                    .padding(.top,10)
                DetailReleaseApp(title: "앱")
                
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(AppData!.sellerName!)
            .padding(.horizontal,20)
        }
    }
    
    @ViewBuilder
    func DetailReleaseApp(title:String) -> some View
    {
        
        VStack(alignment: .leading)
        {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack
            {
                
                CustomImageView(urlString: AppData!.artworkUrl100!,width: 60,height: 60)
                VStack(alignment: .leading)
                {
                    Text(AppData!.trackCensoredName!)
                    Text(AppData!.primaryGenreName!)
                        .font(.system(size: 12)).foregroundColor(Color.secondary)
                }
                Spacer()
                
                Image(systemName: "icloud.and.arrow.down")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 25, height: 23)
                    .font(Font.title.weight(.medium))
                    .padding(.trailing,25)
               
            }
            
        }
        .frame(maxWidth:.infinity)
        
        
        
    }
}




struct ReleaseAppView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseAppView()
    }
}
