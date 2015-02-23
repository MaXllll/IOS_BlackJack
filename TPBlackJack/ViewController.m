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

@synthesize dealerLabel=_dealerLabel, playerLabel=_playerLabel, HitButton=_HitButton, standButton=_standButton, resetButton = _resetButton, allImageViews =_allImageViews;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"BlackJack_Table.png"];
    backgroundImage = [self imageWithImage:backgroundImage scaledToSize:CGSizeMake([self.view bounds].size.width, [self.view bounds].size.height)];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    CGRect theFrame = [backgroundImageView frame];
    theFrame.origin.y = 40;
    theFrame.origin.x = 40;
    [self.view addSubview:backgroundImageView];
    
    [self betMode];
    
    
    _allImageViews = [[NSMutableArray alloc] initWithCapacity:5];
    
    self.coinBet.hidden = true;
    
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"dealerHand"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"playerHand"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"totalTurn"
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
        CGRect arect = CGRectMake( (i*40)+50, yPos, 60, 85);
        imageView.frame = arect;
        
        [self.view addSubview:imageView];
        [self.view bringSubviewToFront:imageView];
        [_allImageViews addObject:imageView];
    }
    
}

-(void) showDealerHand:(Hand *)hand;
{
    [self showHand:hand atYPos:125];
    
    _dealerLabel.text = [NSString stringWithFormat:@"Dealer (%ld)",(long)[hand getPipValue]];
}

-(void) showPlayerHand:(Hand *)hand;
{
    [self showHand:hand atYPos:320];
    
    _playerLabel.text = [NSString stringWithFormat:@"Player (%ld)",(long)[hand getPipValue]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"dealerHand"])
    {
        if(_betModeBool == false)
            [self showDealerHand: (Hand *)[object dealerHand]];
    } else
        if ([keyPath isEqualToString:@"playerHand"])
        {
            if(_betModeBool == false)
                [self showPlayerHand: (Hand *)[object playerHand]];
        }
        else if([keyPath isEqualToString:@"totalTurn"])
        {
            if([[BlackjackModel getBlackjackModel] getAmountOfMoney] <= 5)
            {
                [self endGame];
            }
            else
            {
                [NSTimer scheduledTimerWithTimeInterval:3.0
                                                 target:self
                                               selector:@selector(resetTurn)
                                               userInfo:nil
                                                repeats:NO];
                
            }
        }
}

- (IBAction)HitCard:(id)sender
{
    [[BlackjackModel getBlackjackModel] playerHandDraws];

}


- (IBAction)Stand:(id)sender {
    [[BlackjackModel getBlackjackModel] playerStands];
}

- (IBAction)ResetGame:(id)sender {
    [_HitButton setEnabled:YES];
    [_standButton setEnabled:YES];
    
    for (UIView *view in _allImageViews)
    {
        [view removeFromSuperview];
    }
    [_allImageViews removeAllObjects];
    
    [_dealerLabel setText:@"Dealer"];
    [_playerLabel setText:@"Player"];
    [_resetButton setEnabled:NO];
    
    [[BlackjackModel getBlackjackModel] resetGame];
}

- (void) resetTurn;
{
    for (UIView *view in _allImageViews)
    {
        [view removeFromSuperview];
    }
    [_allImageViews removeAllObjects];
    [[BlackjackModel getBlackjackModel] newTurn];
    [self betMode];
    _moneyLabel.text = [[NSNumber numberWithFloat:[[BlackjackModel getBlackjackModel] getAmountOfMoney]] stringValue];

}

- (IBAction)bet:(id)sender {
    
    NSString* title = @"";
    
    if(sender == _coin5)
    {
        [[BlackjackModel getBlackjackModel] betMoney:5.0f];
        title = @"5";

    }
    else if(sender == _coin10)
    {
        [[BlackjackModel getBlackjackModel] betMoney:10.0f];
        title = @"10";

    }
    else if(sender == _coin15)
    {
        [[BlackjackModel getBlackjackModel] betMoney:15.0f];
        title = @"15";


    }
    _moneyLabel.text = [[NSNumber numberWithFloat:[[BlackjackModel getBlackjackModel] getAmountOfMoney]] stringValue];
    
    [self.coinBet setTitle:title forState:UIControlStateNormal];
    
    Hand * dealerHand = [[BlackjackModel getBlackjackModel] getDealerHand];
    Hand * playerHand = [[BlackjackModel getBlackjackModel] getPlayerHand];
    
    [self showDealerHand:dealerHand];
    [self showPlayerHand:playerHand];

    [self playMode];

}

-(void) endGame{
    [_HitButton setEnabled:NO];
    [_standButton setEnabled:NO];
    [_resetButton setEnabled:YES];
}

//Scaling image keeping aspect ratio
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    float oldWidth = image.size.width;
    float scaleFactor = newSize.width / oldWidth;
    
    float newHeight = image.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) playMode
{
    _betModeBool = false;
    
    self.HitButton.hidden = false;
    self.standButton.hidden = false;
    self.doubleButton.hidden = false;
    
    self.coin5.hidden = true;
    self.coin10.hidden = true;
    self.coin15.hidden = true;
    
    self.coinBet.hidden = false;
}

-(void) betMode
{
    _betModeBool = true;
    
    self.HitButton.hidden = true;
    self.standButton.hidden = true;
    self.doubleButton.hidden = true;
    
    self.coin5.hidden = false;
    self.coin10.hidden = false;
    self.coin15.hidden = false;
    
    self.coinBet.hidden = true;
    
    float money = [[BlackjackModel getBlackjackModel] getAmountOfMoney];
    
    if(money < 15 & money >= 10)
    {
        self.coin15.enabled = false;
    }
    else if(money < 15 & money >= 5)
    {
        self.coin15.enabled = false;
        self.coin10.enabled = false;

    }
    
}

@end
