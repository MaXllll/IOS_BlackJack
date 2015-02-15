//
//  Deck.h
//  TPBlackJack
//
//  Created by etudiant on 18/12/2014.
//  Copyright (c) 2014 etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Deck : NSObject {
    
    NSMutableArray *cards;
    
}

-(Card *) drawCard;

-(void) shuffle;

@end
