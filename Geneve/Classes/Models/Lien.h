//
//  Lien.h
//  Genève
//
//  Created by Clem on 17.08.09.
//  Copyright 2009 ROUGE41. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Lien : NSObject {
	NSString  *name;
	NSString  *url;
	UIImage *logo;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) UIImage *logo;


- (id)initWithNameUrlAndLogo:(NSString*)n url:(NSString*)u logo:(UIImage*)l;


@end
