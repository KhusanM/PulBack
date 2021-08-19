//
//  Loader.swift
//  PulBack
//
//  Created by apple on 12/08/21.
//

import Foundation
import UIKit
import Lottie

class Loader {
    class func start(){
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.tag = 2021
        let animationView = AnimationView()
        animationView.animation = Animation.named("loading")
        animationView.play()
        animationView.loopMode = .loop
        
        animationView.animationSpeed = 3
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        animationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        animationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        
        if let vieww = UIApplication.shared.keyWindow{
            vieww.addSubview(view)

        }

    }
    
    class func stop(){
        
        if let window = UIApplication.shared.keyWindow{
            for i in window.subviews{
                if i.tag == 2021{
                    i.removeFromSuperview()
                }
            }
        }
    }
}
