//
//  ParseErrorManerger.swift
//  school
//
//  Created by 張翔 on 2016/01/27.
//  Copyright © 2016年 sho. All rights reserved.
//

import Foundation

class ParseError {
    var error: NSError!
       
    init(error: NSError!) {
        self.error = error
    }
    
    var JapaneseForUser:String{
        var Japanese: String = ""
        
        switch error.code{
        case 1, 148, 149: Japanese =  "サーバーエラーが発生しました。"
        case 100: Japanese = "サーバーに接続できません。"
        case 116: Japanese = "データが大きすぎます。"
        case 122: Japanese = "ファイル名に不正な文字が含まれています。"
        case 124: Japanese = "タイムアウトが発生しました。"
        case 125: Japanese = "メールアドレスが正しくありません"
        case 150: Japanese = "画像データの処理に失敗しました"
        case 151: Japanese = "ファイルがセーブされていません"
        case 153: Japanese = "ファイルの削除に失敗しました"
        case 155: Japanese = "ただいまサーバーが混雑しています。"
        case 200, 201, 204, 205: Japanese = "メールアドレスかパスワードが間違っています"
        case 202, 203:Japanese = "既に使われているメールアドレスです。"
        case 999: Japanese = "招待コードが間違っています"
        default: Japanese = "エラーが発生しました。"
        }
        print("error:" + Japanese)
        return Japanese
        
    }
    
   
}

//class ParseError: NSError {
//
//    var JapaneseForUser: String{
//        var Japanese: String = ""
//
//        switch self.code{
//        case 1, 148, 149: Japanese =  "サーバーエラーが発生しました。"
//        case 100: Japanese = "サーバーに接続できません。"
//        case 116: Japanese = "データが大きすぎます。"
//        case 122: Japanese = "ファイル名に不正な文字が含まれています。"
//        case 124: Japanese = "タイムアウトが発生しました。"
//         case 125: Japanese = "メールアドレスが正しくありません"
//        case 150: Japanese = "画像データの処理に失敗しました"
//        case 151: Japanese = "ファイルがセーブされていません"
//        case 153: Japanese = "ファイルの削除に失敗しました"
//        case 155: Japanese = "ただいまサーバーが混雑しています。"
//        case 200, 201, 204, 205: Japanese = "メールアドレスかパスワードが間違っています"
//        case 202, 203:"既に使われているメールアドレスです。"
//        default: Japanese = "エラーが発生しました。"
//        }
//
//        return Japanese
//    }
//}