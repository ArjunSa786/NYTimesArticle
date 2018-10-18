//
//  File.swift
//  NY Times Articles
//


import Foundation
import UIKit

//1 Create the protocol
protocol ImageCachable {}

//2 creating a imageCache private instance
private  let imageCache = NSCache<NSString, UIImage>()

//3 UIImageview conforms to ImageCachable
extension UIImageView: ImageCachable {}

//4 creating a protocol extension to add optional function implementations,
extension ImageCachable where Self: UIImageView {
    
    typealias SuccessCompletion = (Bool) -> ()
    
    //5 creating the function
    func loadImageUsingCacheWithImageURLString(_ URLString: String, placeHolder: UIImage?, completion:
        @escaping SuccessCompletion) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
            }
            return
        }
        self.image = placeHolder
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                    }
                } else {
                    self.image = placeHolder
                }
            }).resume()
        } else {
            self.image = placeHolder
        }
    }
}
