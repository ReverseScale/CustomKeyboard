//
//  EmojiViewController.swift
//  swift3.0-emojiKeyboard
//
//  Created by Shaoting Zhou on 2017/3/13.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
private let  EmojiCellIdentifier = "EmojiCellIdentifier"

class EmojiViewController: UIViewController {
    
    //定义一个闭包属性,用于传递选中的表情模型
    var emojiDidSelectedCallBack:(_ emoji:String)->()
    
    init?(callBack:@escaping (_ emoji:String)->()) {
        self.emojiDidSelectedCallBack = callBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //懒加载表情collectionView
    private lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: EmojiLayout())
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    var emojiData = [EmojiModel]()  //存放所有表情
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        EmojiModel.loadEmoji { (data) in
            emojiData = data
        }
        setupUI()
    }
    
    func setupUI(){
        //1.添加子控件
        view.addSubview(collectionView)
        //2.布局子控件
        collectionView.translatesAutoresizingMaskIntoConstraints = false  //禁止Autoresizing
        
        var cons = [NSLayoutConstraint]() //约束数组
        let dict = ["collectionView":collectionView] as [String : Any] //视图字典
        
        //约束collectionView 和 toolbar 水平方向
        cons += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: dict)
        //约束collectionView 和 toolbar 垂直方向
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: dict)
        
        view.addConstraints(cons)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension EmojiViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
         return emojiData.count  //emoji
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCellIdentifier, for: indexPath) as!EmojiCell
        
        cell.backgroundColor  = (indexPath.item % 2) == 0 ? UIColor.red : UIColor.green
        cell.iconButton.setTitle(emojiData[indexPath.item].emojiStr, for: .normal)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let emojiStr = emojiData[indexPath.item].emojiStr!
         //2.回调点击
        emojiDidSelectedCallBack(emojiStr)
    }
    
    
}

class EmojiCell: UICollectionViewCell{
    lazy var iconButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(iconButton)
        iconButton.frame = contentView.bounds
        iconButton.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//自定义布局类
class EmojiLayout:UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        //设置cell的相关属性
        let width = (collectionView?.bounds.width)! / 7
        itemSize = CGSize.init(width: width, height: width)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        //设置collectionView的相关属性
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsVerticalScrollIndicator = false
        
        //去除间隙
        let y = (collectionView!.bounds.height - 3 * width) * 0.4
        collectionView?.contentInset = UIEdgeInsets.init(top: y, left: 0, bottom: y, right: 0)
    }
}
