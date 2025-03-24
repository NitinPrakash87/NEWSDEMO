//
//  NewsListViewApiManager.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

import Foundation

protocol NewsListViewApiManagerProtocol {
    func fetchNewsList(completionHandler: @escaping (Result<NewsListModel, ApiError>) -> Void)
}

final class NewsListViewApiManager: NewsListViewApiManagerProtocol {
    let networkManager = NetworkManager.shared
    
    func fetchNewsList(completionHandler: @escaping (Result<NewsListModel, ApiError>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b674ac6ea3c744ffab52cbf8eff300eb") else {
            return completionHandler(.failure(.apiError(error: CustomError(description: "Invalid url"))))
        }
        
        networkManager.dataTask(with: URLRequest(url: url)) { apiResult in
            completionHandler(apiResult)
        }
    }
}
