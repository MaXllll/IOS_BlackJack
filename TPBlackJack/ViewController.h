//
//  ViewController.h
//  TPBlackJack
//
//  Created by etudiant on 18/12/2014.
//  Copyright (c) 2014 etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSMutableArray *allImageViews;
    
}

@property (weak, nonatomic) IBOutlet UIButton *HitButton;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UIButton *standButton;
@property (weak, nonatomic) IBOutlet UIButton *doubleButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *dealerLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *coin5;
@property (weak, nonatomic) IBOutlet UIButton *coin10;
@property (weak, nonatomic) IBOutlet UIButton *coin15;
@property (weak, nonatomic) IBOutlet UIButton *coinBet;


@property bool betModeBool;

@property NSMutableArray *allImageViews;

- (IBAction)HitCard:(id)sender;
- (IBAction)Stand:(id)sender;
- (IBAction)ResetGame:(id)sender;
- (IBAction)bet:(id)sender;

@end

