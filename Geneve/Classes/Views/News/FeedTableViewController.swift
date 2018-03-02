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
import HTMLString
import Regex

let feedURL = URL(string: "https://www.ge.ch/rss-publications?titre=&type=86")!

class FeedTableViewController: GAITableViewController {
    
    var feed: RSSFeed?
    
    let parser = FeedParser(URL: feedURL)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parse asynchronously, not to block the UI.
        parser?.parseAsync { [weak self] (result) in
            self?.feed = result.rssFeed
            
            // Then back to the Main thread to update the UI.
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FeedDetailTableViewController, let item = sender as? RSSFeedItem {
            controller.itemTitle = item.title?.removingHTMLEntities ?? ""
            controller.itemDate = Regex("<span[^>]*date-display-single[^>]*>[^ ]* ([^,]*),").firstMatch(in: item.description?.removingHTMLEntities ?? "")?.captures[0] ?? ""
            controller.itemDescription = ("<style>body {font-size:1.5em;}</style>"+(item.description ?? "")).replacingFirst(matching: "<span[^>]*date-display-single[^>]*>([^<]*)</span>", with: "").htmlToAttributedString
            controller.itemURL = URL(string: item.link!)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        cell.configure(with: feed!.items![indexPath.row])
        return cell
    }
    
}

// MARK: - Table View Delegate

extension FeedTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNews", sender: feed!.items![indexPath.row])
    }
}
