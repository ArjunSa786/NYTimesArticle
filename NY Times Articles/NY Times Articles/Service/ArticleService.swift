//
//  NewsFeedService.swift
//  NY Times Articles
//


import Foundation
import UIKit

//1 using associatedType in protocol
protocol GetArticle {
    associatedtype T
    func getArticlesList(completion: @escaping (Result<T>) -> Void)
}

//2 conform to protocol
struct ArticleService: GetArticle {
    
    //3 EndPoint
    let endpoint: String = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/30.json?apikey=b0f06efcd41f461cb897f76e312d372f"
    
    let downloader = JSONDownloader()
    
    //the associated type is inferred by <[Article?]>
    typealias CompletionHandler = (Result<[Article?]>) -> ()
    
    //4 protocol required function
    func getArticlesList(completion: @escaping CompletionHandler) {
        // Checking URL is Valid
        guard let url = URL(string: self.endpoint) else {
            completion(.Error(.invalidURL))
            return
        }
        //5 using the JSONDownloader function
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    //6 parsing the Json response
                    guard let articleListArray = json["results"] as? [[String: AnyObject]] else {
                        completion(.Error(.jsonParsingFailure))
                        return
                    }
                    
                    //7 maping the array and create Article objects
                    let articleArray = articleListArray.map{Article(fromDictionary: $0 as NSDictionary)}
                    completion(.Success(articleArray))
                }
            }
        }
        task.resume()
    }
}


