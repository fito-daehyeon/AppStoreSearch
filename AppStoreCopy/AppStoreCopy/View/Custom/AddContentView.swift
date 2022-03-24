//
//  AddContentView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/22.
//

import SwiftUI

struct AddContentView: View {
    @Binding var limit : Int
   
    var content = ""
    
    var body: some View {
        VStack
        {
            if limit == 3
            {
                ForEach(0..<findnextlint(content: content).count)
                {
                    
                    if $0 < 2
                    {
                        Text(findnextlint(content: content)[$0])
                        
                    }
                    
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
                .font(.system(size: 17))
                
                HStack
                {
                    if findnextlint(content: content).count > 3
                    {
                        Text(findnextlint(content: content)[2])
                            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
                            .font(.system(size: 17))
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation{
                                limit = 0
                            }
                        }, label: {
                            Text("더 보기")
                        })
                    }
                    
                }
                
            }
            
            else
            {
                Text(content)
                    .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .leading)
                    .font(.system(size: 17))
                    .lineSpacing(10)
            }
        }
    }
    
    public func findnextlint(content : String) -> Array<String>
    {
        var bofreaddText : Array<String> = []
        let test = content.components(separatedBy: "\n")
        bofreaddText = test.filter({ $0 != ""})
        return bofreaddText
    }
}

//struct AddContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddContentView()
//    }
//}
