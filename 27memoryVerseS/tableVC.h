//
//  tableVC.h
//  27memoryVerseS
//
//  Created by Arun George on 2/4/14.
//  Copyright (c) 2014 Pages.Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableVC : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
}
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic, retain) NSIndexPath *checkedData;
- (IBAction)saveButtonClick:(id)sender;

@end
