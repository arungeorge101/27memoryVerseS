//
//  tableVC.m
//  27memoryVerseS
//
//  Created by Arun George on 2/4/14.
//  Copyright (c) 2014 Pages.Co. All rights reserved.
//

#import "tableVC.h"

@interface tableVC ()

@end

@implementation tableVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int row =  [prefs integerForKey:@"selectedRow"];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:1];
    
    UITableViewCell *cell = (UITableViewCell*)[self.tableView cellForRowAtIndexPath:index];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;*/
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //NSInteger section = [indexPath section];
    NSInteger section = indexPath.row;
    
    switch (section) {
        case 0: // First cell in section 1
            cell.textLabel.text = @"English Standard Version (ESV)";
            break;
        case 1: // Second cell in section 1
            cell.textLabel.text = @"New American Standard Bible (NASB)";
            break;
        case 2: // Third cell in section 1
            cell.textLabel.text = @"New International Version (NIV)";
            break;
        case 3: // Fourth cell in section 1
            cell.textLabel.text = @"King James Version (KJV)";
            break;
        case 4: // Fourth cell in section 1
            cell.textLabel.text = @"New King James Version (NKJV)";
            break;
        default:
            // Do something else here if a cell other than 1,2,3 or 4 is requested
            break;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * sectionHeader = [[UILabel alloc] initWithFrame:CGRectZero];
    sectionHeader.backgroundColor = [UIColor colorWithRed:59/255.0f green:126/255.0f blue:235/255.0f alpha:1.0f];
    sectionHeader.textAlignment = NSTextAlignmentCenter;
    sectionHeader.font = [UIFont boldSystemFontOfSize:20];
    sectionHeader.textColor = [UIColor blackColor];
    
    sectionHeader.text = @"Select the version:";
    return sectionHeader;
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - selected a particular row

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

#pragma mark - deselect a row

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark - Save button click
- (IBAction)saveButtonClick:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:[self.tableView indexPathForSelectedRow].row forKey:@"selectedRow"];
}
@end
