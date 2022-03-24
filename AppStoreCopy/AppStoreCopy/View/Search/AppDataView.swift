//
//  AppView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/18.
//

import SwiftUI

struct AppDataView: View {
    var AppData : AppDataInfo?
    @State var showAppDatail = false
    var body: some View {
        let digit: Double = pow(10, 1)
        VStack
        {
            HStack
            {
                HStack(alignment: .top)
                {
                    CustomImageView(urlString: AppData!.artworkUrl100!,width: 60,height: 60)
                    
                    VStack(alignment: .leading, spacing: 0)
                    {
                        Text(AppData!.trackCensoredName!)
                            .lineLimit(1)
                            .padding(.bottom,3)
                            .foregroundColor(Color.black)
                        Text(AppData!.primaryGenreName!)
                            .font(.system(size: 12)).foregroundColor(Color.secondary)
                            .padding(.bottom,6)
                        
                        HStack
                        {
                            FiveStarView(rating: Decimal(round(AppData!.averageUserRating! * digit) / digit))
                            
                            Text(changeRating(rating: AppData!.userRatingCount!))
                                .font(.system(size: 12,weight: .bold)).foregroundColor(.gray.opacity(0.4))
    
                        }

                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                
                
                Button(action: {
                   OpenApp()
                }) {
                    HStack {
                        Text("열기")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                    }
                    .padding(.vertical,5)
                    .frame(width:70)
                    .background(ThemeColor.btn_bg.getSwiftUIColor())
                    .cornerRadius(40)
                    
                }
            }
            .padding(.bottom,7)
            
            HStack(alignment: .center)
            {
                
                ForEach(0..<AppData!.screenshotUrls!.count){ index in
                    if index < 3
                    {
                        CustomImageView(urlString: AppData!.screenshotUrls![index],width: UIScreen.main.bounds.width/3,height: 255)
                            
                    }
                }
      
            }
            .padding(.horizontal)
            
        }
        .padding()
        .background(Color.white)
        .onTapGesture {
            showAppDatail = true
        }
        
        
        NavigationLink(destination: AppDetailView(AppData: AppData),isActive: $showAppDatail)
        {
            EmptyView()
        }
     
           
        
    }
    
    func OpenApp()
    {
        let kakao = "kakaoBank://"
               //URL 인스턴스를 만들어 주는 단계
               let kakaoURL = NSURL(string: kakao)
               
               
               //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
               if (UIApplication.shared.canOpenURL(kakaoURL! as URL)) {
           
                   //open(_:options:completionHandler:) 메소드를 호출해서 카카오톡 앱 열기
                   UIApplication.shared.open(kakaoURL! as URL)
               }
               //사용 불가능한 URLScheme일 때(카카오톡이 설치되지 않았을 경우)
               else {
                   print("No kakaoBack installed.")
               }
    }
    
    func changeRating(rating : Int) -> String
    {
        let stringArray = String(rating).compactMap({$0.wholeNumberValue}).map { String($0) }
       
        
        switch stringArray.count
        {
        case 4 : return "\(round(Double(rating) / Double(1000)))천"
            
        case 5 : return "\(round(Double(rating) / Double(1000)) / 10)만"
           
        case 6 : return "\(round(Double(rating) / Double(1000)) / 10)만"
            
        case 7 : return "\(round(Double(rating) / Double(1000)) / 10)만"
           
        default:
            return "\(rating)"
        }
        
        
        
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppDataView()
    }
}

