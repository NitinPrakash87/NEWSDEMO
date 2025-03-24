//
//  NewsListModel.swift
//  MyNewspaperApplication
//
//  Created by Nitin Prakash on 22/03/25.
//

struct NewsListModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
    var source: Source? = nil
    var author: String? = nil
    var title: String? = nil
    var description: String? = nil
    var url: String? = nil
    var urlToImage: String? = nil
    var publishedAt: String? = nil
    var content: String? = nil
    
    // Custom
    var numberOfComments: Int? = nil
    var numberOfLikes: Int? = nil
    var isImageDownloaded: Bool? = nil
}

struct Source : Codable {
    let id: String?
    let name: String?
}
