//
//  ViewController.h
//  RestfulMetricsExample
//
//  Created by Alex McHale on 2/24/12.
//  Copyright (c) 2012 RESTful Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *appNameField;
@property (strong, nonatomic) IBOutlet UITextField *apiKeyField;
@property (strong, nonatomic) IBOutlet UITextField *metricField;
@property (strong, nonatomic) IBOutlet UITextField *identifierField;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UISlider *countField;
@property (strong, nonatomic) IBOutlet UITextField *compoundField;

- (IBAction)editingDidEnd:(UITextField *)sender;
- (IBAction)countValueChanged:(UISlider *)sender;
- (IBAction)sendDataPoint:(id)sender;
- (IBAction)sendCompoundDataPoint:(id)sender;

@end
