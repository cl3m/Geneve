    //
//  AboutViewController.swift
//  Geneve
//
//  Created by Clem on 17.02.18.
//

import UIKit
import SafariServices

class AboutViewController: UIViewController, SFSafariViewControllerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: title!)
        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
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
