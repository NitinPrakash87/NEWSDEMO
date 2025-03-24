//
//  NewsListViewModel.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

protocol NewsListViewModelInputProtocol {
    func getNewsList(completionHandler: @escaping (() -> Void))
}

protocol NewsListViewModelOutputProtocol {
    func newsList() -> [Article]?
}

protocol NewsListViewModelProtocol: NewsListViewModelInputProtocol, NewsListViewModelOutputProtocol {
    var input: NewsListViewModelInputProtocol { get }
    var output: NewsListViewModelOutputProtocol { get }
}

final class NewsListViewModel: NewsListViewModelProtocol {
    var input : NewsListViewModelInputProtocol { self }
    var output : NewsListViewModelOutputProtocol { self }
    
    private let apiManager: NewsListViewApiManagerProtocol
    private var newsListModel: NewsListModel?
    
    init(apiManager: NewsListViewApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func getNewsList(completionHandler: @escaping (() -> Void)) {
        apiManager.fetchNewsList() { [weak self] apiResult in
            switch apiResult {
            case .success(let response):
                self?.newsListModel = response
                
            case .failure(let failure):
                switch failure {
                case .apiError(let responseError):
                    print(responseError!.description)
                }
            }
            completionHandler()
        }
    }
    
    func newsList() -> [Article]? {
        newsListModel?.articles
    }
}
