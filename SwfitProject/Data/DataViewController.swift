//
//  DataViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture


protocol DataViewDelegate{
    func clickBtnData(check:Bool)
}


class DataViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: (DataViewDelegate)?
    
    fileprivate(set) var viewModel = DataViewModel()
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        tableView.delegate = self
//        tableView.dataSource = self
  
    }

}


//extension DataViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.input.list_Data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViewTableCell", for: indexPath) as? ViewTableCell else {
//            return UITableViewCell()
//        }
//        cell.lable_Title.text = viewModel.input.list_Data[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//
//}
