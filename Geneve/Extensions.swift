//
//  Extensions.swift
//  Geneve
//
//  Created by Clem on 21.02.18.
//

import Foundation

extension GAI {
    static func trackScreen(_ name: String) {
    guard let tracker = GAI.sharedInstance().defaultTracker else { return }
    tracker.set(kGAIScreenName, value: name)
    guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
    tracker.send(builder.build() as [NSObject : AnyObject])
    }
}

class GAIViewController : UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GAI.trackScreen(title!)
    }
}

class GAITableViewController : UITableViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GAI.trackScreen(title!)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
                ]
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
