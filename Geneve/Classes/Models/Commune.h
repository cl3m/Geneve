//
//  Commune.h
//  Genève
//
//  Created by Clem on 12.07.09.
//  Copyright 2009 ROUGE41. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Commune : NSObject {
	NSString  *name;
	NSString  *url;
	NSString  *postcode;
	UIImage *armoirie;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *postcode;
@property (nonatomic, retain) UIImage *armoirie;


- (id)initWithNameUrlPostcodeAndArmoirie:(NSString*)n url:(NSString*)u postcode:(NSString*)p armoirie:(UIImage*)a;

@end
