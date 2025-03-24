//
//  ArticleDetailsApiManger.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

import Foundation

protocol ApiDetailsApiManagerProtocol {
    func fetchArticleLikes(articleId: String, completionHandler: @escaping (Result<CommentsLikesModel, ApiError>) -> Void)
    func fetchArticleComments(articleId: String, completionHandler: @escaping (Result<CommentsLikesModel, ApiError>) -> Void)

}

final class ApiDetailsApiManager: ApiDetailsApiManagerProtocol {
    let networkManager = NetworkManager.shared

    func fetchArticleComments(articleId: String, completionHandler: @escaping (Result<CommentsLikesModel, ApiError>) -> Void) {
        guard let url = URL(string: "https://cn-news-info-api.herokuapp.com/comments/\(articleId)") else {
            return completionHandler(.failure(.apiError(error: CustomError(description: "Invalid url"))))
        }
        
        networkManager.dataTask(with: URLRequest(url: url)) { apiResult in
            completionHandler(apiResult)
        }
    }
    
    
    func fetchArticleLikes(articleId: String, completionHandler: @escaping (Result<CommentsLikesModel, ApiError>) -> Void) {
        guard let url = URL(string: "https://cn-news-info-api.herokuapp.com/likes/\(articleId)") else {
            return completionHandler(.failure(.apiError(error: CustomError(description: "Invalid url"))))
        }
        
        networkManager.dataTask(with: URLRequest(url: url)) { apiResult in
            completionHandler(apiResult)
        }
    }
}
