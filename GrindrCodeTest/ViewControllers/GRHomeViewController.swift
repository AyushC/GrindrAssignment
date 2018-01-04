//
//  GRHomeViewController.swift
//  GrindrCodeTest
//
//  Created by Ayush Chamoli on 12/20/17.
//  Copyright © 2017 Envoy. All rights reserved.
//

import UIKit

class GRHomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var viewModel = GRHomeViewModel()
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.itemSize = CGSize(width: width/3.5, height: 150)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        
        self.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        self.isLoading = true
        self.indicatorView.startAnimating()
        viewModel.requestQuestions { [weak self] (success, error) in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.indicatorView.stopAnimating()
                guard error == nil else {
                    if let responseError = error {
                        let alert = UIAlertController(title: "Error code: \(responseError._code)", message: responseError.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                if success {
                    // Reload data
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
}

extension GRHomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GRQuestionCollectionViewCell", for: indexPath) as! GRQuestionCollectionViewCell
        let question = viewModel.questions[indexPath.row]
        cell.configureCell(questionObject: question)
        return cell
    }
    
}

extension GRHomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let question = viewModel.questions[indexPath.row]
        if let link = question.link {
            guard let url = URL(string: link) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

