//
//  LiensCell.m
//  Genève
//
//  Created by Clem on 14.09.09.
//  Copyright 2009 ROUGE41. All rights reserved.
//

#import "LienCell.h"


@implementation LienCell

@synthesize image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
