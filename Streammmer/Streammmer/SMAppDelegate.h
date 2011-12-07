//
//  SMAppDelegate.h
//  Streammmer
//
//  Created by David Pitman on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property(retain) IBOutlet NSView* scrollView;

@end
