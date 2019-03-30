//
//
//  Created by Guilherme Leite Colares on 5/6/16.
//  Copyright © 2016 Guilherme Leite Colares.

import UIKit

class ImageLoader {
    var cache = NSCache<NSString, UIImage>()
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(_ urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        let urlStringConvert = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlStringConvert )
        
        DispatchQueue.global(qos: .background).async { 
            let data: NSData? = self.cache.object(forKey: urlString as NSString) as? NSData
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async {
                    completionHandler(image, urlString)
                }
                return
            }
            
            let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    completionHandler(nil, urlString)
                    return
                }
                
                if data != nil {
                    //let image = UIImage(data: data!)
                    if let image = UIImage(data: data!) {
                        self.cache.setObject(image, forKey: urlString as NSString)
                        DispatchQueue.main.async(execute: {
                            completionHandler(image, urlString)
                        })
                    }
                   
                    return
                }
            })
            downloadTask.resume()
        }
        
        
    }
}
