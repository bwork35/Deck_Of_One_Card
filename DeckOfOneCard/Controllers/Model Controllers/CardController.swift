//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Bryan Workman on 6/16/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        // 1 - URL
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1") else {return completion(.failure(.invalidURL))}
        
        
        // 2 - Contact server
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            //3 - Handle Errors
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            //4 - Check for Data
            guard let data = data else {return completion(.failure(.noData))}
            
            //5 - Decode json into a card
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else {return completion(.failure(.noData))}
                return completion(.success(card))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        
        // 1 - URL
        let url = card.image
        
        // 2 - Contact server
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            // 3 - Handle Errors
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            //4 - Check for image data
            guard let data = data else {return completion(.failure(.noData))}
            
            //5 - Initialize an image from the data
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            return completion(.success(image))
        }.resume()
    }
    
}
