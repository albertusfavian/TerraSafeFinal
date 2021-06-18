//
//  ViewController.swift
//  pageController
//
//  Created by Mac-albert on 14/06/21.
//

import UIKit

class DetailTipsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageViewDetail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    //    @IBOutlet weak var contentLabel: UILabel!
    
    
//    func DispatchQueue.main.async{
    var objTips: [TipDetail]? 
    var numberPage:Int = 0
    var headTitle: String = ""
    
//    }
    
    private let scrollView = UIScrollView()
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
//        pageControl.numberOfPages =
//        print("Determining Direction: \(DeterminingDirection.count)")
//        pageControl.backgroundColor = .blue
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.2087203264, green: 0.3287478983, blue: 0.2789199054, alpha: 1)
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = objTips?.count ?? 0
        scrollView.delegate = self
        
        pageControl.addTarget(self,
                              action: #selector(pageControlDidChange(_:)),
                              for: .valueChanged)
//        scrollView.backgroundColor = .red
        view.addSubview(pageControl)
        view.addSubview(scrollView)
//        print("title depan: \(objTitleTips)")
//        print("title depan: \(headTitle)")
//        print("numberpagenya: \(numberPage)")
        titleLabel.text = objTips![pageControl.currentPage].titleTips
        contentLabel.text = objTips![pageControl.currentPage].bodyTips
        imageViewDetail.layer.cornerRadius = 10
        self.title = headTitle
        moveToFront()
    }

    @objc private func pageControlDidChange(_ sender: UIPageControl){
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width,
                                            y: 0), animated: true)
        contentLabel.text = objTips![pageControl.currentPage].bodyTips
        imageViewDetail.image = UIImage(named: objTips![pageControl.currentPage].imageTips)
        titleLabel.text = objTips![pageControl.currentPage].titleTips
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 10, y: view.frame.size.height-100, width: view.frame.size.width-20, height: 70)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-100)
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
    }
    
    let colors: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemPink,
        .systemTeal
    ]
    
    private func configureScrollView(){
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(numberPage) , height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        
        for xPage in 0..<numberPage{
            let page = UIView(frame: CGRect(x: CGFloat(xPage) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            print(pageControl.currentPage)
            contentLabel.text = objTips![pageControl.currentPage].bodyTips
            imageViewDetail.image = UIImage(named: objTips![pageControl.currentPage].imageTips)
            titleLabel.text = objTips![pageControl.currentPage].titleTips
            scrollView.addSubview(page)
        }
    }
    
    func moveToFront() {
        contentLabel.layer.zPosition = CGFloat(numberPage)
        titleLabel.layer.zPosition = CGFloat(numberPage)
        imageViewDetail.layer.zPosition = CGFloat(numberPage)
        pageControl.layer.zPosition = CGFloat(numberPage)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width))))
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
        imageViewDetail.image = UIImage(named: objTips![pageControl.currentPage].imageTips)
        contentLabel.text = objTips![pageControl.currentPage].bodyTips
        titleLabel.text = objTips![pageControl.currentPage].titleTips
        return
    }
}


