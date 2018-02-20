//
//  Commune.m
//  Genève
//
//  Created by Clem on 12.07.09.
//  Copyright 2009 ROUGE41. All rights reserved.
//

#import "Commune.h"


@implementation Commune
@synthesize name,url,postcode,armoirie;

- (id)initWithNameUrlPostcodeAndArmoirie:(NSString*)n url:(NSString*)u postcode:(NSString*)p armoirie:(UIImage*)a {
	self.name = n;
	self.url = u;
	self.postcode = p;
    self.armoirie = [UIImage imageWithCGImage:[a CGImage]
                                        scale:(2.0)
                                  orientation:(a.imageOrientation)];
	
	return self;
}


@end
