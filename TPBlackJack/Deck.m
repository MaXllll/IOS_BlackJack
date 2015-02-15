//
//  Deck.m
//  TPBlackJack
//
//  Created by etudiant on 18/12/2014.
//  Copyright (c) 2014 etudiant. All rights reserved.
//

#import "Deck.h"

#import "Card.h"

@implementation Deck

-(id) init {
    if (self = [super init])
    {
        cards = [[NSMutableArray alloc] init];
        
        for(int i = 0; i <= 3; i++) {
            for (int cardNumber = 1; cardNumber<= 13;cardNumber++) {
                [cards addObject:[[Card alloc] initWithCardNumber:cardNumber suit:i]];
            }
        }
        
        [self shuffle];
    }
    
    return self;
}


-(Card *) drawCard {
    if ([cards count]>0)
    {
        Card* tCard = [cards lastObject];
        
        [cards removeLastObject];
        
        return tCard;
    }
    
    return nil;
}

-(void) shuffle {
    
    NSUInteger count = [cards count];
    
    for (NSUInteger i=0; i< count; i++) {
        
        int nElements = count - i;
        
        int n = (arc4random() % nElements) + i;
        
        [cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

-(NSString *) description {
    
    return [NSString stringWithFormat:@"Deck : %@", cards];
    
}

@end
