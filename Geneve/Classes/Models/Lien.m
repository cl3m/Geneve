//
//  Lien.m
//  Genève
//
//  Created by Clem on 17.08.09.
//  Copyright 2009 ROUGE41. All rights reserved.
//

#import "Lien.h"


@implementation Lien
@synthesize name,url,logo;

- (id)initWithNameUrlAndLogo:(NSString*)n url:(NSString*)u logo:(UIImage*)l {
	self.name = n;
	self.url = u;
	self.logo = l;
	
	return self;
}

@end
