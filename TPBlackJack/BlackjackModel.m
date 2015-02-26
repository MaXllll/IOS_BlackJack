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
@synthesize totalPlays = _totalPlays;
@synthesize totalTurn = _totalTurn;
@synthesize money = _money;
@synthesize moneyBet = _moneyBet;

static BlackjackModel* blackjackModel = nil;

-(id) init {
    if ((self = [super init])){
        _deck = [[Deck alloc] init];
        _playerHand = [[Hand alloc] init];
        _dealerHand = [[Hand alloc] init];
        _dealerHand.handClosed = YES;
        _totalPlays = 0;
        _totalTurn = 0;
        _moneyBet = 0.0f;
        _money = 100.0f;
    }
    return (self);
}

-(void)setup
{
    //deal cards
    [self playerHandDraws];
    [self playerHandDraws];
    
    if([playerHand getPipValue] == 21){
        [self turnEnds:Player];
    }
    
    [self dealerHandDraws];
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
    [self EndGameIfPlayerIsBust];
    if(playerHand.getPipValue == 21){
        [self dealerStartsTurn];
        
        [self dealerPlays];
    }
}

-(void)dealerStartsTurn{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand setHandClosed:NO];
    [self didChangeValueForKey:@"dealerHand"];
}

-(void)playerStands
{
    [self dealerStartsTurn];
    
    [self dealerPlays];
}

-(void) playerDouble
{
    [self willChangeValueForKey:@"money"];
    _money -= _moneyBet;
    _moneyBet += _moneyBet;
    [self didChangeValueForKey:@"money"];

    [self playerHandDraws];
    
    [self dealerStartsTurn];
    
    [self dealerPlays];
}

-(void) turnEnds:(Winner) winner;
{
    if(winner == Player)
    {
        _money += _moneyBet + (_moneyBet * 1.5f);
    }
    else if(winner == Draw)
    {
        _money += _moneyBet;

    }
    _moneyBet = 0;
    self.totalTurn = self.totalTurn+1;
}

-(void)dealerPlays
{
    while (_dealerHand.getPipValue < 17)
    {
        [self dealerHandDraws];
        
    }
    
    if (_dealerHand.getPipValue > 21)
        [self turnEnds:Player ];
    else if (_dealerHand.getPipValue > _playerHand.getPipValue)
        [self turnEnds:Dealer];
    else
        [self turnEnds:Draw ];
}

-(void) resetGame;
{
    self.totalPlays += 1;
    _moneyBet = 0.0f;
    _money = 100.0f;
    [self newTurn];
}

-(void) newTurn;
{
    _deck = nil;
    _playerHand = nil;
    _dealerHand = nil;
    _deck = [[Deck alloc] init];
    _playerHand = [[Hand alloc] init];
    _dealerHand = [[Hand alloc] init];
    _dealerHand.handClosed = YES;
    [self setup];

}

-(void) EndGameIfPlayerIsBust
{
    if (_playerHand.getPipValue > 21)
        [self turnEnds:Dealer];
}

-(void) betMoney: (float) withAmount
{
    _moneyBet += withAmount;
    _money -= withAmount;
}

-(float) getAmountOfMoney
{
    return _money;
}

-(float) getAmountOfMoneyBet
{
    return _moneyBet;
}


-(Hand*) getPlayerHand;
{
    return _playerHand;
}

-(Hand*) getDealerHand;
{
    return _dealerHand;
}

@end
