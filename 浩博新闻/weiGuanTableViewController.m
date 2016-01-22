//
//  weiGuanTableViewController.m
//  1-新闻客户端
//
//  Created by qingyun on 15/12/12.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "weiGuanTableViewController.h"
#import "weiguanTableViewCell.h"
#import "weiguanModels.h"

@interface weiGuanTableViewController () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) weiguanModels *model;
@end

@implementation weiGuanTableViewController

- (NSArray *)datas
{
    if (_datas == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"weiGuan" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            weiguanModels *weiguan = [weiguanModels weiguanWithDict:dict];
            [muArray addObject:weiguan];
        }
        _datas = muArray;
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else{
        return self.datas.count-1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    weiguanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"weiguan" owner:self options:nil][0];
    }
    
    if (indexPath.section == 1) {
        weiguanModels *models = self.datas[indexPath.row+1];
        cell.weiguanM = models;
    }else{
        weiguanModels *models = self.datas[indexPath.row];
        cell.weiguanM = models;
    }
    
    return cell;
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
