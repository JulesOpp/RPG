//
//  NPCObject.m
//  RPG
//
//  Created by Jules on 10/7/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NPCObject.h"
#import "StageObject.h"
#import "AppView.h"
#import "AppDelegate.h"

@implementation NPCObject

-(id)initWithI: (int)i: (int)j: (NSString*) k: (NSString*) l: (NSString*) m {
    self = [super init];
    if (self) {
        x = i;
        y = j;
        state = 0; // 0 default, 1 yes, 2 no
        dialog = [NSString stringWithString:k];
        yesDialog = [NSString stringWithString:l];
        noDialog = [NSString stringWithString:m];
    }
    return self;
}

-(void)setStat:(int)i {
    state = i;
}

-(int)getNpcX {
    return x;
}

-(int)getNpcY {
    return y;
}

-(NSString*)getDependentDialog {
    if (state == 0) return dialog;
    else if (state == 1) return yesDialog;
    else return noDialog;
}

-(NSString*)getDialog {
    return dialog;
}

-(NSString*)getYesDialog {
    return yesDialog;
}

-(NSString*)getNoDialog {
    return noDialog;
}

-(void)setX:(int)i {
    x = i;
}

-(void)setY:(int)i {
    y = i;
}

@end
