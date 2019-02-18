//
//  SelectViewController.m
//  DJINavi
//
//  Created by 何彦男 on 2018/7/13.
//  Copyright © 2018年 何彦男. All rights reserved.
//

#import "SelectViewController.h"
#import "DJIRootViewController.h"

//UITableView *_tableView;
NSMutableArray *_dataArry;
NSMutableArray *_detailArry;
NSMutableArray *_searchList;
NSMutableArray *_sdList;
NSMutableArray *_tempList;

bool isSearch;

@interface SelectViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic,retain) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction) backBtnAction:(id)sender;
- (IBAction) searchBarCancelButtonClicked:(id)sender;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self creatData];
    [self creatTableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (void)backBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}


//我们这里来设计一个二维数组

-(void)creatData{
    
    isSearch = NO;
    
    _dataArry=[[NSMutableArray alloc] init];
    _detailArry=[[NSMutableArray alloc] init];
    _searchList=[[NSMutableArray alloc] init];
    _sdList=[[NSMutableArray alloc] init];
    _tempList = [[NSMutableArray alloc] init];
    
    NSMutableArray *arr_0=[[NSMutableArray alloc]init];
    NSMutableArray *darr_0=[[NSMutableArray alloc]init];
    
    NSString *str_00 =[NSString stringWithFormat:@"小米大厨烘焙坊"];
    [arr_0 addObject:str_00];
    NSString *sdr_00 =[NSString stringWithFormat:@"好玩指数：5星 预计排队：0小时 距您：300m"];
    [darr_0 addObject:sdr_00];
    [_tempList addObject:str_00];
    
    NSString *str_01 =[NSString stringWithFormat:@"七个小矮人矿山车"];
    [arr_0 addObject:str_01];
    NSString *sdr_01 =[NSString stringWithFormat:@"好玩指数：5星 预计排队：0.5小时 距您：355m"];
    [darr_0 addObject:sdr_01];
    [_tempList addObject:str_01];
    
    NSString *str_02 =[NSString stringWithFormat:@"创极速光轮"];
    [arr_0 addObject:str_02];
    NSString *sdr_02 =[NSString stringWithFormat:@"好玩指数：6星 预计排队：2小时 距您：237m"];
    [darr_0 addObject:sdr_02];
    [_tempList addObject:str_02];
    
     [_dataArry addObject:arr_0];
     [_detailArry addObject:darr_0];
    
    NSMutableArray *arr_1=[[NSMutableArray alloc]init];
    NSMutableArray *darr_1=[[NSMutableArray alloc]init];
    
    NSString *str_10 =[NSString stringWithFormat:@"加勒比海盗·沉落宝藏之战"];
    [arr_1 addObject:str_10];
    NSString *sdr_10 =[NSString stringWithFormat:@"好玩指数：5星 预计排队：1小时 距您：1025m"];
    [darr_1 addObject:sdr_10];
    [_tempList addObject:str_10];
    
    NSString *str_11 =[NSString stringWithFormat:@"巴斯光年星际营救"];
    [arr_1 addObject:str_11];
    NSString *sdr_11 =[NSString stringWithFormat:@"好玩指数：4星 预计排队：1小时 距您：744m"];
    [darr_1 addObject:sdr_11];
    [_tempList addObject:str_11];
    
    NSString *str_12 =[NSString stringWithFormat:@"太空幸会史迪奇"];
    [arr_1 addObject:str_12];
    NSString *sdr_12 =[NSString stringWithFormat:@"好玩指数：4星 预计排队：1.5小时 距您：569m"];
    [darr_1 addObject:sdr_12];
    [_tempList addObject:str_12];
    
    [_dataArry addObject:arr_1];
    [_detailArry addObject:darr_1];
    
    NSMutableArray *arr_2=[[NSMutableArray alloc]init];
    NSMutableArray *darr_2=[[NSMutableArray alloc]init];
    
    NSString *str_20 =[NSString stringWithFormat:@"翱翔·飞越地平线"];
    [arr_2 addObject:str_20];
    NSString *sdr_20 =[NSString stringWithFormat:@"好玩指数：4星 预计排队：3小时 距您：1063m"];
    [darr_2 addObject:sdr_20];
    [_tempList addObject:str_20];
    
    NSString *str_21 =[NSString stringWithFormat:@"探险家独木舟"];
    [arr_2 addObject:str_21];
    NSString *sdr_21 =[NSString stringWithFormat:@"好玩指数：4星 预计排队：2小时 距您：433m"];
    [darr_2 addObject:sdr_21];
    [_tempList addObject:str_21];
    
    [_dataArry addObject:arr_2];
    [_detailArry addObject:darr_2];
}

-(void)creatTableView{
    
    //设置数据源
    self.tableView.dataSource =self;
    
    //设置代理
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    //[self.view addSubview:self.searchBar];
    
    //NSLog(@"Error!");
    
}

#pragma mark - UITableViewDataSource协议

//设置有多少分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (isSearch) {
        return 1;
    } else {
        return [_dataArry count];
    }
    
}

//每个分区有多少行

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (isSearch) {
        return [_searchList count];
    } else {
        return [_dataArry[section] count];
    }
    
}

//获取cell  每次显示cell 之前都要调用这个方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //创建复用标识符
    //static NSString *identifire = @"identifier";
    static NSString * cellID=@"cellID";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    //UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifire];
    
    if (cell == nil) {//如果没有可以复用的
       cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if (isSearch) {
        cell.textLabel.text = _searchList[indexPath.row];
        //cell.detailTextLabel.text = _sdList[indexPath.section][indexPath.row];
    } else {
        //填充cell  把数据模型中的存储数据 填充到cell中
        cell.textLabel.text = _dataArry[indexPath.section][indexPath.row];
        cell.detailTextLabel.text = _detailArry[indexPath.section][indexPath.row];
    
    }
    
    return cell;
    
}

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    NSLog(@"搜索Begin");
//    return YES;
//}
//
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    NSLog(@"搜索End");
//    return YES;
//}
//
//
//
//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
//
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//
//    if (_searchList!= nil) {
//        [_searchList removeAllObjects];
//    }
//    //过滤数据
//    _searchList= [NSMutableArray arrayWithArray:[_dataArry filteredArrayUsingPredicate:preicate]];
//    //刷新表格
//    return YES;
//}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
 {
    NSLog(@"----textDidChange------");
    // 调用filterBySubstring:方法执行搜索
    [self filter:searchText];
}

#pragma mark - UISearchBarDelegate -
-(void)filter:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchText];
    _searchList = [[NSMutableArray alloc] initWithArray:[_tempList filteredArrayUsingPredicate:predicate]];
    
    isSearch = YES;
    
     if (_searchList.count == 0 && [self.searchBar.text isEqual: @""]) {
         _searchList = nil;
    }

    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"----searchBarCancelButtonClicked------");
    // 取消搜索状态
    isSearch = NO;
    [self.tableView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"----searchBarSearchButtonClicked------");
    // 调用filterBySubstring:方法执行搜索
    [self filter:searchBar.text];
    // 放弃作为第一个响应者，关闭键盘
    [searchBar resignFirstResponder];
}


//设置头标
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [NSString stringWithFormat:@"推荐指数：%ld", 5 - section];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
