////
////  CommonTableViewVC.m
////  VichmsHealthDoctor
////  Created by  licc on 2018/8/31.
////  Copyright © 2018年 AnyOne. All rights reserved.
////
//
//#import "CommonTableViewVC.h"
//#import "CommonCell3.h"
//
//@interface CommonTableViewVC ()
//
//@end
//
//@implementation CommonTableViewVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    registerNibWithCellName(self.mainTableView, @"CommonCell3");
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - UITableViewDelegate UITableViewDatasource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataSourceArray.count;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    return 60;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
////    if(!cell){
////        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
////    }
//        CommonCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell3"];
//
//    cell.myLab.text = self.dataSourceArray[indexPath.row];
////    if(self.dataSourceImageArray.count > indexPath.row){
////        cell.imageView.image = [UIImage imageNamed:self.dataSourceImageArray[indexPath.row]];
////    }
////    else{
////        cell.imageView.image = nil;
////    }
//    [cell.myImg sd_setImageWithURL:[NSURL URLWithString:self.dataSourceImageArray[indexPath.row]]];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    [self didSelectIndexPath:indexPath];
//}
//-(void)didSelectIndexPath:(NSIndexPath *)indexPath{
//    
//}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
