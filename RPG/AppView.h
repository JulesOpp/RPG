//
//  AppView.h
//  RPG
//
//  Created by Jules on 9/22/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppView : NSView 
{
@public
    int xPos;
    int yPos;
    int currentWeapon;
    bool dead;
    bool menu;
    
    bool lock;

}

-(void) checkWin;

// KEY DOWN AND MAINTENENCE
-(void) keyDown:(NSEvent*)event;
-(BOOL) acceptsFirstResponder;
-(void) mouseDown:(NSEvent *)theEvent;
-(BOOL) canMove: (int) direction;
-(void) restart;

-(void) changeStage;

// DRAWING
-(void) drawRect:(NSRect)dirtyRect;
-(void) drawBackground: (NSRect) dirtyRect;
-(void) drawHouse: (NSRect) dirtyRect: (NSPoint) point: (int)direction;
-(void) drawFire: (NSRect) dirtyRect: (NSPoint) point;
-(void) drawWater: (NSRect) dirtyRect: (NSPoint) point;
-(void) drawSelf:(NSRect)dirtyRect;
-(void) drawMenu:(NSRect)dirtyRect;
-(void) drawUI: (NSRect) dirtyRect;
-(void) drawSkillShot;
-(void) drawStage: (NSRect) dirtyRect;

// NPC
-(void) checkNpc;
-(void) drawNPC:(NSRect)dirtyRect :(NSPoint)point: (NSString*) dia: (NSString*) yesDia: (NSString*) noDia;
-(void) drawDialog: (NSRect) dirtyRect;

// ENEMY
-(void) checkEnemy;
-(void) drawEnemy:(NSRect)dirtyRect :(NSPoint)point:(int)r;

// TELEPORT
-(void) checkTelep;
-(void) drawTelep: (NSRect)aRect: (int)a;

// IMMOVABLE OBJECTS
-(void) MyNSRectFill:(NSRect)aRect;

// FIRE
-(void) checkDmg;
-(void) DmgNSRectFill:(NSRect)aRect;

// WATER
-(void)WaterNSRectFill:(NSRect)aRect;

// SKILL SHOTS
-(void) shootSkillshot:(int)dir;
-(void) shootFireball:(NSTimer*)timer;
-(void) removeFireBall:(NSTimer*)timer;

// GOLD
-(void) drawGold: (NSRect)dirtyRect: (NSPoint) point;
-(void) checkGold;
-(void) checkGold: (int)x: (int)y;

// HEALTH POT
-(void) drawHealthPot: (NSRect)dirtyRect: (NSPoint) point;
-(void) checkHealthPot;
-(void) checkHealthPot: (int)x: (int)y;

@end

