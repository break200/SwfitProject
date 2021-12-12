//
//  UiinViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

protocol UiinViewDelegate{
    func clickBtnUI(check:Bool)
}


class UiinViewController: BaseViewController {

   
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: (UiinViewDelegate)?
    
    fileprivate(set) var viewModel = UiinViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
  
    }

}


extension UiinViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.input.list_Data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UIViewCell", for: indexPath) as? UIViewCell else {
            return UITableViewCell()
        }
        cell.lab_Title.text = viewModel.input.list_Data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
       
        switch indexPath.row{
          case 0:
            let uiView : GradientViewController = UIStoryboard.storyboard(storyboard: .UI).instantiateViewController()
            navigationController?.pushViewController(uiView, animated: true)
//        case 1:
//          let uiView : AFViewController = UIStoryboard.storyboard(storyboard: .Other).instantiateViewController()
//          navigationController?.pushViewController(uiView, animated: true)
//        case 2:
//          let uiView : AlbumViewController = UIStoryboard.storyboard(storyboard: .Other).instantiateViewController()
//          navigationController?.pushViewController(uiView, animated: true)
        default:
            return
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
