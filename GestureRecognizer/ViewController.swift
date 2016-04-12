//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Chuck on 16/4/12.
//  Copyright © 2016年 Chuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


	var aImageView: UIImageView!
	var isChagneFrame = false
	override func viewDidLoad() {
		super.viewDidLoad()
		
		aImageView = UIImageView(image: UIImage(named: "dabai"))
		aImageView.center = view.center
		aImageView.userInteractionEnabled = true
		
		//点击
		let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
		tap.numberOfTapsRequired = 2
		aImageView.addGestureRecognizer(tap)
		
		//移动
		let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
		aImageView.addGestureRecognizer(pan)
		view.addSubview(aImageView)
		
		// 缩放
		let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
		aImageView.addGestureRecognizer(pinch)
		
		let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotation(_:)))
		aImageView.addGestureRecognizer(rotation)
		}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func tap(tap: UIPanGestureRecognizer) {
		print("abc")
		var frame = aImageView.frame
		if !isChagneFrame {
			frame.size.width *= 2
			frame.size.height *= 2

			isChagneFrame = true
		} else {
			frame.size.width /= 2
			frame.size.height /= 2
			isChagneFrame = false
		}
	
		aImageView.frame = frame
	}
	
	func pan(gestureRecognizer: UIPanGestureRecognizer) {
		if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
			//UIPanGestuerRecognizer的translation属记,记录aimagView的偏移值
			let translation = gestureRecognizer.translationInView(aImageView!.superview!)
			aImageView!.center = CGPointMake(aImageView!.center.x + translation.x, aImageView!.center.y + translation.y)
			gestureRecognizer.setTranslation(CGPointZero, inView: aImageView!.superview)
		}
	}
	
	func pinch(gestureRecognizer: UIPinchGestureRecognizer) {
		if gestureRecognizer.state == .Began || gestureRecognizer.state == .Changed {
			aImageView.transform = CGAffineTransformScale(aImageView.transform, gestureRecognizer.scale, gestureRecognizer.scale)
			//设置这次scale的值做为下次初始值
			gestureRecognizer.scale = 1
		}
	}
	func rotation(gestureRecognize: UIRotationGestureRecognizer) {
		if gestureRecognize.state == .Began || gestureRecognize.state == .Changed {
			aImageView.transform = CGAffineTransformRotate(aImageView.transform, gestureRecognize.rotation)
			//这里设置rotation 为0 的原因是, 以这次rotation作为下次的初始值
			gestureRecognize.rotation = 0
		}
	}
}

