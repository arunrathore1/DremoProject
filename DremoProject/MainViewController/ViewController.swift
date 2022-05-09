//
//  ViewController.swift
//  DremoProject
//
//  Created by Arun Singh on 09/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    var gorestArray: [Gorest] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCall()
        configureTableView()
        
    }
    
    
    private func ApiCall() {
        NetworkManager.getDataFromApi() { result in
            switch result {
            case .success(let gorestdata):
                self.gorestArray = gorestdata
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: String(describing: GorestCell.self), bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: GorestCell.self))
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gorestArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GorestCell.self), for: indexPath) as? GorestCell
        cell?.configureCell(data: gorestArray[indexPath.row])
        cell?.backgroundColor = .clear
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           UIView.animate(withDuration: 0.3) {
               self.tableView.performBatchUpdates(nil)
           }
       }
    
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = self.tableView.cellForRow(at: indexPath) as? GorestCell {
            cell.hideDetailView()
        }
    }
}

