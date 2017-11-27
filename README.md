# CustomKeyboard

---
![](https://img.shields.io/badge/platform-iOS-red.svg) 
![](https://img.shields.io/badge/language-Swift-orange.svg) 
![](https://img.shields.io/badge/download-1.8MB-brightgreen.svg)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

😆，总有一款键盘适合你，没有？那就自定义一个☝️..

| 名称 |1.列表页 |2.自定义页 |3.表情页 |
| ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-27/67624572.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-27/73564011.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-27/39480913.jpg) |
| 描述 | 通过 storyboard 搭建基本框架 | 自定义的选词条 | Emoji 表情集合 |


## Advantage 框架的优势
* 1.文件少，代码简洁
* 2.不依赖任何其他第三方库
* 3.具备较高自定义性


## Requirements 要求
* iOS 7+
* Xcode 8+


## Usage 使用方法
### 第一步 声明方法
```
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
    
```
### 第二步 调用切换
```
        //1.关闭键盘
        customTextView.resignFirstResponder()
        //2.唤起自定义键盘
//        customTextView.inputView = emojiVC.view
        customTextView.inputView = gilrsVC.view
        //唤起键盘
        customTextView.becomeFirstResponder()
```

使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!


## License 许可证
CustomKeyboard 使用 MIT 许可证，详情见 LICENSE 文件。


## Contact 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io
