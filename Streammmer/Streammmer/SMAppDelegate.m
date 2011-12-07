//
//  SMAppDelegate.m
//  Streammmer
//
//  Created by David Pitman on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SMAppDelegate.h"
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Shot.h"
#import "ShotsGalleryView.h"

@implementation SMAppDelegate

@synthesize window = _window;
@synthesize scrollView = _scrollView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    RKClient *client = [RKClient clientWithBaseURL:@"http://api.dribbble.com/"];
    RKObjectMapping *shotMapping = [RKObjectMapping mappingForClass:[Shot class]];
    [shotMapping mapKeyPath:@"id" toAttribute:@"identifier"];
    [shotMapping mapKeyPath:@"title" toAttribute:@"title"];
    [shotMapping mapKeyPath:@"url" toAttribute:@"url"];
    [shotMapping mapKeyPath:@"short_url" toAttribute:@"shortURL"];
    [shotMapping mapKeyPath:@"image_url" toAttribute:@"imageURL"];
    [shotMapping mapKeyPath:@"image_teaser_url" toAttribute:@"imageTeaserURL"];
    [shotMapping mapKeyPath:@"width" toAttribute:@"width"];
    [shotMapping mapKeyPath:@"height" toAttribute:@"height"];
    [shotMapping mapKeyPath:@"views_count" toAttribute:@"viewsCount"];
    [shotMapping mapKeyPath:@"likes_count" toAttribute:@"likesCount"];
    [shotMapping mapKeyPath:@"comments_count" toAttribute:@"commentsCount"];
    [shotMapping mapKeyPath:@"rebounds_count" toAttribute:@"reboundsCount"];
    [shotMapping mapKeyPath:@"rebound_source_id" toAttribute:@"reboundSourceID"];
    [shotMapping mapKeyPath:@"created_at" toAttribute:@"createdAt"];
    
    
    RKObjectManager* manager = [RKObjectManager objectManagerWithBaseURL:@"http://localhost:8000"];
    [[RKObjectManager sharedManager].mappingProvider setMapping:shotMapping forKeyPath:@"shots"];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/following.json" delegate:self];
}

// RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    Shot *shot = [objects objectAtIndex:0];
    NSLog(@"Loaded Shot ID #%@ -> Title: %@, URL: %@", shot.identifier, shot.title, shot.url);
    CALayer* superLayer = [CALayer layer];
    superLayer.layoutManager=[CAConstraintLayoutManager layoutManager];
    [superLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)];
    NSString* previousLayer = @"superlayer";
    CAConstraintAttribute relativeYPosition = kCAConstraintMaxY;
    for (int i = 0; i < 10; i++) {
        Shot* shot = (Shot*)[objects objectAtIndex:i];
        CALayer* shotLayer = [CALayer layer];
        shotLayer.name = [shot.identifier stringValue];
        //NSLog(@"URL %@", shot.imageURL);
         NSImage* shotImage = [[NSImage alloc] initWithContentsOfURL:shot.imageTeaserURL];
        //shotLayer.bounds = CGRectMake(0, 0, [shot.width floatValue], [shot.height floatValue]);
        shotLayer.bounds = CGRectMake(0, 0, shotImage.size.width, shotImage.size.height);
        shotLayer.contents = shotImage;
        [shotLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxY 
                                                            relativeTo:previousLayer 
                                                             attribute:relativeYPosition]];
        [shotLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidX 
                                                            relativeTo:@"superlayer" 
                                                             attribute:kCAConstraintMidX]];
        NSLog(@"Layer: %@ %@ <- %@", shotLayer, shotLayer.name, previousLayer);
        previousLayer = shotLayer.name;
        [superLayer addSublayer:shotLayer];
        relativeYPosition = kCAConstraintMinY;
    }
    [_scrollView setWantsLayer:YES];
    [_scrollView setLayer:superLayer];
    [_scrollView setNeedsLayout:YES];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
}

@end
