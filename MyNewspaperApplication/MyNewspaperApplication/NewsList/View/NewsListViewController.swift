//
//  NewsListViewController.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

import UIKit

final class NewsListViewController: UIViewController {
    @IBOutlet weak var newsListTableView: UITableView!
    let loader = UIActivityIndicatorView(style: .medium)
    
    let viewModel = NewsListViewModel(apiManager: NewsListViewApiManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsList()
        registerTableViewCells()
    }
        
    private func addLoader() {
        view.addSubview(loader)
        view.bringSubviewToFront(loader)
        loader.startAnimating()
    }
    
    private func removeLoader() {
        loader.removeFromSuperview()
    }
    
    private func registerTableViewCells() {
        newsListTableView.register(UINib(nibName: ArticleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
    }
    
    private func getNewsList() {
        addLoader()
        viewModel.getNewsList() { [weak self] in
            self?.newsListTableView.reloadData()
            self?.removeLoader()
        }
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsList()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var article = viewModel.newsList()?[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.descLabel.text = article.title
        cell.authorNameLabel.text = "By \(article.author ?? "")"
        
        if !(article.isImageDownloaded ?? false) {
            if let urlToImage = article.urlToImage,
               let url = URL(string: urlToImage) {
                DispatchQueue.global(qos: .background).async {
                    if let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imgView.image = image
                            article.isImageDownloaded = true
                        }
                    } else {
                        cell.imgView.image = .actions
                        article.isImageDownloaded = true
                    }
                    
                }
            } else {
                cell.imgView.image = .actions
                article.isImageDownloaded = true
            }
        }
        
        cell.contentViewWidthConstraint.constant = tableView.frame.size.width
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let article = viewModel.newsList()?[indexPath.row],
           let articleDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController {
            articleDetailViewController.viewModel.article = article
            navigationController?.pushViewController(articleDetailViewController, animated: true)
        }
    }
}
