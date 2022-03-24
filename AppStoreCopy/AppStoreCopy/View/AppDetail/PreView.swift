//
//  PreView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/22.
//

import SwiftUI
import SwiftUIPager

class PreViewModel : ObservableObject
{
    @Published var currentindex = 0
    @Published var previewsheet = false
}
struct PreView: View {
        
    @StateObject var prepage: Page = .first()
    @StateObject var viewModel = PreViewModel()
    var appData : Array<String> = []
   
    var body: some View {
        
        VStack(alignment: .leading)
        {
            Pager(page: prepage,
                     data: appData,
                     id: \.self,
                     content: { index in
                         
                
                CustomImageView(urlString:  index,width: .infinity/3,height: 550,cornerRadius: 30)
                   
                    .cornerRadius(30)
                    .onTapGesture {
                        if let i = appData.firstIndex(of: index)
                        {
                            self.viewModel.currentindex = i
                            self.viewModel.previewsheet = true
                        }
                    }
                
                    
            })
                
                .itemSpacing(10)
                .alignment(.start(20))
                .preferredItemSize(CGSize(width: 250, height: 550))
                .multiplePagination()
                .frame(height: 530)

                
                
            
            HStack(spacing:10)
            {
                Image(systemName: "iphone")
                    .font(.system(size: 15,weight: .bold))
                
                Text("iPhone")
                    .font(.system(size: 13,weight: .bold))
                   
            }
            .padding(.top,10)
            .padding(.leading,18)
            .foregroundColor(.gray.opacity(0.6))
        }
        .padding(.top,30)
        .padding(.bottom,10)
        .sheet(isPresented: $viewModel.previewsheet)
        {
            
            ClickPreView()
           

        }
       
           
         
    }
    
    
    @ViewBuilder
    func ClickPreView() -> some View
    {
        VStack
        {
            HStack
            {
                Spacer()
                
                HStack
                {
                    Spacer()
                    Button(action: {
                        viewModel.previewsheet = false
                    }, label: {
                        Text("완료")
                            .fontWeight(.bold)
                    })
                        .padding()
                        
                }
            }
            
            Pager(page: .withIndex(viewModel.currentindex),
                  data: appData,
                  id: \.self,
                  content: { index in
                
                
                CustomImageView(urlString: index,width: .infinity,height: .infinity,cornerRadius:30)
                    .cornerRadius(30)
                
                
            })
                .padding(30)
                .itemSpacing(10)
                .multiplePagination()
               
        }
        .frame(maxWidth:.infinity,alignment: .leading)
    }
}



//struct PreView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreView()
//    }
//}
