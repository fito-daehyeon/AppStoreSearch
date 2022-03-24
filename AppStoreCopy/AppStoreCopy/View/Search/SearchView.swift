//
//  SearchView.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/18.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    var body: some View {
        
        VStack
        {
            
            SearchNavigation(text: $viewModel.searchText, search: viewModel.search, cancel: viewModel.cancel,searchbegin: viewModel.begin) {
                
                ScrollView
                {
                    VStack(alignment: .leading)
                    {
                       
                        if viewModel.searchBegin
                        {
                            VStack
                            {
                                ForEach(viewModel.appTitleData,id:\.self){ value in
                                    
                                    VStack(alignment:.leading,spacing:7)
                                    {
                                        Button(action: {
                                            UIApplication.shared.endEditing()
                                            viewModel.searchText = value
                                            viewModel.handelHomeCard()
                                            
                                        }, label: {
                                            HStack(alignment: .center,spacing:0)
                                            {
                                                Image(systemName: "magnifyingglass")
                                                    .resizable()
                                                    .renderingMode(.template)
                                                    .foregroundColor(.gray)
                                                    .frame(width: 15, height: 15)
                                                    .padding(.trailing,10)
                                                
                                                Text(value)
                                                    .foregroundColor(.black)
                                                
                                            }
                                        })
                                        
                                        Divider()
                                    }
                                    .padding(.leading,30)
                                    
                                }
                            }
                            .padding(.top,15)
                            
                        }
                        else
                        {
                            if viewModel.wait == false
                            {
                                if !viewModel.appData.isEmpty
                                {
                                    ForEach(viewModel.appData){ value in
                                        AppDataView(AppData: value)
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                        
                        
                        
                    }
                    .frame(maxWidth:.infinity,alignment: .leading)
                }
                .navigationBarTitle("검색")
                
            }
            .edgesIgnoringSafeArea(.top)
            
            
        }
        .overlay(VStack
                 {
            if viewModel.wait
            {
                Spacer()
                ActivityIndicator(animated: true)
                Spacer()
            }
            
        }.padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)!+100))
        .alert(isPresented: Binding<Bool>(get: {
            viewModel.errorAlertMessage != nil
        }, set: { _ in viewModel.errorAlertMessage = nil}), content: {
            return Alert(
                title: Text(""),
                message: Text(viewModel.errorAlertMessage!),
                dismissButton: .default(Text("확인"))
                {
                   
                }
            )
        })
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
