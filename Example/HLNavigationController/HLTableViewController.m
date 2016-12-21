//
//  HLTableViewController.m
//  HLNavigationController
//
//  Created by henvy on 20/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "HLTableViewController.h"
#import "UIColor+RandomColor.h"
#import "HLContainerController.h"
#import "HLViewControllerX.h"
@interface HLTableViewController ()
@property (nonatomic, strong) NSArray *datas;

@end

@implementation HLTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.navigationController.navigationBar.barTintColor = [UIColor randomColor];
    self.datas = [NSArray arrayWithObjects:@"HLAnimationTypeNone",@"HLAnimationTypeHorTranToLeft",@"HLAnimationTypeVerTranToUp",@"HLAnimationTypeCrossDissolve", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   

    if ([self.controllerDelegate respondsToSelector:@selector(viewController:willGotoNextController:withAnimation:)]) {
        HLViewControllerX *hv = [[HLViewControllerX alloc]init];
        hv.controllerDelegate = self.controllerDelegate;
        switch (indexPath.row) {
            case 0:
                [self.controllerDelegate viewController:self willGotoNextController:hv withAnimation:HLAnimationTypeNone];
                break;
            case 1:
                [self.controllerDelegate viewController:self willGotoNextController:hv withAnimation:HLAnimationTypeHorTranToLeft];
                break;
            case 2:
                [self.controllerDelegate viewController:self willGotoNextController:hv withAnimation:HLAnimationTypeVerTranToUp];
                break;
            default:
                [self.controllerDelegate viewController:self willGotoNextController:hv withAnimation:HLAnimationTypeCrossDissolve];
                break;
        }
    }
   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
