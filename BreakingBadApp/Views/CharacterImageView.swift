//
//  CharacterImageView.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 01.10.2021.
//

import UIKit

class CharacterImageView: UIImageView {
    
    func getImage(from url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        if let cachedImage = getCachedImage(from: url) {
//            print(1)
            image = cachedImage
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { data, response in
//            print(2)
            self.image = UIImage(data: data)
            self.saveDataToCache(with: data, and: response)
        }
        
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cashedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cashedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request =  URLRequest(url: url)
        if let cashedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cashedResponse.data)
        }
        return nil
    }
}
