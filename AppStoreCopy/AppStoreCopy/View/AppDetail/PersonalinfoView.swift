//
//  PersonalinformationVIew.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import SwiftUI

struct PersonalinfoView: View {
    
    var AppData : AppDataInfo!
    var body: some View {
        VStack(alignment: .leading)
        {
            HStack
            {
                Customtitle(title:"앱 개인 정보 보호")
                Spacer()
                NavigationLink(destination: {
                    
                }, label: {
                    Text("세부사항 보기")
                })
            }
            
            HStack
            {
                Text(AppData!.sellerName!).font(.system(size: 15)) +
                Text("개발자가 아래 설명된 데이터 처리 방식이 앱의 개인정보 처리방침에 포함되어 있을 수 있다고 표시했습니다. 자세한 내용은").font(.system(size: 15)) +
                Text("개발자의 개인정보 처리방침을").foregroundColor(.blue).font(.system(size: 15)) +
                Text("을 참조하십시오.").font(.system(size: 15))
                Spacer()
            }
            .frame(maxWidth:.infinity)
            .foregroundColor(Color.gray.opacity(0.8))
            
            
            VStack(alignment:.center)
            {
                Image(systemName: "person.circle")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                    .frame(width: 30, height: 30)
                
                Text("사용자에게 연결된 데이터")
                    .font(.system(size: 15))
                Text("다음 데이터가 수집되어 신원에 연결될 수 있습니다.")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray.opacity(0.6))
                
                HStack
                {
                    VStack(alignment:.leading)
                    {
                        HStack
                        {
                            Image(systemName: "person.text.rectangle")
                                .resizable()
                                .frame(width: 17, height: 15)
                            Text("재무 정보")
                                .font(.system(size: 15))
                        }
                        
                        HStack
                        {
                            Image(systemName: "exclamationmark.circle.fill")
                                .resizable()
                                .frame(width: 17, height: 17)
                            Text("연락처 정보")
                                .font(.system(size: 15))
                                .padding(.trailing,40)
                        }
                        
                        
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment:.leading)
                    {
                        HStack
                        {
                            Image(systemName: "location.fill")
                                .resizable()
                                .frame(width: 17, height: 17)
                            Text("위치")
                                .font(.system(size: 15))
                            
                        }
                        
                        HStack
                        {
                            Image(systemName: "person.text.rectangle")
                                .resizable()
                                .frame(width: 17, height: 15)
                            Text("식별자")
                                .font(.system(size: 15))
                            
                        }
                        
                    }
                    Spacer()
                }
                
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
            .padding(.top)
            .padding([.horizontal,.bottom],13)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.6), radius: 5))
            .padding(.bottom,10)
            
            
            
            VStack(alignment:.center)
            {
                Image(systemName: "person.crop.circle.badge.xmark")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                    .frame(width: 35, height: 30)
                
                Text("사용자에게 연결되지 않은 데이터")
                    .font(.system(size: 15))
                Text("다음 데이터가 수집될 수 있지만 신원에는 연결되지 않습니다.")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray.opacity(0.6))
                    .multilineTextAlignment(.center)
                
                HStack(alignment:.top)
                {
                    VStack(alignment:.leading)
                    {
                        
                        HStack
                        {
                            Image(systemName: "exclamationmark.circle.fill")
                                .resizable()
                                .frame(width: 17, height: 17)
                            Text("연락처 정보")
                                .font(.system(size: 15))
                                .padding(.trailing,40)
                        }
                        
                        
                        
                        HStack
                        {
                            Image(systemName: "exclamationmark.circle.fill")
                                .resizable()
                                .frame(width: 17, height: 17)
                            Text("사용자 콘텐츠")
                                .font(.system(size: 15))
                                .padding(.trailing,40)
                        }
                        
                        HStack
                        {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 17, height: 17)
                            Text("진단")
                                .font(.system(size: 15))
                                .padding(.trailing,40)
                        }
                        
                        
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment:.leading)
                    {
                        HStack
                        {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 17, height: 17)
                            Text("연락처")
                                .font(.system(size: 15))
                            
                        }
                        
                        HStack
                        {
                            Image(systemName: "person.text.rectangle")
                                .resizable()
                                .frame(width: 17, height: 15)
                            Text("사용 데이터")
                                .font(.system(size: 15))
                            
                        }
                        
                    }
                    Spacer()
                }
                
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
            .padding(.top)
            .padding([.horizontal,.bottom],13)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.6), radius: 5))
            .padding(.bottom)
            
            
            HStack
            {
                Text("개인정보 처리방침은 사용하는 기능이나 사용자의 나이 등에 따라 달라질 수 있습니다.").font(.system(size: 15))
                    .foregroundColor(Color.gray.opacity(0.8)) +
                Text("더 알아보기").foregroundColor(.blue).font(.system(size: 15))
                
            }
            
            
        }
        .padding(.horizontal,20)
        
    }
}

