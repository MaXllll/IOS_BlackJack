//
//  BlackjackModel.h
//  TPBlackJack
//
//  Created by Maxime Lahaye on 04/01/15.
//  Copyright (c) 2015 etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Deck.h"
#import "Hand.h"

typedef enum {
    Player,
    Dealer,
    Draw
} Winner;

@interface BlackjackModel : NSObject
{
    Hand *dealerHand;
    Hand *playerHand;
    Deck *deck;
}

@property Hand *dealerHand;
@property Hand *playerHand;
@property Deck *deck;
@property int totalPlays;
@property int totalTurn;
@property float money;
@property float moneyBet;

-(void) setup;
+(BlackjackModel *)getBlackjackModel;
-(void)dealerHandDraws;
-(void)playerHandDraws;
-(void) playerStands;
-(void) resetGame;
-(void) newTurn;
-(void) betMoney:(float) withAmount;
-(float) getAmountOfMoney;

@end
