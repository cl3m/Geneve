//
//  FeedCell.swift
//  Geneve
//
//  Created by Clem on 28.02.18.
//

import UIKit
import FeedKit
import HTMLString
import Regex
import Kingfisher

class FeedCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    func configure(with item: RSSFeedItem) {
        titleLabel?.text = item.title?.removingHTMLEntities ?? "[no title]"
        if let date = Regex("<span[^>]*date-display-single[^>]*>([^<]*)<").firstMatch(in: item.description?.removingHTMLEntities ?? "")?.captures[0] {
            dateLabel?.text = date
        } else {
            dateLabel?.text = nil
        }
        
        let url = Regex("<img[^>]*src=\"([^\"]*)\"[^>]*>").firstMatch(in: item.description?.removingHTMLEntities ?? "")?.captures[0].flatMap({URL(string: $0)}) 
        thumbnailImageView?.kf.setImage(with: url, placeholder: UIImage())
    }
}
