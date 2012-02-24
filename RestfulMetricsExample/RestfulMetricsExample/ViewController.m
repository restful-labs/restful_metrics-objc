//
//  ViewController.m
//  RestfulMetricsExample
//
//  Created by Alex McHale on 2/24/12.
//  Copyright (c) 2012 RESTful Labs. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize appNameField;
@synthesize apiKeyField;
@synthesize metricField;
@synthesize identifierField;
@synthesize countLabel;
@synthesize countField;
@synthesize compoundField;

- (IBAction)editingDidEnd:(UITextField *)sender
{
    [sender resignFirstResponder];
}

- (IBAction)countValueChanged:(UISlider *)sender
{
    countLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)sendDataPoint:(id)sender
{
    if (![self validateBasicData]) return;
    
    RestfulMetrics *rm = [[RestfulMetrics alloc] initWithAppName:appNameField.text apiKey:apiKeyField.text];
    [rm addMetric:metricField.text count:countField.value identifier:identifierField.text];
}

- (IBAction)sendCompoundDataPoint:(id)sender
{
    if (![self validateBasicData]) return;
    
    NSArray *values;
    
    if (compoundField.text.length == 0)
        values = [NSArray array];
    else
        values = [compoundField.text componentsSeparatedByString:@" "];
    
    RestfulMetrics *rm = [[RestfulMetrics alloc] initWithAppName:appNameField.text apiKey:apiKeyField.text];
    [rm addCompoundMetric:metricField.text values:values identifier:identifierField.text];
}

- (BOOL) validateBasicData
{
    NSString *title = @"Metric Validation Error";
    NSString *message = nil;
    
    if (appNameField.text.length == 0) {
        message = @"Please specify an app name.";
    } else if (apiKeyField.text.length == 0) {
        message = @"Please enter your api key.";
    } else if (metricField.text.length == 0) {
        message = @"Please specify a metric name.";
    }
    
    if (message != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    
    return message == nil;
}

- (void)viewDidUnload {
    [self setCompoundField:nil];
    [super viewDidUnload];
}
@end
