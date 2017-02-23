//
//  ViewController.m
//  GJPickerView
//
//  Created by 郭江 on 2017/2/21.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "ViewController.h"
#import "GJPickerView.h"


@interface ViewController ()<GJPickerViewDelegate>

@property (nonatomic, strong) NSArray *contentList;
@property (nonatomic, strong) GJPickerView *pickerView;

@property (nonatomic, strong) NSString *proCode;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *areaCode;
@property (weak, nonatomic) IBOutlet UIButton *showComboxButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

-(void)loadData
{
    self.contentList = @[@[@"1",@"2",@"3"],@[@"111",@"222",@"333"]];
    
}

-(IBAction)show:(id)sender
{
    self.pickerView = [GJPickerView showInView:self.view];
    _pickerView.titleLabel.text = @"选择";
    _pickerView.delegate = self;
}


- (NSInteger)numberOfComponentsInPickerView:(GJPickerView *)comboBoxView
{
    return [self.contentList count];
}
- (NSInteger)pickerView:(GJPickerView *)comboBoxView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.contentList objectAtIndex:component] count];
}
- (NSString *)pickerView:(GJPickerView *)comboBoxView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.contentList objectAtIndex:component] objectAtIndex:row];
}
//- (void)pickerView:(GJPickerView *)comboBoxView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    if (component == 0) {
//        [self.pickerView reloadComponent:1];
//        [self.pickerView reloadComponent:2];
//    }else if (component == 1){
//        [self.pickerView reloadComponent:2];
//    }
//}

- (void)pickerViewConfirm:(GJPickerView *)comboBoxView
{
    NSMutableString *content = [[NSMutableString alloc] init];
    
    NSInteger index0 = [comboBoxView selectedRowInComponent:0];
    NSInteger index1 = [comboBoxView selectedRowInComponent:1];
    
    [content appendString:[[self.contentList objectAtIndex:0] objectAtIndex:index0]];
    [content appendString:[[self.contentList objectAtIndex:1] objectAtIndex:index1]];
    
    [self.showComboxButton setTitle:content forState:UIControlStateNormal];
    
}
- (void)pickerViewCancel:(GJPickerView*)comboBoxView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
