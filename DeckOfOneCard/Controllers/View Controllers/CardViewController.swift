//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Bryan Workman on 6/16/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func fetchImageAndUpdateViews(for card: Card){
        CardController.fetchImage(card: card) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.cardImageView.image = image
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    //MARK - Actions
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        CardController.fetchCard { [weak self] (result) in
            switch result {
            case .success(let card):
                self?.fetchImageAndUpdateViews(for: card)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    

}
