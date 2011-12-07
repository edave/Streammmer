//
//  Shots.h
//  Streammmer
//
//  Created by David Pitman on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface Shot : NSObject

// Mapping out the Dribbbl API
@property(retain) NSNumber* identifier;
@property(retain) NSString* title;

@property(retain) NSURL* url;
@property(retain) NSURL* shortURL;
@property(retain) NSURL* imageURL;
@property(retain) NSURL* imageTeaserURL;

@property(retain) NSNumber* width;
@property(retain) NSNumber* height;
@property(retain) NSNumber* viewsCount;
@property(retain) NSNumber* likesCount;
@property(retain) NSNumber* commentsCount;
@property(retain) NSNumber* reboundsCount;
@property(retain) NSNumber* reboundSourceID;
@property(retain) NSDate* createdAt;

@end
