//
//  GradientViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/12.
//

import UIKit

class GradientViewController: BaseViewController {

    @IBOutlet weak var view_Radial: UIView!
    
    @IBOutlet weak var view_Center: UIView!
    
    @IBOutlet weak var view_Bottom: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view_Radial.setGradientRadial(color1: .black, color2: .white)
//        view_Center.setGradienthorizontal(color1: .white, color2: .black)
        view_Center.setGradientvertical(color1: .white, color2: .black)
        
        view_Bottom.setGradientConic(color1: .black, color2: .red)
    }
    
}
extension UIView{
    func setGradienthorizontal(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    func setGradientvertical(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    
    func setGradientRadial(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.type = .radial
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    func setGradientConic(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 ,0.4 , 0.6, 1.0]
        gradient.type = .conic
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
}
