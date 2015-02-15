//
//  Card.h
//  TPBlackJack
//
//  Created by etudiant on 18/12/2014.
//  Copyright (c) 2014 etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Hearts,
    Spades,
    Diamonds,
    Clubs
} Suit;

@interface Card : NSObject {
    
}

@property NSInteger cardNumber;

@property Suit suit;

@property BOOL cardClosed;

-(id) initWithCardNumber:(NSInteger) aCardNumber suit:(Suit) aSuit;

-(NSInteger) pipValue;

-(NSString *) filename;

@end
