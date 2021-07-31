//
//  TimerView.swift
//  PulBack
//
//  Created by Kh's on 7/31/21.
//

import UIKit
import Lottie

protocol TimerViewDelegate {
    func refreshTimeView()
}

class TimerView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private let startPoint = CGFloat(-Double.pi / 2)
    private let endPoint = CGFloat(3 * Double.pi / 2)
    private var count = 0
    private var duration = 60
    private let animationView = AnimationView()
    
    var lblCount : UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor(named: "customRed")
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        l.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var refreshBtn : UIButton = {
       let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var delegate: TimerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func refresh() {
        animationView.isHidden = true
        refreshBtn.isHidden = true
        lblCount.isHidden = false
        delegate?.refreshTimeView()
        progressAnimation()
    }
    
    func createCircularPath(radius: CGFloat, lineWidth: CGFloat, bgLineColor: UIColor = .clear, progressColor: UIColor, firstDuration: Int) {
        // created circularPath for circleLayer and progressLayer
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = bgLineColor.cgColor
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = progressColor.cgColor
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
        duration = firstDuration
        lblCount.text = "\(firstDuration)"
        self.addSubview(lblCount)
        lblCount.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblCount.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        animationView.animation = Animation.named("reload")
        self.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        animationView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        animationView.animationSpeed = 0.5
        animationView.loopMode = .playOnce
        animationView.isHidden = true
        
        refreshBtn.isHidden = true
        refreshBtn.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        self.addSubview(refreshBtn)
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        refreshBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        refreshBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        refreshBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func progressAnimation() {
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = CFTimeInterval(duration)
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = true
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        
        lblCount.isHidden = false
        lblCount.text = "\(duration)"
        refreshBtn.isHidden = true
        count = duration
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            if count == 0 {
                animationView.isHidden = false
                animationView.play()
                timer.invalidate()
                refreshBtn.isHidden = false
                lblCount.isHidden = true
                duration = duration*2
            } else {
                count -= 1
            }
            lblCount.text = "\(count)"
        }
    }
}
