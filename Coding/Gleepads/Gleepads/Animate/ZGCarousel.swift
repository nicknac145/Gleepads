//
//  ZGScroll.swift
//  horizontalScroll
//
//  Created by Admin on 16/01/2017.
//  Copyright © 2017 SkyairPartsShip. All rights reserved.
//

import UIKit

/*Delegates Methods for ZGCarousel*/

@objc protocol ZGCarouselDelegate {
    func ZGitemData()->[UIViewController]
    @objc optional func ZGitemsPadding()->CGFloat
    @objc optional func ZGitemSelected(item:UIViewController,index:Int)
    @objc optional func ZGitemMoveTo(item:UIViewController,index:Int)
}


class ZGCarousel: UIScrollView {
    
    fileprivate var controllers = [UIViewController]()
    private var padding:CGFloat = 0
    var zgDelegate:ZGCarouselDelegate?
    var currentPage:CGFloat = 0
    
    /*Get data from controller using delegation*/
    
    override func draw(_ rect: CGRect) {
        if let delegate = self.zgDelegate{
            self.padding = delegate.ZGitemsPadding?() ?? 0.0
            self.controllers = delegate.ZGitemData()
            self.setContentSize(itemCount: CGFloat(self.controllers.count))
            self.isPagingEnabled = true
            self.showsHorizontalScrollIndicator=false
            self.showsVerticalScrollIndicator=false
            self.delegate=self
        }
    }
    
    /*Add controllers into the scrollview*/

    private func setContentSize(itemCount:CGFloat){
        self.contentSize = CGSize(width:self.frame.width * itemCount, height:self.frame.height)
        for (index,controller) in self.controllers.enumerated(){
            controller.view.frame = CGRect(x:self.frame.width * CGFloat(index) + self.padding/2 , y:0, width:self.frame.width-self.padding, height:self.frame.height)
            let tap = UITapGestureRecognizer(target: self, action: #selector(press))
            controller.view.addGestureRecognizer(tap)
            controller.view.isUserInteractionEnabled=true
            controller.view.tag = index
            self.addSubview(controller.view)
        }
    }
    
    /*Controller tap geasture action*/

    @objc private func press(sender: UITapGestureRecognizer){
       let index =  sender.view?.tag
        let cont = self.controllers[index!]
        self.zgDelegate!.ZGitemSelected?(item: cont, index: index!)
    }
    
    /*Remove previous items and addd new array*/
    
    func reloadItems(){
        self.subviews.forEach({$0.removeFromSuperview()})
        self.controllers = self.zgDelegate!.ZGitemData()
        self.setContentSize(itemCount: CGFloat(self.controllers.count))
    }
    
    /*Remove previous items and addd new array*/

    func moveTo(index:Int)  {
        UIView.animate(withDuration: 0.25) {
        self.contentOffset.x = CGFloat(index) * UIApplication.shared.keyWindow!.frame.width

        }
    }
}

extension ZGCarousel: UIScrollViewDelegate{
    /*Item selected*/
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.zgDelegate?.ZGitemMoveTo?(item: self.controllers[Int(currentPage)], index: Int(currentPage))
        self.currentPage = currentPage
    }
}
