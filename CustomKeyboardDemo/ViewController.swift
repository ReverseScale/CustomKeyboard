//
//  ViewController.swift
//  CustomKeyboardDemo
//
//  Created by WhatsXie on 2017/11/27.
//  Copyright © 2017年 R.S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var customTextView: UITextView!
    
    //懒加载emoji表情控制器
    private lazy var emojiVC:EmojiViewController = EmojiViewController.init { [weak self](emojiData) in
        //self.customTextView.selectedTextRange! 光标所在位置
        //输入回调,之后替换
        self!.customTextView.replace(self!.customTextView.selectedTextRange!, withText: emojiData)
        }!
    //懒加载gilrs控制器
    private lazy var gilrsVC:GirlsViewController = GirlsViewController.init { [weak self](gilrsData) in
        self!.customTextView.replace(self!.customTextView.selectedTextRange!, withText: gilrsData)
        }!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.将键盘控制器添加为当前控制器的子控制器
//        addChildViewController(emojiVC)
        addChildViewController(gilrsVC)
        //2.默认文字键盘
        customTextView.inputView = nil
        customTextView.keyboardType = .numberPad
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customTextView.becomeFirstResponder()
    }
    //系统键盘点击事件
    @IBAction func textKeyboardAction(_ sender: Any) {
        //1.关闭键盘
        customTextView.resignFirstResponder()
        //2.唤起系统键盘
        customTextView.inputView = nil
        //唤起键盘
        customTextView.becomeFirstResponder()
    }
    //自定义键盘点击事件
    @IBAction func emojiKeyboardAction(_ sender: Any) {
        //1.关闭键盘
        customTextView.resignFirstResponder()
        //2.唤起自定义键盘
//        customTextView.inputView = emojiVC.view
        customTextView.inputView = gilrsVC.view
        //唤起键盘
        customTextView.becomeFirstResponder()
    }
    //发送按钮点击事件
    @IBAction func sendAction(_ sender: Any) {
        print(customTextView.text)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

