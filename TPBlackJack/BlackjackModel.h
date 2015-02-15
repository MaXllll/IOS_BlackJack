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

@interface BlackjackModel : NSObject
{
    Hand *dealerHand;
    Hand *playerHand;
    Deck *deck;
}

@property Hand *dealerHand;
@property Hand *playerHand;
@property Deck *deck;

-(void) setup;
+(BlackjackModel *)getBlackjackModel;
-(void)dealerHandDraws;
-(void)playerHandDraws;

@end
