//
//  EmojiModel.swift
//  swift3.0-emojiKeyboard
//
//  Created by Shaoting Zhou on 2017/3/13.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class EmojiModel: NSObject {
    var code:String? {   //plist中的code
        didSet{
            //1.从字符串中取出十六进制的数
            //创建一个扫描器,扫描器可以从字符串中提取数据
            let sanner =  Scanner.init(string: code!)
            //2.将十六进制转为字符串
            var result:UInt32 = 0
            sanner.scanHexInt32(&result)
            //3.将十六进制转换为emoji字符串
            emojiStr = "\(Character.init(UnicodeScalar.init(result)!))"
        }
    }
    var emojiStr:String?   //emoji表情字符串
    class func loadEmoji(OK:([EmojiModel]) -> ()){
        //1找到emoji.plist的路径
        let path  = Bundle.main.path(forResource: "emoji.plist", ofType: nil)
        //2加载emoji.plist
        let dict = NSDictionary.init(contentsOfFile: path!)!
        //3.加载emoticons数组
        let emoticonsAry = dict["emoticons"]
        //4.转模型
        let emoticonModel = dict2Model(list: emoticonsAry as! [[String : AnyObject]])
        //5.回调回去
        OK(emoticonModel)
    }
    
    class func dict2Model(list:[[String:AnyObject]]) -> [EmojiModel]{
        var models = [EmojiModel]()
        for dict in list{
            models.append(EmojiModel.init(dict: dict))
        }
        return models
    }
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    //防止崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
