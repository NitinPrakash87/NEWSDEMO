//
//  MockArticleDetailsApiManager.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 24/03/25.
//

@testable import MyNewspaperApplication

class MockArticleDetailsApiManager: ApiDetailsApiManagerProtocol {
    func fetchArticleLikes(articleId: String, completionHandler: @escaping (Result<MyNewspaperApplication.CommentsLikesModel, MyNewspaperApplication.ApiError>) -> Void) {
        completionHandler(.success(CommentsLikesModel(numberOfLikes: 11, numberOfComments: nil)))
    }
    
    func fetchArticleComments(articleId: String, completionHandler: @escaping (Result<MyNewspaperApplication.CommentsLikesModel, MyNewspaperApplication.ApiError>) -> Void) {
        completionHandler(.success(CommentsLikesModel(numberOfLikes: nil, numberOfComments: 88)))
    }
}
                                        
