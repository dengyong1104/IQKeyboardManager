//
//  TextViewSpecialCaseViewController.m
//  KeyboardTextFieldDemo

#import "TextViewSpecialCaseViewController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"

@implementation TextViewSpecialCaseViewController
{
    IQKeyboardReturnKeyHandler *returnKeyHandler;
}

-(IBAction)canAdjustTextView:(UIBarButtonItem*)barButton
{
    if ([barButton.title isEqualToString:@"Disable Adjust"])
    {
        [[IQKeyboardManager sharedManager] setCanAdjustTextView:NO];
        [barButton setTitle:@"Enable Adjust"];
    }
    else
    {
        [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
        [barButton setTitle:@"Disable Adjust"];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    [returnKeyHandler setLastTextFieldReturnKeyType:UIReturnKeyDone];
    
    if ([[IQKeyboardManager sharedManager] canAdjustTextView])
    {
        [barButtonAdjust setTitle:@"Disable Adjust"];
    }
    else
    {
        [barButtonAdjust setTitle:@"Enable Adjust"];
    }
    
    if (!self.navigationController)
    {
        [buttonPop setHidden:YES];
        [buttonPush setHidden:YES];
        [buttonPresent setTitle:@"Dismiss" forState:UIControlStateNormal];
    }
}

-(void)dealloc
{
    returnKeyHandler = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}


- (IBAction)popClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)presentClicked:(id)sender
{
    @try {
        if (self.navigationController)
        {
            TextViewSpecialCaseViewController *controller = [[TextViewSpecialCaseViewController alloc] init];
            
            [controller setModalTransitionStyle:arc4random()%4];
            
            // TransitionStylePartialCurl can only be presented by FullScreen style.
            if (controller.modalTransitionStyle == UIModalTransitionStylePartialCurl)
                controller.modalPresentationStyle = UIModalPresentationFullScreen;
            else
                controller.modalPresentationStyle = arc4random()%4;
            
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception:%@",exception);
    }
    @finally {
        
    }
}

@end
