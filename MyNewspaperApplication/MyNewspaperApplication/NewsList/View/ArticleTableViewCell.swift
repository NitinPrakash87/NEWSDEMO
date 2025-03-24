//
//  ArticleTableViewCell.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

import UIKit

final class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var contentViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPage()
    }
    
    private func setupPage() {
        selectionStyle = .none
        authorNameLabel.font = UIFont.systemFont(ofSize: 12)
        descLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
