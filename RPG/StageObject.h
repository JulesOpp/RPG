//
//  StageObject.h
//  RPG
//
//  Created by Jules on 10/2/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StageObject : NSObject
{
    @private 
    int immov[73][42];
    int fire[73][42];
    int water[73][42];
    NSMutableArray *skillX;
    NSMutableArray *skillY;
    NSMutableArray *skillColor;
    int gold[73][42];
    int healthPot[73][42];
    int telep[73][42];
    NSMutableArray *npc;
    NSMutableArray *enemy;
    
    bool firstTime;
}
- (id)init;

-(bool)getFirst;
-(void)firstTrue;
-(void)firstFalse;

-(void)setImmov: (int)x: (int)y;
-(int)getImmov: (int)x: (int)y;

-(void)setFire: (int)x: (int)y;
-(int)getFire: (int)x: (int)y;
-(void)killFire: (int)x: (int)y;

-(void)setWater: (int)x: (int)y;
-(int)getWater: (int)x: (int)y;
-(void)killWater: (int)x: (int)y;

-(void)setSkillshot: (int)x: (int)y: (int)z;
-(void)takeSkillshot;
-(int)getSkillshotX: (int)i;
-(int)getSkillshotY: (int)i;
-(int)getSkillshotZ:(int)i;
-(int)getSkillCount;

-(void)setGold: (int)x: (int)y;
-(void)takeGold: (int)x:(int)y;
-(int)getGold: (int)x: (int)y;

-(void)setHealthPot: (int)x: (int)y;
-(void)takeHealthPot: (int)x: (int)y;
-(int)getHealthPot: (int)x: (int)y;

-(void)setTelepRight: (int)x: (int)y;
-(void)setTelepLeft: (int)x: (int)y;
-(void)setTelepUp: (int)x: (int)y;
-(void)setTelepDown: (int)x: (int)y;
-(int)getTelep: (int)x: (int)y;

-(void)setNPC: (int)x: (int)y: (NSString*)dia: (NSString*) yesDia: (NSString*) noDia;
-(int)getNPC: (int)x: (int)y;
-(int)getNPCpos: (int)x: (int)y;
-(NSString*)getNPCdialog: (int)i;
-(void)setState: (int)x: (int)i;

-(void)setEnemy: (int)x: (int)y:(int)r;
-(int)getEnemy: (int)x: (int)y;
-(int)getEnemypos: (int)x: (int)y;
-(void)killEnemy:(int)x :(int)y;
-(void) setEnemyFirst: (int)x: (int)y: (int)i;
-(int) getEnemyFirst: (int)x: (int)y;
-(int) getEnemyStatus:(int)x:(int)y;
-(int) checkEnemy:(int)x:(int)y;

@end
