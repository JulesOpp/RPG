//
//  NPCObject.h
//  RPG
//
//  Created by Jules on 10/7/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPCObject : NSObject
{
    @private
    int x;
    int y;
    int state;
    NSString *dialog;
    NSString *yesDialog;
    NSString *noDialog;
}

- (id)initWithI: (int)i: (int)j: (NSString*) k: (NSString*) l: (NSString*) m;
-(int) getNpcX;
-(int) getNpcY;
-(void) setStat: (int) i;
-(NSString*)getDependentDialog;
-(void) setX: (int)i;
-(void) setY: (int)i;
-(NSString*) getDialog;
-(NSString*) getYesDialog;
-(NSString*) getNoDialog;

@end
