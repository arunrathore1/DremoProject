//
//  GorestCell.swift
//  DremoProject
//
//  Created by Arun Singh on 09/05/22.
//

import UIKit

class GorestCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var tiiteLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 12
    }
    
    func configureCell(data: Gorest?) {
        tiiteLbl.text = "Title"
        bodyLbl.text = data?.body
    }
}

extension GorestCell {
    var isDetailViewHidden: Bool {
        return detailView.isHidden
    }

    func showDetailView() {
        detailView.isHidden = false
    }

    func hideDetailView() {
        detailView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }
}
