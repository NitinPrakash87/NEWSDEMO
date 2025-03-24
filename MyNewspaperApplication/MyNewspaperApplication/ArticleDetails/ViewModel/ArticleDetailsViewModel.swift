//
//  ArticleDetailsViewModel.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

import Foundation

protocol ArticleDetailsViewModelInputProtocol {
    func getNumberOfLikesAndComments(completionHandler: @escaping (() -> Void))
}

protocol ArticleDetailsViewModelOutputProtocol {
    func numberOfLikes() -> String?
    func numberOfComments() -> String?
    func pageUrl() -> String?
}

protocol ArticleDetailsViewModelProtocol: ArticleDetailsViewModelInputProtocol, ArticleDetailsViewModelOutputProtocol {
    var input: ArticleDetailsViewModelInputProtocol { get }
    var output: ArticleDetailsViewModelOutputProtocol { get }
}

final class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol {
    var input : ArticleDetailsViewModelInputProtocol { self }
    var output : ArticleDetailsViewModelOutputProtocol { self }
    
    private let apiManager: ApiDetailsApiManagerProtocol
    var article = Article()

    init(apiManager: ApiDetailsApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    //MARK:- Business Logic
    
    private func getArticleId() -> String {
        article.url?.components(separatedBy: "https://").last ?? "".replacingOccurrences(of: "/", with: "-")
    }
    
    
    //MARK: - Network
    
    func getNumberOfLikesAndComments(completionHandler: @escaping (() -> Void)) {
        let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "MyNewspaperApplication" + ".dispatchgroup", attributes: .concurrent, target: .main)
        let group = DispatchGroup()
        group.enter()
        queue.async(group: group) {
            self.getNumberOfLikes {
                group.leave()
            }
        }
        
        group.enter()
        queue.async(group: group) {
            self.getNumberOfComments {
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            completionHandler()
        }
    }

    private func getNumberOfLikes(completionHandler: @escaping (() -> Void)) {
        apiManager.fetchArticleLikes(articleId: getArticleId()) { [weak self] apiResult in
            switch apiResult {
            case .success(let response):
                self?.article.numberOfLikes = response.numberOfLikes
                
            case .failure(let failure):
                switch failure {
                case .apiError(let responseError):
                    print(responseError!.description)
                }
            }
            completionHandler()
        }
    }
    
    private func getNumberOfComments(completionHandler: @escaping (() -> Void)) {
        apiManager.fetchArticleComments(articleId: getArticleId()) { [weak self] apiResult in
            switch apiResult {
            case .success(let response):
                self?.article.numberOfComments = response.numberOfComments
                
            case .failure(let failure):
                switch failure {
                case .apiError(let responseError):
                    print(responseError!.description)
                }
            }
            completionHandler()
        }
    }

    
    func numberOfLikes() -> String? {
        "\(article.numberOfLikes ?? 0) Likes"
    }
    
    func numberOfComments() -> String? {
        "\(article.numberOfComments ?? 0) Comments"
    }
    
    func pageUrl() -> String? {
        article.url
    }
}

