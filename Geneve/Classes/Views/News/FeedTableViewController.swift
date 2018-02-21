//
//  FeedTableViewController.swift
//
//  Copyright (c) 2017 Nuno Manuel Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
import FeedKit

let feedURL = URL(string: "https://www.ge.ch/rss-publications?titre=&type=86")!

class FeedTableViewController: GAITableViewController {
    
    var feed: RSSFeed?
    
    let parser = FeedParser(URL: feedURL)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parse asynchronously, not to block the UI.
        parser.parseAsync { [weak self] (result) in
            self?.feed = result.rssFeed
            
            // Then back to the Main thread to update the UI.
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
    }

}

// MARK: - Table View Data Source

extension FeedTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return self.feed?.items?.count ?? 0
        default: fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reusableCell()
        let item = feed?.items?[indexPath.row]
        cell.textLabel?.text = item?.title?.htmlToString ?? "[no title]" //very slow
        return cell
    }
    
}

// MARK: - Table View Delegate

extension FeedTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = feed?.items?[indexPath.row]
        let title = item?.title?.htmlToString ?? "Actualité"
        let attributedText = item?.description?.htmlToAttributedString
        let viewController = FeedDetailTableViewController(title: title, attributedText: attributedText)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
