//
//  ArticleDetailsViewController.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

import UIKit
import WebKit

class ArticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    
    let viewModel = ArticleDetailsViewModel(apiManager: ApiDetailsApiManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
        fetchLikesAndComments()
    }
    
    // Populate with Url
    private func setupPage() {
        if let urlString = viewModel.output.pageUrl(),
           let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
    
    private func fetchLikesAndComments() {
        viewModel.input.getNumberOfLikesAndComments { [weak self] in
            self?.numberOfLikesLabel.text = self?.viewModel.numberOfLikes()
            self?.numberOfCommentsLabel.text = self?.viewModel.numberOfComments()
        }
    }
    
    // Populate without Content
//    private func setupPage() {
//        if let urlToImage = viewModel.article.urlToImage,
//           let url = URL(string: urlToImage) {
//            DispatchQueue.global(qos: .background).async { [weak self] in
//                if let data = try? Data(contentsOf: url),
//                   let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.imgView.image = image
//                    }
//                } else {
//                    self?.imgView.image = .actions
//                }
//                
//            }
//        } else {
//            imgView.image = .actions
//        }
//
//        detailLabel.text = viewModel.article.content
//        authorNameLabel.text = viewModel.article.author
//    }
}
