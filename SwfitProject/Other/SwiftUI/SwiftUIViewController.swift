//
//  SwiftUIViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import UIKit
import SwiftUI
class SwiftUIViewController: BaseViewController {
    let childView = UIHostingController(rootView: SwiftUIView())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addChild(childView)
        childView.view.frame = view.bounds
        view.addSubview(childView.view)
//      childView.didMove(toParent: self)
    }
}
