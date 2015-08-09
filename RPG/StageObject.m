//
//  StageObject.m
//  RPG
//
//  Created by Jules on 10/2/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//
// Immov - 0-move through, 1-wall
// Fire -  0-no fire, 1-fire, 2-taken fire
// Gold -  0-no gold, 1-gold, 2-taken gold
// Telep - -1-right, 1-left, 2-up, 3-down

#import "StageObject.h"
#import "AppView.h"
#import "AppDelegate.h"
#import "NPCObject.h"
#import "EnemyObject.h"

@implementation StageObject

-(id)init {
    self = [super init];
    if (self) {
        for (int i=0; i<73;i++) for (int j=0;j<42; j++) {
            immov[i][j] = 0;
            fire[i][j] = 0;
            water[i][j] = 0;
            gold[i][j] = 0;
            telep[i][j] = 0;
            firstTime = true;
        }
        skillX = [[NSMutableArray alloc] init];
        skillY = [[NSMutableArray alloc] init];
        skillColor = [[NSMutableArray alloc] init];
        npc = [[NSMutableArray alloc] init];
        enemy = [[NSMutableArray alloc] init];
    }
    return self;
}

-(bool)getFirst   { return firstTime; }
-(void)firstTrue  { firstTime = true; }
-(void)firstFalse { firstTime = false; }

-(void)setImmov: (int)x: (int)y { immov[x][y] = 1; }
-(int)getImmov:  (int)x: (int)y { return immov[x][y]; }

-(void)setFire: (int)x: (int)y { fire[x][y] = 1; }
-(int)getFire:  (int)x: (int)y { return fire[x][y]; }
-(void)killFire: (int)x: (int)y { if(fire[x][y]==1) fire[x][y] = 2; }

-(void)setWater:(int)x :(int)y { water[x][y] = 1; }
-(int)getWater:(int)x :(int)y { return water[x][y]; }
-(void)killWater:(int)x :(int)y { if(water[x][y]==1) water[x][y] = 2; }

-(void)setGold: (int)x: (int)y { gold[x][y] = 1; }
-(void)takeGold:(int)x: (int)y { gold[x][y] = 2; }
-(int)getGold:  (int)x: (int)y { return gold[x][y]; }

-(void)setHealthPot:(int)x :(int)y { healthPot[x][y] = 1; }
-(void)takeHealthPot:(int)x :(int)y { healthPot[x][y] = 2; }
-(int)getHealthPot:(int)x :(int)y { return healthPot[x][y]; }

-(void)setTelepLeft: (int)x :(int)y { telep[x][y] = 1; }
-(void)setTelepRight:(int)x :(int)y { telep[x][y] = -1; }
-(void)setTelepUp:   (int)x :(int)y { telep[x][y] = 2; }
-(void)setTelepDown: (int)x :(int)y { telep[x][y] = 3; }
-(int)getTelep:      (int)x :(int)y { return telep[x][y]; }

-(void)setSkillshot: (int)x: (int)y: (int)z {
    [skillX addObject:[NSNumber numberWithInt:x]];
    [skillY addObject:[NSNumber numberWithInt:y]];
    [skillColor addObject:[NSNumber numberWithInt:z]];
}

-(void)takeSkillshot {
    [skillX removeObjectAtIndex:0];
    [skillY removeObjectAtIndex:0];
    [skillColor removeObjectAtIndex:0];
}

-(int)getSkillshotX: (int)i { return [[skillX objectAtIndex:i] intValue]; }
-(int)getSkillshotY: (int)i { return [[skillY objectAtIndex:i] intValue]; }
-(int)getSkillshotZ: (int)i { return [[skillColor objectAtIndex:i] intValue]; }
-(int)getSkillCount { return [skillX count]; }

-(void)setNPC:(int)x :(int)y: (NSString*)dia: (NSString*)yesDia: (NSString*)noDia {
    NPCObject *temp = [[NPCObject alloc] initWithI:x :y: dia: yesDia: noDia];
    [npc addObject:temp];
}

-(int)getNPC:(int)x: (int)y {
    for (int i=0; i<[npc count]; i++) if ([[npc objectAtIndex:i] getNpcX] == x && [[npc objectAtIndex:i] getNpcY] == y) return 1;
    return 0;
}

-(int)getNPCpos: (int)x: (int)y {
    for (int i=0; i<[npc count]; i++) if ([[npc objectAtIndex:i] getNpcX] == x && [[npc objectAtIndex:i] getNpcY] == y) return i;
    return -1;
}

-(NSString*) getNPCdialog: (int)i {
    return [[npc objectAtIndex:i] getDependentDialog];
}

-(void)setState:(int)x:(int) i {
    if (i != -1) [[npc objectAtIndex:i] setStat:x];
}

-(void)setEnemy:(int)x :(int)y:(int)r {
    for (int i=0; i<[enemy count]; i++) if ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY] == y)
        return;
    EnemyObject *temp = [[EnemyObject alloc] initWithI:x :y :r];
    [enemy addObject:temp];
}

-(int)getEnemy:(int)x :(int)y { for (int i=0; i<[enemy count]; i++) if ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY] == y) return 1; return 0; }
-(int)getEnemypos:(int)x :(int)y { for (int i=0; i<[enemy count]; i++) if ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY] == y) return i; return -1; }

-(void)killEnemy:(int)x :(int)y {
    for (int i=0; i<[enemy count]; i++) if ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY] == y)
        [[enemy objectAtIndex:i] setEnemyState:0];
}

-(int) getEnemyStatus:(int)x:(int)y {
    for (int i=0; i<[enemy count]; i++) if ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY] == y)
        return [[enemy objectAtIndex:i] getEnemyState];
    return -1;
}

-(void) setEnemyFirst: (int)x: (int)y: (int)i {
    for (int i=0; i<[enemy count]; i++) if ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY] == y)
        [[enemy objectAtIndex:i] setFirstTime:i];
}

-(int) getEnemyFirst:(int)x :(int)y {
    for (int i=0; i<[enemy count]; i++) if ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY] == y)
        return [[enemy objectAtIndex:i] getFirstTime];
    return -1;
}

-(int) checkEnemy:(int)x:(int)y {
    for (int i=0; i<[enemy count]; i++) for (int j=1; j<=[[enemy objectAtIndex:i] getRange]; j++)
        if ([[enemy objectAtIndex:i] getEnemyState] == 1)
            if (([[enemy objectAtIndex:i] getEnemyX]+j == x && [[enemy objectAtIndex:i] getEnemyY] == y) || ([[enemy objectAtIndex:i] getEnemyX]-j == x && [[enemy objectAtIndex:i] getEnemyY] == y) || ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY]+j == y) || ([[enemy objectAtIndex:i] getEnemyX] == x && [[enemy objectAtIndex:i] getEnemyY]-j == y)) return 1;
    return 0;
}

@end