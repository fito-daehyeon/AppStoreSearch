//
//  UserWriteData.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/21.
//

import SwiftUI

struct UserWriteData : Identifiable
{
    var id = UUID().uuidString
    var title : String
    var name : String
    var content : String
}

var data = [
    UserWriteData(title: "좋아요0", name: "김대현0", content: "안녕하세요"),
    UserWriteData(title: "좋아요1", name: "김대현1", content: "안녕하세요"),
    UserWriteData(title: "좋아요2", name: "김대현2", content: "안녕하세요"),
    UserWriteData(title: "좋아요3", name: "김대현3", content: "안녕하세요"),
    UserWriteData(title: "좋아요4", name: "김대현4", content: "안녕하세요"),
    UserWriteData(title: "좋아요5", name: "김대현5", content: "안녕하세요"),]
