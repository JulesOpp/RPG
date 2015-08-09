//
//  AppView.m
//  RPG
//
//  Created by Jules on 9/22/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AppView.h"
#import "AppDelegate.h"
#import "MacroDefinitions.h"
#import "StageObject.h"

@implementation AppView

StageObject *stages[10][10];

// Skill shots
int fireBallCost;
int fireBallLength;
int currentWeapon;

// Stats
int health;
int mana;
int gold;

// State
bool dead;
bool menu;
bool win;
int stageX;
int stageY;
int selectedSkill;
int moveInt;
int dialog;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i=0; i<10; i++) for (int j=0;j<10;j++) stages[i][j] = [[StageObject alloc] init];
        
        health = 100;
        mana = 100;
        gold = 0;
        
        dead = false;
        menu = false;
        win = false;
        
        stageX = 0;
        stageY = 0;
        selectedSkill = 1;
        moveInt = 10;
        
        fireBallCost = 10;
        fireBallLength = 5;
        currentWeapon = 0;
        dialog = -1;
        
        lock = false;
    }
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    xPos = (int)point.x/10;
    yPos = (int)point.y/10;
    xPos *= 10;
    yPos *= 10;
    NSLog(@"%f %f",point.x, point.y);
    [self display];
}

- (void)drawRect:(NSRect)dirtyRect {
    [self drawBackground: dirtyRect];
    [self drawSelf: dirtyRect];
    if (dialog != -1) [self drawDialog:dirtyRect];
    if (menu == true) [self drawMenu: dirtyRect];
}

-(void)changeStage {
    xPos = 300;
    yPos = 200;
}

-(void)drawStage: (NSRect) dirtyRect {
    if (stageX == 0 && stageY == 0) {
        // Houses
        [self drawHouse:dirtyRect :NSMakePoint(30, 100): 2];
        
        [self drawHouse:dirtyRect :NSMakePoint(90, 40): 3];
        [self drawHouse:dirtyRect :NSMakePoint(150, 40): 3];
        [self drawHouse:dirtyRect :NSMakePoint(210, 40): 3];
        [self drawHouse:dirtyRect :NSMakePoint(270, 40): 3];
            
        // Fire
        for (int i=0; i<16;i++) for (int j=0;j<13;j++)
            if (i!=8||j!=6) [self drawFire:dirtyRect :NSMakePoint(310+i*10, 210+j*10)];
        
        // Water
        for (int i=0; i<5;i++) for (int j=0;j<6;j++)
            [self drawWater:dirtyRect :NSMakePoint(110+i*10, 230+j*10)];
        
        // Gold
        if ([stages[stageX][stageY] getFirst]) {
            for (int i=0; i<10; i++) for (int j=0; j<10; j++) [self drawGold:dirtyRect :NSMakePoint(500+i*10, 100+j*10)];
            [self drawGold:dirtyRect :NSMakePoint(50, 120)];
            [self drawGold:dirtyRect :NSMakePoint(170, 60)];
            [self drawGold:dirtyRect :NSMakePoint(230, 60)];
            [self drawGold:dirtyRect :NSMakePoint(290, 60)];
        }
        else for (int i=0;i<73; i++) for (int j=0;j<42;j++) if ([stages[stageX][stageY] getGold:i:j] == 1)
            [self drawGold:dirtyRect :NSMakePoint(i*10, j*10)];
        
        // Health Pot
        if ([stages[stageX][stageY] getFirst]) {
            [self drawHealthPot:dirtyRect :NSMakePoint(20, 20)];
            for (int i=0;i<5;i++) for (int j=0;j<5; j++) [self drawHealthPot:dirtyRect :NSMakePoint(360+i*10, 150+j*10)];
        }
        else for (int i=0;i<73;i++) for (int j=0; j<42; j++) if([stages[stageX][stageY] getHealthPot:i :j] ==1)
            [self drawHealthPot:dirtyRect :NSMakePoint(i*10, j*10)];
        
        [stages[stageX][stageY] firstFalse];     
        
        // NPC
        [self drawNPC:dirtyRect :NSMakePoint(110, 60): @"This should work! :)":@"YES!!!":@"Nope?"];
        [self drawNPC:dirtyRect :NSMakePoint(200,200):@"I'm at 200,200":@"Still at 200,200":@"YOU CANT GET RID OF ME"];
        [self drawNPC:dirtyRect :NSMakePoint(390, 270) :@"Save me superman...":@"Thank you mister":@"YOU KILLED ME"];
        
        // ENEMY
        [self drawEnemy:dirtyRect :NSMakePoint(230, 200):1];
        [self drawEnemy:dirtyRect :NSMakePoint(230, 150):2];
        [self drawEnemy:dirtyRect :NSMakePoint(590, 290):5];
    }
    else if (stageX == 1 && stageY == 0) {
        [self drawFire:dirtyRect :NSMakePoint(500, 100)];
        [self drawHouse:dirtyRect :NSMakePoint(30, 30): 2];
        
        if ([stages[stageX][stageY] getFirst]) for (int i=0; i<20; i++) for (int j=0;j<10;j++)
            [self drawGold:dirtyRect :NSMakePoint(20+i*10, 200+j*10)];
        else for (int i=0;i<73; i++) for (int j=0;j<42;j++) if ([stages[stageX][stageY] getGold:i:j] == 1)
            [self drawGold:dirtyRect :NSMakePoint(i*10, j*10)];
        [stages[stageX][stageY] firstFalse];
    }
    else if (stageX == 2 && stageY == 0) {
        for(int i=0;i<67;i++) for (int j=0;j<36;j++) {
            [self drawFire:dirtyRect :NSMakePoint(30+i*10, 20+j*10)];
        }
    }
    else if (stageX == 0 && stageY == 1) {
        [self drawHouse:dirtyRect :NSMakePoint(340, 190): 0];
        [self drawNPC:dirtyRect :NSMakePoint(360, 210) :@"Want to trade 500 gold for your soul?":@"Deal is done":@"Ok"];
        
        // Water
        for (int i=0; i<69;i++) for (int j=0;j<1;j++)
            [self drawWater:dirtyRect :NSMakePoint(20+i*10, 20+j*10)];
        for (int i=0; i<1;i++) for (int j=0;j<5;j++)
            [self drawWater:dirtyRect :NSMakePoint(20+i*10, 30+j*10)];
        for (int i=0; i<69;i++) for (int j=0;j<1;j++)
            [self drawWater:dirtyRect :NSMakePoint(20+i*10, 80+j*10)];
        for (int i=0; i<35;i++) for (int j=0;j<1;j++)
                [self drawWater:dirtyRect :NSMakePoint(10+i*10, 100+j*10)];
        for (int i=0; i<35;i++) for (int j=0;j<1;j++)
            [self drawWater:dirtyRect :NSMakePoint(370+i*10, 100+j*10)];
        for (int i=0; i<1;i++) for (int j=0;j<5;j++)
            [self drawWater:dirtyRect :NSMakePoint(700+i*10, 30+j*10)];
    }
    else if (stageX == 1 && stageY == 1) {
        for (int i=0; i<11;i++) for (int j=0;j<6;j++) {
            [self drawHouse:dirtyRect :NSMakePoint(30+60*i,30+60*j): 0];
            [self drawNPC:dirtyRect :NSMakePoint(30+60*i+20, 30+60*j+20):[NSString stringWithFormat:@"Pos: %d %d",i,j]:@"Ok" :@"Ok"];
        }
    }
}

-(void)drawBackground: (NSRect) dirtyRect {
    [[NSColor greenColor] set];
    NSRectFill(dirtyRect);
    
    [self drawStage: dirtyRect];
    
    // Black frame
    [[NSColor blackColor] set];
    [self MyNSRectFill:CGRectMake(0, 0, 340, 10)];
    [self MyNSRectFill:CGRectMake(380, 0, 340, 10)];
    
    [self MyNSRectFill:CGRectMake(0, 0, 10, 180)];
    [self MyNSRectFill:CGRectMake(0, 220, 10, 180)];
    
    [self MyNSRectFill:CGRectMake(0, 390, 340, 10)];
    [self MyNSRectFill:CGRectMake(380, 390, 340, 10)];
    
    [self MyNSRectFill:CGRectMake(720, 0, 10, 180)];
    [self MyNSRectFill:CGRectMake(720, 220, 10, 180)];
    
    // Entrance / Exit
    [[NSColor whiteColor] set];
    [self drawTelep:(CGRectMake(340,0,40,10)):2];
    [self drawTelep:(CGRectMake(0,180,10,40)):-1];
    [self drawTelep:(CGRectMake(340,390,40,10)):3];
    [self drawTelep:(CGRectMake(720,180,10,40)):1];
    
    // UI - mana and health
    [self drawUI: dirtyRect];
    
    // Skill shots
    switch (currentWeapon) {
        case 0: [[NSColor redColor] set]; break;
        case 1: [[NSColor blueColor] set]; break;
        case 2: [[NSColor magentaColor] set]; break;
        case 3: [[NSColor yellowColor] set]; break;
    }
    
    [self drawSkillShot];
    
    if (dead == true) {
        [[NSColor blueColor] set];
        NSRectFill(CGRectMake(200, 100, 300, 200));
        [[NSColor whiteColor] set];
        NSRectFill(CGRectMake(225, 125, 250, 150));
        NSString *deadStr = [NSString stringWithString:@"Game Over\nPress 'r' to restart"];
        [deadStr drawInRect:NSMakeRect(350, 200, 350, 50) withAttributes:nil];
    }
    
    if (win == true) {
        [[NSColor blueColor] set];
        NSRectFill(CGRectMake(200, 100, 300, 200));
        [[NSColor whiteColor] set];
        NSRectFill(CGRectMake(225, 125, 250, 150));
        NSString *winStr = [NSString stringWithString:@"You win\nPress 'r' to restart"];
        [winStr drawInRect:NSMakeRect(350, 200, 350, 50) withAttributes:nil];
    }
}

-(void) drawNPC:(NSRect)dirtyRect :(NSPoint)point: (NSString*) dia: (NSString*) yesDia: (NSString*) noDia {    
    [stages[stageX][stageY] setNPC:(point.x)/10 :(point.y)/10:dia:yesDia:noDia];  
    
    [[NSColor blueColor] set];
    NSRectFill(CGRectMake(point.x+4,point.y+4,2,2));
    NSRectFill(CGRectMake(point.x+2,point.y+2,6,2));
    NSRectFill(CGRectMake(point.x,point.y,4,2));
    NSRectFill(CGRectMake(point.x+6,point.y,4,2));
    [[NSColor blackColor] set];
    NSRectFill(CGRectMake(point.x+3,point.y+6,4,4));
    
}

-(void) drawEnemy:(NSRect)dirtyRect :(NSPoint)point:(int)r {
    if ([stages[stageX][stageY] getEnemy:point.x/10 :point.y/10] == 0) {
        [stages[stageX][stageY] setEnemy:(point.x)/10 :(point.y)/10:r];
        //[enemyFirst addObject:[NSNumber numberWithInt:1]];
        //enemyFirst = 0;
    }

    if ([stages[stageX][stageY] getEnemyStatus:point.x/10 :point.y/10] == 1) {
        [[NSColor redColor] set];
        NSRectFill(CGRectMake(point.x+4,point.y+4,2,2));
        NSRectFill(CGRectMake(point.x+2,point.y+2,6,2));
        NSRectFill(CGRectMake(point.x,point.y,4,2));
        NSRectFill(CGRectMake(point.x+6,point.y,4,2));
        [[NSColor blackColor] set];
        NSRectFill(CGRectMake(point.x+3,point.y+6,4,4));
        
        [[NSColor magentaColor] set];
        for (int i=1; i<=r; i++) {
            NSRectFill(CGRectMake(point.x-10*i+3,point.y+3,4,4));
            NSRectFill(CGRectMake(point.x+3,point.y+10*i+3,4,4));
            NSRectFill(CGRectMake(point.x+3,point.y-10*i+3,4,4));
            NSRectFill(CGRectMake(point.x+10*i+3,point.y+3,4,4));
        }
    }
}

-(void) drawTelep: (NSRect)aRect: (int)a {
    NSRectFill(aRect);
    for (int i=0; i<aRect.size.width; i += 10) {
        for (int j=0; j<aRect.size.height; j += 10) {
            if (a == 1)
                [stages[stageX][stageY] setTelepLeft:(i+aRect.origin.x)/10 :(j+aRect.origin.y)/10];
            else if (a == -1)
                [stages[stageX][stageY] setTelepRight:(i+aRect.origin.x)/10 :(j+aRect.origin.y)/10];
            else if (a == 2)
                [stages[stageX][stageY] setTelepDown:(i+aRect.origin.x)/10 :(j+aRect.origin.y)/10];
            else if (a == 3)
                [stages[stageX][stageY] setTelepUp:(i+aRect.origin.x)/10 :(j+aRect.origin.y)/10];
        }
    }
}

-(void)MyNSRectFill:(NSRect)aRect {
    NSRectFill(aRect);
    for (int i=0; i<aRect.size.width; i += 10) for (int j=0; j<aRect.size.height; j += 10)
        [stages[stageX][stageY] setImmov:(i+aRect.origin.x)/10 :(j+aRect.origin.y)/10];
}

-(void)DmgNSRectFill:(NSRect)aRect {
    NSRectFill(aRect);
    for (int i=0; i<aRect.size.width; i += 10) for (int j=0; j<aRect.size.height; j += 10)
        [stages[stageX][stageY] setFire:(i+aRect.origin.x)/10 :(j+aRect.origin.y)/10]; 
}

-(void)WaterNSRectFill:(NSRect)aRect {
    NSRectFill(aRect);
    for (int i=0; i<aRect.size.width; i += 10) for (int j=0; j<aRect.size.height; j += 10)
        [stages[stageX][stageY] setWater:(i+aRect.origin.x)/10 :(j+aRect.origin.y)/10];
}

-(void) drawFire: (NSRect) dirtyRect: (NSPoint) point {
    if ([stages[stageX][stageY] getFire:point.x/10 :point.y/10] != 2) {
        [[NSColor redColor] set];
        [self DmgNSRectFill:CGRectMake(point.x, point.y, 10, 10)];
        [[NSColor blackColor] set];
        NSRectFill(CGRectMake(point.x, point.y+3, 1, 1));
        NSRectFill(CGRectMake(point.x+3, point.y+6, 1, 1));
        NSRectFill(CGRectMake(point.x+4, point.y+5, 1, 1));
        NSRectFill(CGRectMake(point.x+7, point.y+2, 1, 1));
    }
}

-(void) drawWater:(NSRect)dirtyRect :(NSPoint)point {
    if ([stages[stageX][stageY] getWater:point.x/10 :point.y/10] != 2) {
        [[NSColor blueColor] set];
        [self WaterNSRectFill:CGRectMake(point.x, point.y, 10, 10)];
        [[NSColor blackColor] set];
        NSRectFill(CGRectMake(point.x+3, point.y+2, 1, 1));
        NSRectFill(CGRectMake(point.x+5, point.y+7, 1, 1));
        NSRectFill(CGRectMake(point.x+8, point.y+4, 1, 1));
    }
}

// 0 - down, 1 - left, 2 - right, 3 - up
-(void) drawHouse: (NSRect) dirtyRect: (NSPoint) point: (int)direction {
    [[NSColor brownColor] set];
    NSRectFill(CGRectMake(point.x, point.y, 50, 50));
    
    [self MyNSRectFill:CGRectMake(point.x, point.y, 15, 10)];
    [self MyNSRectFill:CGRectMake(point.x+35, point.y, 15, 10)];
                                  
    [self MyNSRectFill:CGRectMake(point.x, point.y, 10, 15)];
    [self MyNSRectFill:CGRectMake(point.x, point.y+35, 10, 15)];
                                  
    [self MyNSRectFill:CGRectMake(point.x+40, point.y, 10, 15)];
    [self MyNSRectFill:CGRectMake(point.x+40, point.y+35, 10, 15)];
                                  
    [self MyNSRectFill:CGRectMake(point.x, point.y+40, 15, 10)];
    [self MyNSRectFill:CGRectMake(point.x+35, point.y+40, 15, 10)];
     
    (direction==0)?[[NSColor blackColor] set]:[[NSColor brownColor] set];
    (direction==0)?NSRectFill(CGRectMake(point.x+20, point.y, 10, 5)):[self MyNSRectFill:CGRectMake(point.x+20, point.y, 10, 5)];
    
    (direction==1)?[[NSColor blackColor] set]:[[NSColor brownColor] set];
    (direction==1)?NSRectFill(CGRectMake(point.x, point.y+20, 5, 10)):[self MyNSRectFill:CGRectMake(point.x, point.y+20, 5, 10)];
    
    (direction==2)?[[NSColor blackColor] set]:[[NSColor brownColor] set];
    (direction==2)?NSRectFill(CGRectMake(point.x+45, point.y+20, 5, 10)):[self MyNSRectFill:CGRectMake(point.x+45,point.y+20,5,10)];

    (direction==3)?[[NSColor blackColor] set]:[[NSColor brownColor] set];
    (direction==3)?NSRectFill(CGRectMake(point.x+20, point.y+45, 10, 5)):[self MyNSRectFill:CGRectMake(point.x+20,point.y+45,10,5)];

    [[NSColor blackColor] set];
    NSRectFill(CGRectMake(point.x, point.y, 50, 2));
    NSRectFill(CGRectMake(point.x, point.y, 2, 50));
    NSRectFill(CGRectMake(point.x+48, point.y, 2, 50));
    NSRectFill(CGRectMake(point.x, point.y+48, 50, 2));
}

-(void)drawUI: (NSRect) dirtyRect {
    // HEALTH
    [[NSColor blackColor] set];
    (health<=100)?NSRectFill(CGRectMake(20, 360, health, 20)):NSRectFill(CGRectMake(20, 360, 100, 20));
    [[NSColor whiteColor] set];
    (health>=0)?NSRectFill(CGRectMake(20+health, 360, 100-health, 20)):(NSRectFill(CGRectMake(20, 360, 100, 20)));
    NSString *healthStr = [NSString stringWithString:@"Health"];
    [healthStr drawInRect:NSMakeRect(125, 360, 100, 20) withAttributes:nil];
    
    // MANA
    [[NSColor blueColor] set];
    (mana<=100)?NSRectFill(CGRectMake(20, 330, mana, 20)):NSRectFill(CGRectMake(20, 330, 100, 20));
    [[NSColor whiteColor] set];
    (mana>=0)?NSRectFill(CGRectMake(20+mana, 330, 100-mana, 20)):(NSRectFill(CGRectMake(20, 330, 100, 20)));
    NSString *manaStr = [NSString stringWithString:@"Mana"];
    [manaStr drawInRect:NSMakeRect(125, 330, 100, 20) withAttributes:nil];
    
    // SKILL
    (currentWeapon==0)?[[NSColor redColor] set]:[[NSColor grayColor] set];
    NSRectFill(CGRectMake(20, 300, 20, 20));
    (currentWeapon==1)?[[NSColor blueColor] set]:[[NSColor grayColor] set];
    NSRectFill(CGRectMake(45, 300, 20, 20));
    (currentWeapon==2)?[[NSColor magentaColor] set]:[[NSColor grayColor] set];
    NSRectFill(CGRectMake(70, 300, 20, 20));
    (currentWeapon==3)?[[NSColor yellowColor] set]:[[NSColor grayColor] set];
    NSRectFill(CGRectMake(95, 300, 20, 20));
    NSString *skillStr2 = [NSString stringWithString:@"Skill"];
    [skillStr2 drawInRect:NSMakeRect(125, 300, 100, 20) withAttributes:nil];
    
    // GOLD
    NSString *goldStr = [NSString stringWithFormat:@"Gold: %d",gold];
    [goldStr drawInRect:NSMakeRect(650, 360, 100, 20) withAttributes:nil];
    
    // SKILL
    NSString *skillStr = [NSString stringWithFormat:@"Skill: %d",selectedSkill];
    [skillStr drawInRect:NSMakeRect(650, 340, 100, 20) withAttributes:nil];
}

-(void)drawGold: (NSRect)dirtyRect: (NSPoint) point {
    [[NSColor yellowColor] set];
    NSRectFill(CGRectMake(point.x,point.y+4,10,2));
    NSRectFill(CGRectMake(point.x+1,point.y+2,8,6));
    NSRectFill(CGRectMake(point.x+2,point.y+1,6,8));
    NSRectFill(CGRectMake(point.x+4,point.y,2,10));
    
    [stages[stageX][stageY] setGold:point.x/10 :point.y/10];
}

-(void)drawHealthPot:(NSRect)dirtyRect :(NSPoint)point {
    [[NSColor redColor] set];
    NSRectFill(CGRectMake(point.x,point.y+4,10,2));
    NSRectFill(CGRectMake(point.x+1,point.y+2,8,6));
    NSRectFill(CGRectMake(point.x+2,point.y+1,6,8));
    NSRectFill(CGRectMake(point.x+4,point.y,2,10));

    [[NSColor orangeColor] set];
    NSRectFill(CGRectMake(point.x+1, point.y+4, 8, 2));
    NSRectFill(CGRectMake(point.x+4, point.y+1, 2, 8));
    NSRectFill(CGRectMake(point.x+2, point.y+2, 6, 6));
    
    [stages[stageX][stageY] setHealthPot:point.x/10 :point.y/10];  
}

-(void) drawSkillShot {
    for (int i=0; i<[stages[stageX][stageY] getSkillCount]; i++)
    {
        switch ([stages[stageX][stageY] getSkillshotZ:i]) {
            case 0: [[NSColor redColor] set]; break;
            case 1: [[NSColor blueColor] set]; break;
            case 2: [[NSColor magentaColor] set]; break;
            case 3: [[NSColor yellowColor] set]; break;
            default: [[NSColor blackColor] set]; break;
        }
        NSRectFill(CGRectMake([stages[stageX][stageY] getSkillshotX:i],[stages[stageX][stageY] getSkillshotY:i],10,10));
    }
}

-(void)drawSelf:(NSRect)dirtyRect {
    [[NSColor purpleColor] set];
    NSRectFill(CGRectMake(xPos+4,yPos+4,2,2));
    NSRectFill(CGRectMake(xPos+2,yPos+2,6,2));
    NSRectFill(CGRectMake(xPos,yPos,4,2));
    NSRectFill(CGRectMake(xPos+6,yPos,4,2));
    [[NSColor blackColor] set];
    NSRectFill(CGRectMake(xPos+3,yPos+6,4,4));
}

-(void)drawMenu:(NSRect)dirtyRect {
    [[NSColor grayColor] set];
    NSRectFill(CGRectMake(175,75,dirtyRect.size.width-350,dirtyRect.size.height-150));
    [[NSColor lightGrayColor] set];
    NSRectFill(CGRectMake(200,100,dirtyRect.size.width-400,dirtyRect.size.height-200));
    NSString *menuTitle = [NSString stringWithString:@"GAME MENU"];
    [menuTitle drawInRect:NSMakeRect(347,250,40,30) withAttributes:nil];
    NSString *instructions = [NSString stringWithString:@"esc - Game menu\nr - Restart"];
    [instructions drawInRect:NSMakeRect(300,200,100,40) withAttributes:nil];
}

-(void)drawDialog:(NSRect)dirtyRect {
    [[NSColor blueColor] set];
    NSRectFill(CGRectMake(175,75,dirtyRect.size.width-350,dirtyRect.size.height-150));
    [[NSColor cyanColor] set];
    NSRectFill(CGRectMake(200,100,dirtyRect.size.width-400,dirtyRect.size.height-200));
    NSString *menuTitle = [NSString stringWithString:@"NPC"];
    [menuTitle drawInRect:NSMakeRect(347,250,40,30) withAttributes:nil];
    NSString *instructions = [NSString stringWithString:[stages[stageX][stageY] getNPCdialog:dialog]];
    [instructions drawInRect:NSMakeRect(250,180,200,60) withAttributes:nil];
}

-(BOOL) acceptsFirstResponder{ return YES; }
-(BOOL) becomeFirstResponder { return YES; }
-(BOOL) resignFirstResponder { return YES; }

-(BOOL) canMove: (int) direction {
    switch (direction) {
        case 0: //up
            if ([stages[stageX][stageY] getImmov:xPos/10: yPos/10+1] == 1 || yPos >= 390 || [stages[stageX][stageY] getNPC:xPos/10: yPos/10+1] == 1 || [stages[stageX][stageY] getWater:xPos/10: yPos/10+1] == 1 || [stages[stageX][stageY] getEnemyStatus:xPos/10 :yPos/10+1] == 1)
                return false;
            break;
        case 1: //down
            if ([stages[stageX][stageY] getImmov:xPos/10: yPos/10-1] == 1 || yPos <= 0 || [stages[stageX][stageY] getNPC:xPos/10: yPos/10-1] == 1 || [stages[stageX][stageY] getWater:xPos/10: yPos/10-1] == 1 || [stages[stageX][stageY] getEnemyStatus:xPos/10 :yPos/10-1] == 1)
                return false;
            break;
        case 2: //right
            if ([stages[stageX][stageY] getImmov:xPos/10+1: yPos/10] == 1 || xPos >= 720 || [stages[stageX][stageY] getNPC:xPos/10+1: yPos/10] == 1 || [stages[stageX][stageY] getWater:xPos/10+1: yPos/10] == 1 || [stages[stageX][stageY] getEnemyStatus:xPos/10+1 :yPos/10] == 1)
                return false;
            break;
        case 3: //left
            if ([stages[stageX][stageY] getImmov:xPos/10-1: yPos/10] == 1 || xPos <= 0 || [stages[stageX][stageY] getNPC:xPos/10-1: yPos/10] == 1 || [stages[stageX][stageY] getWater:xPos/10-1: yPos/10] == 1 || [stages[stageX][stageY] getEnemyStatus:xPos/10-1 :yPos/10] == 1)
                return false;
            break;
        default:
            break;
    }
    return true;
}

-(void) checkDmg {
    if ([stages[stageX][stageY] getFire:xPos/10 :yPos/10] == 1) health -= 5;
    if (health <= 0) { dead = true; health = 0;}
}

-(void) checkGold {
    if ([stages[stageX][stageY] getGold:xPos/10 :yPos/10] == 1) {
        [stages[stageX][stageY] takeGold:xPos/10 :yPos/10];
        gold += 10;
    }
}

-(void) checkGold: (int)x: (int)y {
    if ([stages[stageX][stageY] getGold:x :y] == 1) {
        [stages[stageX][stageY] takeGold:x :y];
        gold += 10;
    }    
}

-(void) checkHealthPot {
    if ([stages[stageX][stageY] getHealthPot:xPos/10: yPos/10] == 1) {
        [stages[stageX][stageY] takeHealthPot:xPos/10 :yPos/10];
        if (health<90) health += 10;
        else health = 100;
        if (mana<90) mana += 10;
        else mana = 100;
    }
}

-(void) checkHealthPot:(int)x :(int)y {
    if ([stages[stageX][stageY] getHealthPot:x :y] == 1) {
        [stages[stageX][stageY] takeHealthPot:x :y];
        if (health<90) health += 10;
        else health = 100;
        if (mana<90) mana += 10;
        else mana = 100;
    }
}

-(void) checkNpc {
    if ([stages[stageX][stageY] getNPC:xPos/10+1 :yPos/10] == 1)
        dialog = [stages[stageX][stageY] getNPCpos:xPos/10+1 :yPos/10];
    else if ([stages[stageX][stageY] getNPC:xPos/10-1 :yPos/10] == 1)
        dialog = [stages[stageX][stageY] getNPCpos:xPos/10-1 :yPos/10];
    else if ([stages[stageX][stageY] getNPC:xPos/10 :yPos/10+1] == 1)
        dialog = [stages[stageX][stageY] getNPCpos:xPos/10 :yPos/10+1];
    else if ([stages[stageX][stageY] getNPC:xPos/10 :yPos/10-1] == 1)
        dialog = [stages[stageX][stageY] getNPCpos:xPos/10 :yPos/10-1];
    else
        dialog = -1;
}

-(void) checkEnemy {
    if ([stages[stageX][stageY] checkEnemy:xPos/10:yPos/10] == 1) if (health<5) health=0; else health -= 5;
}

-(void) checkTelep {
    if ([stages[stageX][stageY] getTelep:xPos/10 :yPos/10] == 1) {
        stageX += 1;
        xPos -= 720;
    }
    else if ([stages[stageX][stageY] getTelep:xPos/10 :yPos/10] == -1 && stageX > 0) {
        stageX -= 1;
        xPos += 720;
    }
    else if ([stages[stageX][stageY] getTelep:xPos/10 :yPos/10] == 2) {
        stageY += 1;
        yPos -= 390;
    }
    else if ([stages[stageX][stageY] getTelep:xPos/10 :yPos/10] == 3 && stageY >0) {
        stageY -= 1;
        yPos += 390;
    }
}

-(void) checkWin { if (gold >= 1000) win = true; }

-(void)shootSkillshot:(int)dir {
    mana -= fireBallCost;
    int tempColor = currentWeapon;
    for (int i=0; i<fireBallLength; i++) {
        switch (dir) {
            case 0:
                [NSTimer scheduledTimerWithTimeInterval:0.1+0.5*i target:self selector:@selector(shootFireball:) userInfo:[[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:xPos+10*(i+1)], [NSNumber numberWithDouble:yPos], [NSNumber numberWithInt:stageX], [NSNumber numberWithInt:stageY], [NSNumber numberWithInt:tempColor], nil] repeats:NO];      
                break;
            case 1:
                [NSTimer scheduledTimerWithTimeInterval:0.1+0.5*i target:self selector:@selector(shootFireball:) userInfo:[[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:xPos-10*(i+1)], [NSNumber numberWithDouble:yPos], [NSNumber numberWithInt:stageX], [NSNumber numberWithInt:stageY], [NSNumber numberWithInt:tempColor], nil] repeats:NO];  
                break;
            case 2:
                [NSTimer scheduledTimerWithTimeInterval:0.1+0.5*i target:self selector:@selector(shootFireball:) userInfo:[[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:xPos], [NSNumber numberWithDouble:yPos-10*(i+1)], [NSNumber numberWithInt:stageX], [NSNumber numberWithInt:stageY], [NSNumber numberWithInt:tempColor], nil] repeats:NO];     
                break;
            case 3:
                [NSTimer scheduledTimerWithTimeInterval:0.1+0.5*i target:self selector:@selector(shootFireball:) userInfo:[[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:xPos], [NSNumber numberWithDouble:yPos+10*(i+1)], [NSNumber numberWithInt:stageX], [NSNumber numberWithInt:stageY], [NSNumber numberWithInt:tempColor], nil] repeats:NO];  
                break;
            default:
                break;
        }  
        [NSTimer scheduledTimerWithTimeInterval:2.1+0.5*i target:self selector:@selector(removeFireBall:) userInfo:self repeats:NO];
    }
}

-(void)shootFireball:(NSTimer*)timer {
    if ([stages[[[[timer userInfo] objectAtIndex:2] intValue]][[[[timer userInfo] objectAtIndex:3] intValue]] getImmov:[[[timer userInfo] objectAtIndex:0] intValue]/10: [[[timer userInfo] objectAtIndex:1] intValue]/10] == 0 && [stages[[[[timer userInfo] objectAtIndex:2] intValue]][[[[timer userInfo] objectAtIndex:3] intValue]] getNPC:[[[timer userInfo] objectAtIndex:0] intValue]/10: [[[timer userInfo] objectAtIndex:1] intValue]/10] == 0) {
        [stages[[[[timer userInfo] objectAtIndex:2] intValue]][[[[timer userInfo] objectAtIndex:3] intValue]] setSkillshot:[[[timer userInfo] objectAtIndex:0] intValue]:[[[timer userInfo] objectAtIndex:1] intValue]:[[[timer userInfo] objectAtIndex:4] intValue]];
        if ([[[timer userInfo] objectAtIndex:4] intValue] == 3)
            [self checkGold: [[[timer userInfo] objectAtIndex:0] intValue]/10: [[[timer userInfo] objectAtIndex:1] intValue]/10];
        else if ([[[timer userInfo] objectAtIndex:4] intValue] == 0)
            [stages[stageX][stageY] killFire:[[[timer userInfo] objectAtIndex:0] intValue]/10 :[[[timer userInfo] objectAtIndex:1] intValue]/10];
        else if ([[[timer userInfo] objectAtIndex:4] intValue] == 1)
            [stages[stageX][stageY] killWater:[[[timer userInfo] objectAtIndex:0] intValue]/10 :[[[timer userInfo] objectAtIndex:1] intValue]/10];
        else if ([[[timer userInfo] objectAtIndex:4] intValue] == 2)
            [stages[stageX][stageY] killEnemy:[[[timer userInfo] objectAtIndex:0] intValue]/10 :[[[timer userInfo] objectAtIndex:1] intValue]/10];
    }
    else
        [stages[[[[timer userInfo] objectAtIndex:2] intValue]][[[[timer userInfo] objectAtIndex:3] intValue]] setSkillshot:0:0:-1];
    [self setNeedsDisplay:YES];
}

-(void)removeFireBall:(NSTimer*)timer { [stages[stageX][stageY] takeSkillshot]; [self setNeedsDisplay:YES]; }

-(void)restart {
    if (dead == true || menu==true || win==true) {
        health = 100;
        mana = 100;
        dead = false;
        win = false;
        gold = 0;
        xPos = 300;
        yPos = 200;
        stageX = 0; 
        stageY = 0;
        for (int k=0;k<10;k++) for (int l=0;l<10;l++) {
            for (int i=0;i<73;i++) for (int j=0;j<42;j++) {
                if ([stages[k][l] getFire:i:j]==2) [stages[k][l] setFire:i :j];
                if([stages[k][l] getGold:i :j]==2) [stages[k][l] setGold:i :j];
                if ([stages[k][l] getHealthPot:i :j]==2) [stages[k][l] setHealthPot:i :j];
            }
            [stages[k][l] firstTrue];
        }
        if (menu==true) menu ^= 1;
    }
}

- (void)keyDown:(NSEvent*)event {
    //NSLog(@"%d %d",xPos,yPos);
    switch( [event keyCode] ) {
        case 126:       // up arrow
            yPos += ([self canMove: 0]&&!menu&&!dead&&!win)?moveInt:0;
            [self checkDmg];
            [self checkGold];
            [self checkHealthPot];
            [self checkTelep];
            [self checkNpc];
            [self checkWin];
            [self checkEnemy];
            break;
        case 125:       // down arrow
            yPos -= ([self canMove: 1]&&!menu&&!dead&&!win)?moveInt:0;
            [self checkDmg];
            [self checkGold];
            [self checkHealthPot];
            [self checkTelep];
            [self checkNpc];
            [self checkEnemy];
            break;
        case 124:       // right arrow
            xPos += ([self canMove: 2]&&!menu&&!dead&&!win)?moveInt:0;
            [self checkDmg];
            [self checkGold];
            [self checkHealthPot];
            [self checkTelep];
            [self checkNpc];
            [self checkEnemy];
            break;
        case 123:       // left arrow
            xPos -= ([self canMove: 3]&&!menu&&!dead&&!win)?moveInt:0;
            [self checkDmg];
            [self checkGold];
            [self checkHealthPot];
            [self checkTelep];
            [self checkNpc];
            [self checkEnemy];
            break;
        case 0x22: //i
            if (mana <= 5)  mana = 0;
            else            mana -= 5;
            break;
        case 0x1F: //o
            if (mana >= 95) mana = 100;
            else            mana += 5;
            break;
        case 0x0F: //r
            [self restart];
            break;
        case 0x35: //esc
            menu ^= 1;
            break;
        case 0x02: //d
            if (mana >= fireBallCost&&!menu&&!dead&&selectedSkill==1) {
                [self shootSkillshot: 0];
            }
            else if (selectedSkill==2)
            {
                stageX += 1;
                for (int i=0; i<[stages[stageX][stageY] getSkillCount]; i++) [stages[stageX][stageY] takeSkillshot];
                [self changeStage];
            }
            else if (selectedSkill==3)
            {
                moveInt += 10;
            }
            break;
        case 0x00: //a
            if (mana >= fireBallCost&&!menu&&!dead&&selectedSkill==1) {
                [self shootSkillshot: 1];
            }
            else if (selectedSkill==2)
            {
                if (stageX != 0)
                    stageX -= 1;
                for (int i=0; i<[stages[stageX][stageY] getSkillCount]; i++) [stages[stageX][stageY] takeSkillshot];
                [self changeStage];
            }
            else if (selectedSkill==3)
            {
                moveInt -= 10;
            }
            break;
        case 0x01: //s
            if (mana >= fireBallCost&&!menu&&!dead&&selectedSkill==1) {
                [self shootSkillshot: 2];
            }
            else if (selectedSkill==2)
            {
                if (stageY != 0)
                    stageY -= 1;
                for (int i=0; i<[stages[stageX][stageY] getSkillCount]; i++) [stages[stageX][stageY] takeSkillshot];
                [self changeStage];
            }
            break;
        case 0x0D: //w
            if (mana >= fireBallCost&&!menu&&!dead&&selectedSkill==1) {
                [self shootSkillshot: 3];
            }
            else if (selectedSkill==2)
            {
                stageY += 1;
                for (int i=0; i<[stages[stageX][stageY] getSkillCount]; i++) [stages[stageX][stageY] takeSkillshot];
                [self changeStage];
            }
            break;
        case 0x0C: // q
            if (selectedSkill == 1)
                currentWeapon = (currentWeapon+3)%4;
            break;
        case 0x0E: // e
            if (selectedSkill == 1)
                currentWeapon = (currentWeapon+1)%4;
            break;
        case 0x12: // 1
            if (!menu&&!dead)
                selectedSkill = 1;
            break;
        case 0x13: // 2
            if (!menu&&!dead)
                selectedSkill = 2;
            break;
        case 0x14: // 3
            if (!menu&&!dead)
                selectedSkill = 3;
            break;
        case 0x10: // Y
            [stages[stageX][stageY] setState:1 :dialog];
            break;
        case 0x2D: // N
            [stages[stageX][stageY] setState:2 :dialog];
            break;
        case 0x04: // H
            [stages[stageX][stageY] setState:0: dialog];
            break;
        default:
            break;
    }
    [self display];
}

@end
