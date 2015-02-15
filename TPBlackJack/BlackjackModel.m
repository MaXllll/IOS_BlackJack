//
//  BlackjackModel.m
//  TPBlackJack
//
//  Created by Maxime Lahaye on 04/01/15.
//  Copyright (c) 2015 etudiant. All rights reserved.
//

#import "BlackjackModel.h"

@implementation BlackjackModel

@synthesize playerHand = _playerHand;
@synthesize dealerHand = _dealerHand;
@synthesize deck = _deck;

static BlackjackModel* blackjackModel = nil;

-(id) init {
    if ((self = [super init])){
        _deck = [[Deck alloc] init];
        _playerHand = [[Hand alloc] init];
        _dealerHand = [[Hand alloc] init];
        _dealerHand.handClosed = YES;
    }
    return (self);
}

-(void)setup
{
    //deal cards
    [self playerHandDraws];
    [self dealerHandDraws];
}

+(BlackjackModel *) getBlackjackModel{
    if (blackjackModel == nil){
        blackjackModel = [[BlackjackModel alloc] init];
    }
    return blackjackModel;
}

-(void)dealerHandDraws
{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"dealerHand"];
}

-(void)playerHandDraws
{
    [self willChangeValueForKey:@"playerHand"];
    [_playerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"playerHand"];
}

@end
