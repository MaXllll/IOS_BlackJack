//
//  Hand.m
//  TPBlackJack
//
//  Created by etudiant on 18/12/2014.
//  Copyright (c) 2014 etudiant. All rights reserved.
//

#import "Hand.h"
#import "Card.h"

@implementation Hand

@synthesize handClosed=_handClosed;

-(id) init {
    if ((self = [super init])){
        self.cardsInHand = [[NSMutableArray alloc] initWithCapacity:2];
        _handClosed = NO;
    }
    return (self);
    
}

-(void) addCard:(Card *)card
{
    if ((_handClosed==NO) | ( [self countCards]==0))
    {
        [self.cardsInHand addObject:card];
    }
    else
    {
        card.cardClosed=YES;
        [self.cardsInHand addObject:card];
    }
}


-(NSInteger) getPipValue
{
    NSInteger aValue = 0;
    for (Card *tCard in self.cardsInHand) {
        aValue = aValue + [tCard pipValue];
    }
    return aValue;
}

-(NSInteger) countCards
{
    return ([self.cardsInHand count]);
}

-(Card *) getCardAtIndex:(NSInteger) index
{
    return ([self.cardsInHand objectAtIndex:index]);
}

-(NSString *)description{
    return [NSString stringWithFormat:@"cards in hand : %@", self.cardsInHand];
}



@end
