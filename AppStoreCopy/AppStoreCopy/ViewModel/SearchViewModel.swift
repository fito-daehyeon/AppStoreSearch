//
//  SearchViewModel.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/22.
//

import Foundation
import Combine

class SearchViewModel : ObservableObject
{
    @Published var searchText = ""                      // 서치 텍스트
    @Published var searchBegin = false                  // 서치 시작
    @Published var appData : [AppDataInfo] = []   // 앱스토어 API에서 나온 데이터 저장
    @Published var appTitleData : Array<String> = []    // 검색할때 나올 데이터 저장
    @Published var wait = false                         // true 기다림 , false 데이터 받음
    @Published var errorAlertMessage: String?
    private var disposables = Set<AnyCancellable>()
    init()
    {
        if searchText != ""
        {
            handelHomeCard()
        }
        
        $searchText.dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .flatMap { _ in AppStoreAPIFetcher.shared.requestAppData(item: self.searchText) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
              
            }, receiveValue: { [weak self] result in
                self?.appTitleData = []
                for i in result
                {
                    self?.appTitleData.append(i.trackName!)
                }
            })
            .store(in: &disposables)
        
    }
    func handelHomeCard()
    {
        self.wait = true
        AppStoreAPIFetcher.shared.requestAppData(item: searchText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let Err):
                    switch Err {
                        
                    case .network(_,_, _):
                        self.errorAlertMessage = "SSL 오류가 발생했기 때문에 서버에 안전하게 연결할 수 없습니다."
                        
                    case .AppStoreResultFailure(let code, _):
                       
                        print(code)
       
                    default: break
                    }
                    
                case .finished:
                    self.wait = false
                }
            }, receiveValue: { [weak self] result in
                //메시지 확인
                self?.appData = result
                self?.searchBegin = false
            })
            .store(in: &disposables)
    }
    
    
    func search() {
        self.appTitleData = []
        self.handelHomeCard()
        
    }
    
    func cancel() {
        self.searchText = ""
        self.appTitleData = []
        self.appData = []
    }
    func begin()
    {
        self.searchBegin = true
    }
}
