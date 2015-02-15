//
//  ViewController.m
//  TPBlackJack
//
//  Created by etudiant on 18/12/2014.
//  Copyright (c) 2014 etudiant. All rights reserved.
//

#import "ViewController.h"
#import "BlackjackModel.h"

#import "Deck.h"
#import "Card.h"

@interface ViewController ()

@end


@implementation ViewController

@synthesize DealerLabel=_dealerLabel, PlayerLabel=_playerLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"dealerHand"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"playerHand"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[BlackjackModel getBlackjackModel] setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) showHand:(Hand *)hand atYPos:(NSInteger) yPos;
{
    
    for (int i=0; i< [hand countCards] ; i++) {
        Card *card = [hand getCardAtIndex:i];
        
        //UIImage  *cardImage = [ UIImage imageNamed:@"heart08.jpg"];
        UIImage  *cardImage = [ UIImage imageNamed:[card filename]];
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:cardImage];
        CGRect arect = CGRectMake( (i*40)+20, yPos, 71, 96);
        imageView.frame = arect;
        
        [self.view addSubview:imageView];
    }
    
}

-(void) showDealerHand:(Hand *)hand;
{
    [self showHand:hand atYPos:110];
    
    _dealerLabel.text = [NSString stringWithFormat:@"Dealer (%d)",[hand getPipValue]];
}

-(void) showPlayerHand:(Hand *)hand;
{
    [self showHand:hand atYPos:320];
    
    _playerLabel.text = [NSString stringWithFormat:@"Player (%d)",[hand getPipValue]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"dealerHand"])
    {
        [self showDealerHand: (Hand *)[object dealerHand]];
    } else
        if ([keyPath isEqualToString:@"playerHand"])
        {
            [self showPlayerHand: (Hand *)[object playerHand]];
        }
}

- (IBAction)HitCard:(id)sender {
    [[BlackjackModel getBlackjackModel] playerHandDraws];

}


@end
