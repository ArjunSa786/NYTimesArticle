//
//  ArticleFeedEntity.swift
//  NY Times Articles
//


import Foundation
import UIKit

struct Article {
    
    var articleBy : String!
    var articleMedia : [Media]!
    var articlePublishedDate : String!
    var articleTitle : String!

    init(fromDictionary dictionary: NSDictionary){
        articleBy = dictionary["byline"] as? String
        articleMedia = [Media]()
        if let mediaArray = dictionary["media"] as? [NSDictionary]{
            for dic in mediaArray{
                let value = Media(fromDictionary: dic)
                articleMedia.append(value)
            }
        }
        articlePublishedDate = dictionary["published_date"] as? String
        articleTitle = dictionary["title"] as? String
    }
    
}

struct Media {
    
    var mediaMetaData : [MediaMetaData]!
    
    init(fromDictionary dictionary: NSDictionary){
        mediaMetaData = [MediaMetaData]()
        if let mediametadataArray = dictionary["media-metadata"] as? [NSDictionary]{
            for dic in mediametadataArray{
                let value = MediaMetaData(fromDictionary: dic)
                mediaMetaData.append(value)
            }
        }
    }
}

struct MediaMetaData {

    var url : String!
    
    init(fromDictionary dictionary: NSDictionary){
        url = dictionary["url"] as? String
    }
}
