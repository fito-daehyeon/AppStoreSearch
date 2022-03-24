//
//  PageView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import SwiftUI


struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}

struct PreViewPageControl: View
{
    var appData : Array<String>
    var spacing: CGFloat
    var trailingSpace : CGFloat
    var callback:(Int,Bool) -> ()
  
    @GestureState var offset : CGFloat = 0
    @State var currentIndex: Int = 0
    
    init(appData:Array<String> = [],spacing:CGFloat = 10, trailingSpace:CGFloat = 140,callback : @escaping (Int,Bool) -> ())
    {
        self.appData = appData
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self.callback = callback
    }

    var body: some View
    {
        GeometryReader{ g in
            let width = g.size.width - (trailingSpace - spacing)
            
            HStack(spacing:spacing)
            {
                ForEach(0..<appData.count,id:\.self){ item in
                    
                    CustomImageView(urlString: appData[item],width: g.size.width - trailingSpace,height: 550,cornerRadius:30)
                        .frame(width: g.size.width - trailingSpace)
                        .onTapGesture(perform: {
                            callback(item, true)
                        })
                }
            }
            .padding(.horizontal,spacing)
            .offset(x:(CGFloat(currentIndex) * -width) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                        
                    })
                    .onEnded({value in
                        
                        //업데이트 현재 인덱스
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                       
                        
                        //설정 맥스
                        currentIndex = max(min(currentIndex + Int(roundIndex), appData.count - 1),0)
                    })
                   
            )
            .animation(.easeOut, value: offset == 0)
            
        }
        
    }
}

struct ClickPreViewPageControl: View
{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var appData : Array<String>
    var spacing: CGFloat
    var trailingSpace : CGFloat
    @Binding var currentIndex: Int
    init(appData:Array<String> = [],spacing:CGFloat = 10, trailingSpace:CGFloat = 40,currentIndex:Binding<Int>)
    {
        self.appData = appData
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._currentIndex = currentIndex
       
    }
    
    @GestureState var offset : CGFloat = 0
   
    var body: some View
    {
        VStack(alignment: .leading, spacing: 0)
        {
            HStack
            {
                Spacer()
                
                HStack
                {
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("완료")
                            .fontWeight(.bold)
                    })
                        
                }
            }
        }
        .frame(maxWidth:.infinity,alignment: .leading)
        .padding()
        
        GeometryReader{ g in
            let width = g.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2 ) - spacing
            HStack(spacing:spacing)
            {
                ForEach(appData,id:\.self){ item in
                    
                    CustomImageView(urlString: item,width: .infinity,height: .infinity,cornerRadius:30)
                        .frame(width: g.size.width - trailingSpace)
                }
            }
            .padding(.horizontal,spacing)
            .offset(x:(CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                        
                    })
                    .onEnded({value in
                        
                        //업데이트 현재 인덱스
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        //설정 맥스
                        currentIndex = max(min(currentIndex + Int(roundIndex), appData.count - 1),0)
                    })
                    
            )
            .animation(.easeOut, value: offset == 0)
            
        }
    }
}

struct SnapCarousel<Content : View, T : Identifiable>: View
{
    var content : (T) -> Content
    var list : [T]
    
    var spacing: CGFloat
    var trailingSpace : CGFloat
    @Binding var index : Int
    
    init(spacing:CGFloat = 10, trailingSpace:CGFloat = 40, index:Binding<Int>,items:[T],@ViewBuilder
         content:@escaping (T)->Content)
    {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    @GestureState var offset : CGFloat = 0
    @State var currentIndex: Int = 0
    var body: some View
    {
        GeometryReader{ g in
            let width = g.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2 ) - spacing
            HStack(spacing:spacing)
            {
                ForEach(list){ item in
                    
                    content(item)
                        .frame(width: g.size.width - trailingSpace)
                }
            }
            .padding(.horizontal,spacing)
            .offset(x:(CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                        
                    })
                    .onEnded({value in
                        
                        //업데이트 현재 인덱스
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        //설정 맥스
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1),0)
                        currentIndex = index
                    })
                    .onChanged({ value in
                        
                        //업데이트 현재 인덱스
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        //설정 맥스
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1),0)
                       
                    })
            )
            .animation(.easeOut, value: offset == 0)
            
        }
    }
}

struct PageView: View {
    
    @State var currentIndex = 3
    var body: some View {
        VStack(spacing:15)
        {
            VStack(alignment: .leading, spacing: 12)
            {
                
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            .padding()
            
            SnapCarousel(spacing:10,index: $currentIndex, items: data)
            { userdata in
                GeometryReader{ g in
                    
                    UserWriteView(data: userdata)
                }
            }
            .frame(height: 160)
            
        }
       
    }
}


