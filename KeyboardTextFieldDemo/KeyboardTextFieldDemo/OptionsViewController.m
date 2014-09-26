//
//  OptionsViewController.m
//  IQKeyboard
//
//  Created by Iftekhar on 27/09/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

#import "OptionsViewController.h"
#import "OptionTableViewCell.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OptionTableViewCell class]) forIndexPath:indexPath];

    cell.labelOption.text = self.options[indexPath.row];

    cell.accessoryType = (indexPath.row == self.selectedIndex)  ? UITableViewCellAccessoryCheckmark    :   UITableViewCellAccessoryNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedIndex = indexPath.row;
    
    if ([self.delegate respondsToSelector:@selector(optionsViewController:didSelectIndex:)])
    {
        [self.delegate optionsViewController:self didSelectIndex:indexPath.row];
    }
    
    [tableView reloadRowsAtIndexPaths:[tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationFade];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
