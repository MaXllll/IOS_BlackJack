//
//  Hand.h
//  TPBlackJack
//
//  Created by etudiant on 18/12/2014.
//  Copyright (c) 2014 etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Hand : NSObject {
    
}

@property NSMutableArray *cardsInHand;
@property BOOL handClosed;

-(void) addCard:(Card *)card;
-(NSInteger) getPipValue;
-(NSInteger) countCards;
-(Card *) getCardAtIndex:(NSInteger) index;

@end
