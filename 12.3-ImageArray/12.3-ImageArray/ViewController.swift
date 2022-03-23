//
//  ViewController.swift
//  12.3-ImageArray
//
//  Created by Alehandro on 21.02.22.
//

import UIKit

class ViewController: UIViewController {
    
    private var width: CGFloat = 300
    private var height: CGFloat = 300
    private var count = 0
    private var firstImageView: UIImageView!
    private var secondImageView: UIImageView!
    private var thirdImageView: UIImageView!
    private var fourthImageView: UIImageView!
    private var fifthImageView: UIImageView!
    private var imageArray: [UIImage]!
    private var leftLocation: CGRect!
    private var centerLocation: CGRect!
    private var rightLocation: CGRect!
    private var centerView: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        firstImageView = UIImageView()
        secondImageView = UIImageView()
        thirdImageView = UIImageView()
        
        imageViewLocation()
        
        firstImageView = UIImageView(frame: centerLocation)
        secondImageView = UIImageView(frame: rightLocation)
        thirdImageView = UIImageView(frame: rightLocation)
        
        contentMode()
        
        imageArray = [UIImage(named: "ic_placeholder_1")!,
                      UIImage(named: "ic_placeholder_2")!,
                      UIImage(named: "ic_placeholder_3")!,
                      UIImage(named: "ic_placeholder_4")!,
                      UIImage(named: "ic_placeholder_5")!]
        
        firstImageView.image = imageArray[count]
        secondImageView.image = imageArray[count]
        thirdImageView.image = imageArray[count]
        
        let gestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeLeft))
        gestureRecognizerLeft.direction = .left
        view.addGestureRecognizer(gestureRecognizerLeft)
        let gestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeRight))
        gestureRecognizerRight.direction = .right
        view.addGestureRecognizer(gestureRecognizerRight)
        
        view.addSubview(firstImageView)
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
    }
    
    @objc private func onSwipeLeft(gesture: UISwipeGestureRecognizer) {
        if count < imageArray.count - 1 {
            if secondImageView.frame == centerLocation {
                self.count += 1
                thirdImageView.image = imageArray[count]
                UIView.animate(withDuration: 0.4, delay: 0, options: []) {
                    self.secondImageView.frame = self.leftLocation
                    self.thirdImageView.frame = self.centerLocation
                    self.centerView = "third"
                } completion: { _ in
                    self.firstImageView.frame = self.rightLocation
                }
            } else if thirdImageView.frame == centerLocation {
                self.count += 1
                firstImageView.image = imageArray[count]
                UIView.animate(withDuration: 0.4, delay: 0, options: []) {
                    self.firstImageView.frame = self.centerLocation
                    self.thirdImageView.frame = self.leftLocation
                    self.centerView = "first"
                } completion: { _ in
                    self.secondImageView.frame = self.rightLocation
                }
            } else {
                self.count += 1
                secondImageView.image = imageArray[count]
                UIView.animate(withDuration: 0.4, delay: 0, options: []) {
                    self.firstImageView.frame = self.leftLocation
                    self.secondImageView.frame = self.centerLocation
                    self.centerView = "second"
                } completion: { _ in
                    self.thirdImageView.frame = self.rightLocation
                }
            }
        } else {
            if centerView == "first" {
                UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                    self.firstImageView.transform = CGAffineTransform(translationX: -30, y: 0)
                } completion: { _ in
                    UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                    self.firstImageView.transform = .identity
                    }
                }
            } else if centerView == "second" {
                UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                    self.secondImageView.transform = CGAffineTransform(translationX: -30, y: 0)
                } completion: { _ in
                    UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                    self.secondImageView.transform = .identity
                    }
                }
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                    self.thirdImageView.transform = CGAffineTransform(translationX: -30, y: 0)
                } completion: { _ in
                    UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                    self.thirdImageView.transform = .identity
                    }
                }
            }
        }
    }
    
    @objc private func onSwipeRight(gesture: UISwipeGestureRecognizer) {
    
        if count == 0 {
            self.count = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                self.firstImageView.transform = CGAffineTransform(translationX: 30, y: 0)
            } completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                self.firstImageView.transform = .identity
                }
            }
        } else {
            if secondImageView.frame == centerLocation {
                count -= 1
                firstImageView.image = imageArray[count]
                UIView.animate(withDuration: 0.4) {
                    self.firstImageView.frame = self.centerLocation
                    self.secondImageView.frame = self.rightLocation
                    self.centerView = "first"
                } completion: { _ in
                    self.thirdImageView.frame = self.leftLocation
                }
            } else if firstImageView.frame == centerLocation {
                count -= 1
                thirdImageView.image = imageArray[count]
                UIView.animate(withDuration: 0.4) {
                    self.thirdImageView.frame = self.centerLocation
                    self.firstImageView.frame = self.rightLocation
                    self.centerView = "third"
                } completion: { _ in
                    self.secondImageView.frame = self.leftLocation
                }
            } else {
                count -= 1
                secondImageView.image = imageArray[count]
                UIView.animate(withDuration: 0.4) {
                    self.thirdImageView.frame = self.rightLocation
                    self.secondImageView.frame = self.centerLocation
                    self.centerView = "second"
                } completion: { _ in
                    self.firstImageView.frame = self.leftLocation
                }
            }
        }
    }
    
    private func contentMode() {
        firstImageView.contentMode = .scaleAspectFit
        secondImageView.contentMode = .scaleAspectFit
        thirdImageView.contentMode = .scaleAspectFit
    }
    
    private func imageViewLocation() {
        leftLocation = CGRect(x: UIScreen.main.bounds.midX - width * 2,
                              y: UIScreen.main.bounds.midY - height / 2,
                              width: 300,
                              height: 300)
        centerLocation = CGRect(x: UIScreen.main.bounds.midX - width / 2,
                                y: UIScreen.main.bounds.midY - height / 2,
                                width: 300,
                                height: 300)
        rightLocation = CGRect(x: UIScreen.main.bounds.midX + width,
                               y: UIScreen.main.bounds.midY - height / 2,
                               width: 300,
                               height: 300)
    }
}

