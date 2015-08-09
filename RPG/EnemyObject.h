//
//  EnemyObject.h
//  RPG
//
//  Created by Jules on 11/19/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnemyObject : NSObject
{
@private
    int x;
    int y;
    int firstTime;
    int state;
    int range;
    //NSString *dialog;
    //NSString *yesDialog;
    //NSString *noDialog;
}

-(id)initWithI: (int)i: (int)j;
-(id)initWithI: (int)i: (int)j: (int)r;
-(int) getEnemyX;
-(int) getEnemyY;
-(void) setX: (int)i;
-(void) setY: (int)i;

-(void) setFirstTime: (int) i;
-(int) getFirstTime;

-(void) setEnemyState: (int) i;
-(int) getEnemyState;

-(void) setRange: (int) i;
-(int) getRange;

@end
