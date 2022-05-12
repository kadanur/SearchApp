//
//  PresentationController.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 11.05.2022.
//

import Foundation
import UIKit

class PresentationController: UIPresentationController {
    
    static let wantedHeightMultiplier = (Double(UIScreen.main.bounds.height) * 0.8)
    static let modForWantedTableViewHeight = Int((PresentationController.wantedHeightMultiplier)) % PresentationController.cellHeight
    static var wantedTableViewHeight = Int(PresentationController.wantedHeightMultiplier) - PresentationController.modForWantedTableViewHeight
    static var cellHeight = 52
    static var listedCells = PresentationController.wantedTableViewHeight / PresentationController.cellHeight
    
    func valueOfTableViewHeight() -> Int {
            if SecondViewController.menuArray.count <= PresentationController.listedCells {
                PresentationController.wantedTableViewHeight = SecondViewController.menuArray.count * (PresentationController.cellHeight) + PresentationController.cellHeight
            } else {
                PresentationController.wantedTableViewHeight = PresentationController.listedCells * PresentationController.cellHeight
            }
        
        if let window = UIApplication.shared.keyWindow {
            if #available(iOS 11.0, *) {
                PresentationController.wantedTableViewHeight = PresentationController.wantedTableViewHeight + Int(window.safeAreaInsets.bottom)
            } else {
                PresentationController.wantedTableViewHeight = PresentationController.wantedTableViewHeight * PresentationController.cellHeight
            }
        }
        return PresentationController.wantedTableViewHeight
    }
    
    let blurEffectView: UIVisualEffectView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        CGRect(origin: CGPoint(x: 0, y: Int(self.containerView!.frame.height) - valueOfTableViewHeight()),
               size: CGSize(width: self.containerView!.frame.width, height: CGFloat(valueOfTableViewHeight())))
    }
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0.5
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 12)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


