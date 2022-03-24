//
//  CustomView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import SwiftUI

struct CustomView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Customtitle:View
{
    var title = ""
    var body : some View
    {
        Text(title).font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
           
    }
}



struct AddStar : View
{
    
    var cnt = 5
    @State var star5 : Double = 0.7
    @State var star4 : Double = 0.3
    @State var star3 : Double = 0.2
    @State var star2 : Double = 0.1
    @State var star1 : Double = 0.4
    var body: some View
    {
        HStack(spacing:15)
        {
            VStack(alignment: .trailing,spacing:3)
            {
                HStack(spacing:0)
                {
                    ForEach(0..<cnt) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                            .frame(width: 5, height: 5)
                    }
                   
                                
                }
               
                HStack(spacing:0)
                {
                    ForEach(0..<cnt-1) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                            .frame(width: 5, height: 5)
                    }
                }
               
                
                HStack(spacing:0)
                {
                    ForEach(0..<cnt-2) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                            .frame(width: 5, height: 5)
                    }
                }
                
                HStack(spacing:0)
                {
                    ForEach(0..<cnt-3) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                            .frame(width: 5, height: 5)
                    }
                }
                
                HStack(spacing:0)
                {
                    ForEach(0..<cnt-4) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                            .frame(width: 5, height: 5)
                    }
                }
                
                   
            }
            
            VStack(spacing:4)
            {
                ProgressView(value: star5)
                    .progressViewStyle(LinearProgressViewStyle(tint: .gray))
                
                ProgressView(value: star4)
                    .progressViewStyle(LinearProgressViewStyle(tint: .gray))
                
                ProgressView(value: star3)
                    .progressViewStyle(LinearProgressViewStyle(tint: .gray))
                
                
                ProgressView(value: star2)
                    .progressViewStyle(LinearProgressViewStyle(tint: .gray))
                
                
                ProgressView(value: star1)
                    .progressViewStyle(LinearProgressViewStyle(tint: .gray))
                
            }
        }
       
        
    }
    
    
    //    int i = 0, j = 0, k = 0;
    //
    //        for ( i = 0; i < 5; i++ )
    //        {
    //            for ( k = 0; k < i; k++ )
    //            {
    //                printf(" ");
    //            }
    //            for ( j = 0; j < 5-i; j++ )
    //                printf("*");
    //            printf("\n");
    //        }
}


struct TabStar : View
{
    @State var select = -1
    var popup : () -> ()
    var body: some View
    {
        HStack
        {
            Text("탭하여 평가하기: ")
                .foregroundColor(.black.opacity(0.4))
            
            Spacer()
         
            ZStack
            {
                
                HStack
                {
                    ForEach(0..<5){ i in
                        Image(systemName: "star.fill")
                            .resizable().frame(width: 25, height: 25).foregroundColor(self.select >= i ? .blue : .white)
                           
                    }
                }
                HStack
                {
                    ForEach(0..<5){ i in
                        Image(systemName: "star")
                            .resizable().frame(width: 25, height: 25)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                self.select = i
                                popup()
                            }
                           
                    }
                }
                
            }
            
            
        }
    }
}


struct PopUpView : View
{
    @State var popup = false
    var body: some View
    {
        VStack(spacing:0)
        {
            Image(systemName:"star.fill")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(.gray)
                .frame(width: 100, height: 90)
                .padding(.vertical,20)
                .padding(.top,10)
            
            Text("제출됨").font(.system(size: 30, weight: .medium))
            Text("피드백을 보내주셔서 감사합니다.").font(.system(size: 20))
                .padding()
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth:.infinity,alignment: .center)
        .padding(.vertical,20)
        .background(ThemeColor.btn_bg.getSwiftUIColor())
        .cornerRadius(10)
    }
}



struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
    }
}
