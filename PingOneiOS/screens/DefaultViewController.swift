//
//  DefaultViewController.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 9/27/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
import UIKit

class DefaultViewController: UIViewController {
    
    private let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoadingSpionner()
    }
    
    private func createLoadingSpionner() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
    }
    
    func openLoginView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    func openMainView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    func showLoading() {
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoading() {
        alert.dismiss(animated: true, completion: nil)
    }
    
    func openDetails(dictionary: Dictionary<String, Any>) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailsViewController
        viewController.dictionary = dictionary
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
