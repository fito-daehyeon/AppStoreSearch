//
//  AppDetail.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/19.
//

import SwiftUI

struct AppDetailView: View {
    var AppData : AppDataInfo?
    @StateObject var viewModel = AppDetailModel()
    
    var body: some View {
        ZStack
        {
            ScrollView
            {
                VStack
                {
                    Group
                    {
                        //타이틀
                        title()
                        
                        //앱 정보
                        AppDetatilInfoView(ratring: "\(viewModel.changeRating(rating: AppData!.userRatingCount!))개의 평가",AppData: AppData!)
                            
                        CustomDivder(edge: .bottom, length: 10)
                        
                        //새로운 기능
                        versionInfo()
                        
                        //미리보기
                        PreView(appData: AppData!.screenshotUrls!)
                           
                        
                        CustomDivder(edge: .bottom, length: 10)
                        
                    }
                    

                    Group
                    {
                        //앱 설명
                        descriptionview()
                        
                        CustomDivder(edge: .top, length: 20)
                        
                        //평가 및 리뷰
                        ratingsandReviews()
                        
                        //앱 개인정보 보호
                        PersonalinfoView(AppData:AppData)
                        
                        
                        CustomDivder(edge: .top, length: 20)
                        
                        //정보
                        InformationView(appData: AppData)
                    }
                       
                           
                    
                    
                }
                .padding(.top)
                .navigationBarTitle {
                    
                    HStack {
                        
                        CustomImageView(urlString: AppData!.artworkUrl512!,width: 25,height: 25,cornerRadius: 5)
                        
                    }
                    .transition(.move(edge: .bottom))
                    .opacity(viewModel.customtitlebar ? 1 : 0).animation(.easeIn,value: 1)
                    
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing)
                    {
                        Button(action: {
                            viewModel.OpenApp()
                            
                        }) {
                            HStack {
                                Text("열기")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical,5)
                            .frame(width:70)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                            .opacity(viewModel.customtitlebar ? 1 : 0).animation(.easeIn,value: 1)
                        }
                        .disabled(!viewModel.customtitlebar)
                    }
                   
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                
            }
            .frame(minWidth:0,maxWidth:.infinity,minHeight: 0,maxHeight: .infinity,alignment: .leading)
            
            //평점 클릭시 팝업창 호출
            if viewModel.popupview
            {
                PopUpView()
                    .padding(.horizontal,60)
                    .onReceive(viewModel.timer, perform: { _ in
                        if viewModel.timerrunning > 0
                        {
                            viewModel.timerrunning -= 1
                        }
                        else
                        {
                            viewModel.popupview = false
                        }
                    })
            }
            
        }
        
        
    }
    
    //MARK: 타이틀
    @ViewBuilder
    func title() -> some View
    {
        //타이틀
        GeometryReader { g in
            HStack(spacing:17)
            {
                CustomImageView(urlString: AppData!.artworkUrl512!,width: 120,height: 120,cornerRadius: 25)
                    .frame(width: 120, height: 120)
                    .cornerRadius(25)
                   
                
                VStack(alignment: .leading,spacing: 0)
                {
                    Text(AppData!.trackName!)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom,2)
                        .padding(.top,5)
                    
                    Text(AppData!.artistName!)
                        .foregroundColor(Color.secondary)
                        .font(.system(size: 15))
                    
                    Spacer()
                    
                    HStack
                    {
                        
                        Button(action: {
                            viewModel.OpenApp()
                        }) {
                            HStack {
                                Text("열기")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical,5)
                            .frame(width:70)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                            
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.ShareButton()
                        }, label: {
                            Image(systemName: "ellipsis.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 25, height: 25)
                                .font(Font.title.weight(.medium))
                        })
                        
                        
                    }
                    
                }
                
                Spacer()
            }
            .frame(height:(UIScreen.main.bounds.height / 7.5))
            .opacity(viewModel.customtitlebar ? 0 : 1).animation(.easeIn,value: 1)
            .onReceive(viewModel.titlepositiontimer, perform: { _ in
                //실시간으로 스크롤 감지
                let y = g.frame(in: .global).minY
                
                if  -y > (UIScreen.main.bounds.height / 7.5) - (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top)! - 65
                {
                    viewModel.customtitlebar = true
                }
                else
                {
                    viewModel.customtitlebar = false
                }
                
            })
            
        }
        .frame(height:(UIScreen.main.bounds.height / 7.5))
        .padding(.bottom,10)
        .padding(.leading,20)
    }
    
    //MARK: 새로운기능
    @ViewBuilder
    func versionInfo() -> some View
    {
        VStack(alignment:.leading,spacing:10)
        {
            HStack
            {
                Customtitle(title: "새로운 기능")
                    .padding(.horizontal,20)
                
                Spacer()
                
                
                NavigationLink(destination: {
                    VersionView(AppData: AppData).environmentObject(self.viewModel)
                }, label: {
                    Text("버전기록")
                })
                    .padding(.horizontal,20)
                
                
            }
            
            HStack
            {
                Text("버전\(AppData!.version!)")
                    .foregroundColor(.gray)
                
                Spacer()
                
                
                Text(viewModel.compareDate(appversion: AppData!.currentVersionReleaseDate!))
                    .foregroundColor(.gray)
            }
            .font(.system(size: 17))
            .padding(.horizontal,20)
            
            
            LazyVStack
            {
                AddContentView(limit: $viewModel.addlinelimit, content: AppData!.releaseNotes!)
                
            }
            .padding(.horizontal,20)
            
            
        }
        
    }
    
    //MARK: 내용
    @ViewBuilder
    func descriptionview() -> some View
    {
        LazyVStack
        {
            AddContentView(limit: $viewModel.descriptionlimit, content: AppData!.description!)
            
            
            NavigationLink(destination: {
                ReleaseAppView(AppData: AppData!)
            }, label: {
                VStack(alignment: .leading)
                {
                    HStack
                    {
                        Text(AppData!.sellerName!)
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                    }
                    Text("개발자")
                        .font(.system(size: 17))
                        .foregroundColor(.gray.opacity(0.8))
                }
                
            })
                .padding(.top,15)
            
            
        }
        .padding(.horizontal,20)
        
    }
    
    //MARK: 평가 및 리뷰
    @ViewBuilder
    func ratingsandReviews() -> some View
    {
        VStack(alignment: .leading,spacing:0)
        {
            
            VStack
            {
                HStack
                {
                    Customtitle(title: "평가 및 리뷰")
                    
                    NavigationLink(destination: {
                        
                    }, label: {
                        Text("모두 보기")
                    })
                    
                }
                
                
                HStack(alignment: .center)
                {
                    VStack
                    {
                        
                        Text("\(String(format: "%.1f",round(AppData!.averageUserRating! * viewModel.digit) / viewModel.digit))")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundColor(.black.opacity(0.7))
                        
                        Text("(최고 5점)")
                            .font(.system(size: 15,weight: .bold,design: .rounded))
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding(.trailing,50)
                    
                    
                    
                    VStack(alignment: .trailing)
                    {
                        AddStar()
                            .padding(.top,8)
                        
                        
                        Text("\(viewModel.numberFormatter(number: AppData!.userRatingCount!))개의 평가")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                            .padding(.top,7)
                    }
                    .frame(maxWidth:.infinity)
                    
                }
                
                
                Divider()
                    .padding(.vertical)
                    .padding(.top,5)
            }
            .padding(.horizontal,20)
            
            
            TabStar()
            {
                viewModel.popupview = true
            }
            .padding(.horizontal,20)
            
            PageView()
                .frame(height: 160)
            
            
            HStack
            {
                Button(action: {
                    
                }, label: {
                    HStack
                    {
                        Image(systemName: "square.and.pencil")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 18, height: 18)
                            .font(Font.title.weight(.medium))
                        Text("리뷰 작성")
                    }
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack
                    {
                        Image(systemName: "questionmark.circle")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 18, height: 18)
                            .font(Font.title.weight(.medium))
                        Text("앱 지원")
                    }
                })
            }
            .padding(.horizontal,20)
            
            
            
        }
        
        
    }
}



struct AppDetail_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailView()
    }
}
