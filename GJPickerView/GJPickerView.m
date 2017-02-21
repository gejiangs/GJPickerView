//
//  JamPickerView.m
//  Framework
//
//  Created by gejiangs on 16/3/16.
//  Copyright © 2016年 guojiang. All rights reserved.
//  Version 1.0.0
//

#import "GJPickerView.h"

@interface GJPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL isShow;
}

@property (nonatomic, strong) UIView *pickBoxView;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation GJPickerView

+(instancetype)showInView:(UIView *)view
{
    GJPickerView *selfView = [[GJPickerView alloc] initWithFrame:view.bounds];
    
    [view addSubview:selfView];
    [selfView show:YES];
    
    return selfView;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    
    UIButton *handlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    handlerView.frame = self.bounds;
    handlerView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.3];
    [handlerView addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:handlerView];
    
    self.pickBoxView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 265)];
    _pickBoxView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickBoxView];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setFrame:CGRectMake(15, 10, 70, 30)];
    [_cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelButton.layer.cornerRadius = 10.f;
    _cancelButton.layer.masksToBounds = YES;
    [_cancelButton setBackgroundImage:[self imageWithColor:[self colorR:204 G:204 B:204]] forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:[self imageWithColor:[self colorR:165 G:165 B:165]] forState:UIControlStateHighlighted];
    [self.pickBoxView addSubview:_cancelButton];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureButton setFrame:CGRectMake(self.frame.size.width - 85, 10, 70, 30)];
    [_sureButton setTitle:NSLocalizedString(@"Sure", nil) forState:UIControlStateNormal];
    [_sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureButton.layer.cornerRadius = 10.f;
    _sureButton.layer.masksToBounds = YES;
    [_sureButton setBackgroundImage:[self imageWithColor:[self colorR:140 G:198 B:63]] forState:UIControlStateNormal];
    [_sureButton setBackgroundImage:[self imageWithColor:[self colorR:117 G:158 B:53]] forState:UIControlStateHighlighted];
    [self.pickBoxView addSubview:_sureButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, self.frame.size.width-200, 20)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.pickBoxView addSubview:_titleLabel];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 225)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickBoxView addSubview:_pickerView];
}


-(void)cancelAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerViewCancel:)]) {
        [_delegate pickerViewCancel:self];
    }
    [self show:NO];
}

-(void)sureAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerViewConfirm:)]) {
        [_delegate pickerViewConfirm:self];
    }
    [self show:NO];
}

-(void)show:(BOOL)show
{
    isShow = show;

    CGRect frame = self.pickBoxView.frame;
    if (show) {
        frame.origin.y = self.frame.size.height - frame.size.height;
    }else{
        frame.origin.y = self.frame.size.height;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickBoxView.frame = frame;
    } completion:^(BOOL finished) {
        if (isShow == NO) {
            [self removeFromSuperview];
        }
    }];
}

-(void)reloadAllComponents
{
    [_pickerView reloadAllComponents];
}

-(void)reloadComponent:(NSInteger)component
{
    [_pickerView reloadComponent:component];
}

-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    [_pickerView selectRow:row inComponent:component animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    return [_pickerView selectedRowInComponent:component];
}

#pragma mark --pickerView 代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        return [_delegate numberOfComponentsInPickerView:self];
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [_delegate pickerView:self numberOfRowsInComponent:component];
    }
    return 0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [_delegate pickerView:self titleForRow:row forComponent:component];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [_delegate pickerView:self didSelectRow:row inComponent:component];
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* titleLabel = (UILabel*)view;
    if (!titleLabel){
        titleLabel = [[UILabel alloc] init];
        titleLabel.minimumScaleFactor = 8.;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.textColor=[self colorR:69 G:69 B:69];
        titleLabel.font=[UIFont systemFontOfSize:15];
    }
    titleLabel.text = [self pickerView:self.pickerView titleForRow:row forComponent:component];
    
    return titleLabel;
}

#pragma mark - Method
-(UIColor *)colorR:(int)r G:(int)g B:(int)b
{
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f];
}

-(UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
