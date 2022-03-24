//
//  AppDetailModel.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import Foundation
import Combine
import UIKit


class AppDetailModel : ObservableObject
{
    @Published var customtitlebar = false //스크롤 할때 사용
    @Published var titlepositiontimer = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect() //타이틀 포지션 가져올때 실시간 데이터 감지
    @Published var addlinelimit : Int = 3 // 새로운 기능 > 더보기
    @Published var descriptionlimit : Int = 3 // 추가 내용 더보기
    @Published var popupview = false // 탭하여 평가하기 별 누를시 팝업창 활성화
    @Published var shareActive : Bool = false// 공유하기
    
    @Published var timerrunning = 1 // 팝업창 호출시간
    
    @Published var previewsheet = false // 미리보기 클릭시
    
    @Published var currentindex = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var bofreaddText : Array<String> = []
    
    let digit: Double = pow(10, 1) // 10의 3제곱
    
    func compareDate(appversion : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:appversion)!
        
        
        let distanceDay = Calendar.current.dateComponents([.day], from: date, to: Date()).day
        return "\(distanceDay!)일 전"
        
    }
    
    func findnextlint(content : String) -> Array<String>
    {
        let test = content.components(separatedBy: "\n")
        bofreaddText = test.filter({ $0 != ""})
        return bofreaddText
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
    
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    
    
    func ShareButton() {
        
        guard let urlShare = URL(string: "https://apps.apple.com/kr/app/%EC%B9%B4%EC%B9%B4%EC%98%A4%EB%B1%85%ED%81%AC/id1258016944?uo=4") else { return }
                let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        
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
    
  
    
    func selectEvent(num : Int, activity : Bool)
    {
        self.currentindex = num
        self.previewsheet = activity
    }
    
 
}
