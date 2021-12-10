//
//  LookupViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import UIKit

class LookupViewController: BaseViewController {

    @IBOutlet weak var lab_Two_Title: UILabel!
    
    @IBOutlet weak var lab_Title: UILabel!
    
    fileprivate(set) var viewModel = LookupViewModel()
    let mything = Thing()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func clickLookup(_ sender: Any) {
        lab_Title.text = mything.name
    }
    
    
    @IBAction func clickdidwill(_ sender: Any) {
        viewModel.input.myProperty = 6
    }
    
    
}

