//
//  ViewController.swift
//  Jokes
//
//  Created by Chris on 06/06/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let fetcher = JokeFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func didTapRandomJokeButton(_ sender: Any) {
        fetcher.fetchRandomJoke { result in
            print(result)
        }
    }
}

