//
//  AppDelegate.m
//  RPG
//
//  Created by Jules on 9/22/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AppView.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setFrame:CGRectMake(300, 200, 730, 420) display:YES];
    [self.window setStyleMask:[self.window styleMask] & ~NSResizableWindowMask];
    AppView *view = [[AppView alloc] initWithFrame:_window.frame];
    [view setFrameOrigin:NSMakePoint(0, 0)];
    view->xPos = 110;
    view->yPos = 120;
    //[view ];
    //AppBasicFunctions *toBack = [[AppBasicFunctions alloc] initWithFrame:_window.frame];
    //[toBack setFrameOrigin:NSMakePoint(0, 0)];
    //[self.window.contentView addSubview:toBack];
    [self.window.contentView addSubview:view];
}

@end
