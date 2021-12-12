//
//  OtherViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

protocol OtherViewDelegate{
    func clickBtnOther(check:Bool)
}


class OtherViewController: BaseViewController {

   
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: (OtherViewDelegate)?
    
    fileprivate(set) var viewModel = OtherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
  
    }

}


extension OtherViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.input.list_Data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTableCell", for: indexPath) as? OtherTableCell else {
            return UITableViewCell()
        }
        cell.lab_Title.text = viewModel.input.list_Data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
       
        switch indexPath.row{
          case 0:
            let uiView : SwiftUIViewController = UIStoryboard.storyboard(storyboard: .Other).instantiateViewController()
            navigationController?.pushViewController(uiView, animated: true)
        case 1:
          let uiView : AFViewController = UIStoryboard.storyboard(storyboard: .Other).instantiateViewController()
          navigationController?.pushViewController(uiView, animated: true)
        case 2:
          let uiView : AlbumViewController = UIStoryboard.storyboard(storyboard: .Other).instantiateViewController()
          navigationController?.pushViewController(uiView, animated: true)
        default:
            return
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
