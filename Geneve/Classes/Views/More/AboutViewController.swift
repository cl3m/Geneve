    //
//  AboutViewController.swift
//  Geneve
//
//  Created by Clem on 17.02.18.
//

import UIKit
import SafariServices
    
class AboutViewController: GAIViewController, SFSafariViewControllerDelegate {    
    @IBAction func contribute(_ sender: Any) {
        let viewController = SFSafariViewController(url: URL(string: "https://github.com/cl3m/Geneve")!)
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    //MARK: - SFSafariViewControllerDelegate
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
}
