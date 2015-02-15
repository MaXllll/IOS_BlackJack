//
//  ViewController.h
//  TPBlackJack
//
//  Created by etudiant on 18/12/2014.
//  Copyright (c) 2014 etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *HitButton;
@property (weak, nonatomic) IBOutlet UILabel *DealerLabel;
@property (weak, nonatomic) IBOutlet UILabel *PlayerLabel;

- (IBAction)HitCard:(id)sender;

@end

