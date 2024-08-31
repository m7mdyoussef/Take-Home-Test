//
//  BaseViewController.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import UIKit

class BaseViewController: UIViewController {
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoading() {
        activityIndicator.center = self.view.center
        activityIndicator.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        activityIndicator.color = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showAlert(title:String,body:String,actions:[UIAlertAction]){
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertController.Style.alert)
        for action in actions{
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    func configureNavigationBarTitle(_ title: String, fontSize: CGFloat) {
        // Create a label with the desired styling
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left

        // Create a container view to hold the label
        let titleContainerView = UIView()
        titleContainerView.addSubview(titleLabel)

        // Set up constraints for the titleLabel within the container
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor)
        ])

        // Set the container width based on label size
        titleContainerView.frame = CGRect(x: 0, y: 0, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)

        // Create a UIBarButtonItem to hold the container view
        let leftTitleItem = UIBarButtonItem(customView: titleContainerView)

        // Set the leftBarButtonItems to align the title to the left
        navigationItem.leftBarButtonItems = [leftTitleItem]
    }



}
