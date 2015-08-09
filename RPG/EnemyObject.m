//
//  EnemyObject.m
//  RPG
//
//  Created by Jules on 11/19/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "EnemyObject.h"

@implementation EnemyObject

-(id)initWithI: (int)i: (int)j {
    self = [super init];
    if (self) {
        x = i;
        y = j;
        firstTime = 1;
        state = 1;
        range = 1;
    }
    return self;
}

-(id)initWithI:(int)i :(int)j: (int)r {
    self = [super init];
    if (self) {
        x = i;
        y = j;
        firstTime = 1;
        state = 1;
        range = r;
    }
    return self;
}

-(int) getEnemyX { return x; }
-(int) getEnemyY { return y; }
-(void) setX: (int)i { x = i; }
-(void) setY: (int)i { y = i; }
-(void) setFirstTime:(int)i { firstTime = i; }
-(int) getFirstTime { return firstTime; }
-(void) setEnemyState:(int)i { state = i; }
-(int) getEnemyState { return state; }
-(void) setRange:(int)i { range = i; }
-(int) getRange { return range; }

@end
