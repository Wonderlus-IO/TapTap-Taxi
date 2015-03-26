//
//  GameScene.m
//  TapTapTaxi
//
//  Created by Sabatino Masala on 10/03/15.
//  Copyright (c) 2015 Wonderlus. All rights reserved.
//

#import "GameScene.h"

static float SPEED = 7;
static float ROAD_START_Y = 0;
static float ROAD_START_X = 0;
static float TILE_WIDTH = 68;
static float ANGLE = 26.55;

@interface GameScene()

@property (nonatomic, assign) NSInteger timer;
@property (nonatomic, assign) NSInteger generatorNumber;
@property (strong, nonatomic) NSMutableArray *arrTiles;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
  
  ROAD_START_Y = [[UIScreen mainScreen] bounds].size.height / 2 + 100;
  ROAD_START_X = [[UIScreen mainScreen] bounds].size.width + 100;
  
  _timer = 0;
  _generatorNumber = 0;
  _arrTiles = [NSMutableArray new];
  
}

-(void)generateRoad{
  
  NSString *tile = @"tile_road_1";
  
  SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:tile];
  sprite.position = CGPointMake(ROAD_START_X, ROAD_START_Y);
  sprite.anchorPoint = CGPointMake(.5, 0);
  
  [self addChild:sprite];
  [self.arrTiles addObject:sprite];
  
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)moveTilesWithSpeed:(int)speed{
  
  int i = 0;
  while(i < [self.arrTiles count]){
    
    SKSpriteNode *sprite = [self.arrTiles objectAtIndex:i];
    if(sprite.position.x < -100){
      [self.arrTiles removeObjectAtIndex:i];
      [sprite removeFromParent];
    }
    
    sprite.zPosition = [self.arrTiles count] - i;
    
    CGFloat x = sprite.position.x - speed * cos( ANGLE * M_PI / 180 );
    CGFloat y = sprite.position.y - speed * sin( ANGLE * M_PI / 180 );
    sprite.position = CGPointMake(x, y);
    
    i++;
  }
  
}

-(void)update:(CFTimeInterval)currentTime {
  
  self.timer++;
  self.generatorNumber++;
  
  if(self.generatorNumber > TILE_WIDTH / SPEED){
    self.generatorNumber = 0;
    [self generateRoad];
  }
  
  [self moveTilesWithSpeed:SPEED];
  
}

@end
