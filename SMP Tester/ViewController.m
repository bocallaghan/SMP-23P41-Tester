//
//  ViewController.m
//  SMP Tester
//
//  Created by Brenton O'Callaghan on 15/09/2014.
//  Copyright (c) 2014 Bluefin Solutions Ltd. All rights reserved.
//

#import "ViewController.h"
#import "SMPConnectionManager.h"
#import "SMPCallbackHandler.h"

@interface ViewController ()
@property (retain, nonatomic) IBOutlet UITextView *logBox;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController - viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"ViewController - didReceiveMemoryWarning");
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_beginRegistration:(id)sender {
    NSLog(@"ViewController - btn_beginRegistration");
    
    // Kick off the registration process using the SMPConnectionManager static methods.
    // Place in a try catch to catch any weird errors and ensure stability of the app.
    @try {
        [SMPConnectionManager beginRegistration];
    }
    @catch (NSException *exception) {
        NSLog(@"ERROR - connection aborted - %@.", [exception reason]);
        [self showAlertWithTitle:[exception name] andMessage:[exception reason]];
    }
}

- (IBAction)btn_synchronise:(id)sender {
    NSLog(@"ViewController - btn_synchronise");

    // Kick off the Sync process using the SMPConnectionManager static methods.
    // Place in a try catch to catch any weird errors and ensure stability of the app.
    @try {
        [SMPConnectionManager beginSync];
    }
    @catch (NSException *exception) {
        NSLog(@"ERROR - sync aborted - %@.", [exception reason]);
        [self showAlertWithTitle:[exception name] andMessage:[exception reason]];
    }
}
- (IBAction)btn_findAll:(id)sender {
    NSLog(@"ViewController - btn_findAll");
    
    
    @try {
        [self updateLogBox];
    }
    @catch (NSException *exception) {
        NSLog(@"Could not update log box.");
    }
    
}
- (IBAction)btn_reset:(id)sender {
    [SMPConnectionManager reset];
}

#pragma mark - Private Methods

// Show a generic alert with specified text.
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message{
    
    // Create a generic prompt to be used to show messages.
    UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    
    [newAlert show];
}

// Update the contents of the text box on the screen.
- (void)updateLogBox{
    NSMutableArray *logs = [SMPCallbackHandler getLogMessages];
    NSString *finalText = @"";
    
    for (SUPStringList *aLog in logs) {
        finalText = [finalText stringByAppendingString:[NSString stringWithFormat:@"\n%@",[aLog description]]];
    }
    [self.logBox setText:finalText];
}

- (void)dealloc {
    [_logBox release];
    [super dealloc];
}
@end
