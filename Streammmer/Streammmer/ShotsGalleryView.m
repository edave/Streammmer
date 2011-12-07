//
//  ShotsGalleryView.m
//  Streammmer
//
//  Created by David Pitman on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShotsGalleryView.h"
#import <QuartzCore/QuartzCore.h>
#import "Shot.h"

@implementation ShotsGalleryView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    
    return self;
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    [super drawRect:dirtyRect];
//    // Drawing code here.
//}

-(void)loadShots:(NSArray*)shots{
    CALayer* superLayer = [self layer];
    superLayer.layoutManager=[CAConstraintLayoutManager layoutManager];
    [superLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)];
    NSString* previousLayer = @"superlayer";
    for (int i = 0; i < 10; i++) {
        Shot* shot = (Shot*)[shots objectAtIndex:i];
        CALayer* shotLayer = [CALayer layer];
        shotLayer.borderWidth = 2;
        shotLayer.borderColor = CGColorCreateGenericRGB(255, 0, 0, 0.5);
        shotLayer.name = [shot.identifier stringValue];
        NSLog(@"URL %@", shot.imageURL);
        shotLayer.bounds = CGRectMake(0, 0, [shot.width floatValue], [shot.height floatValue]);
        NSImage* shotImage = [[NSImage alloc] initWithContentsOfURL:shot.imageURL];
        //shotLayer.contents = shotImage;
        [shotLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxY 
                                                        relativeTo:previousLayer 
                                                         attribute:kCAConstraintMaxY]];
        NSLog(@"Layer: %@ %@ <- %@", shotLayer, shotLayer.name, previousLayer);
        previousLayer = shotLayer.name;
        [superLayer addSublayer:shotLayer];
    }
    [self setLayer:superLayer];
    [self setNeedsLayout:YES];
    [self setNeedsDisplay:YES];
}

@end
