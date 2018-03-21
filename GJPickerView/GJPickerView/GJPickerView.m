//
//  GJPickerView.h
//  GJPickerView
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

@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UIButton *leftButton;
@property (nonatomic, strong)   UIButton *rightButton;
@property (nonatomic, strong)   UIView *pickBoxView;
@property (nonatomic, strong)   UIPickerView *pickerView;

@end

@implementation GJPickerView

+(instancetype)showInView:(UIView *)view
{
    GJPickerView *selfView = [[GJPickerView alloc] initWithFrame:view.bounds];
    
    [view addSubview:selfView];
    [selfView show:YES];
    
    return selfView;
}

+(instancetype)showInView:(UIView *)view delegate:(id<GJPickerViewDelegate>)delegate
{
    GJPickerView *selfView = [[GJPickerView alloc] initWithFrame:view.bounds];
    selfView.delegate = delegate;
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
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setFrame:CGRectMake(15, 10, 70, 30)];
    [_leftButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _leftButton.layer.cornerRadius = 10.f;
    _leftButton.layer.masksToBounds = YES;
    [_leftButton setBackgroundImage:[self imageWithColor:[self colorR:204 G:204 B:204]] forState:UIControlStateNormal];
    [self.pickBoxView addSubview:_leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(self.frame.size.width - 85, 10, 70, 30)];
    [_rightButton setTitle:NSLocalizedString(@"Sure", nil) forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightButton.layer.cornerRadius = 10.f;
    _rightButton.layer.masksToBounds = YES;
    [_rightButton setBackgroundImage:[self imageWithColor:[self colorR:140 G:198 B:63]] forState:UIControlStateNormal];
    [self.pickBoxView addSubview:_rightButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, self.frame.size.width-200, 20)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.pickBoxView addSubview:_titleLabel];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 225)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickBoxView addSubview:_pickerView];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setLeftText:(NSString *)leftText
{
    _leftText = leftText;
    [self.leftButton setTitle:leftText forState:UIControlStateNormal];
}

-(void)setRightText:(NSString *)rightText
{
    _rightText = rightText;
    [self.rightButton setTitle:rightText forState:UIControlStateNormal];
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

-(void)setLeftText:(NSString *)text textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor
{
    [self.leftButton setTitle:text forState:UIControlStateNormal];
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:[self imageWithColor:bgColor] forState:UIControlStateNormal];
}

-(void)setRightText:(NSString *)text textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor
{
    [self.rightButton setTitle:text forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[self imageWithColor:bgColor] forState:UIControlStateNormal];
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


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:widthForComponent:)]) {
        return [_delegate pickerView:self widthForComponent:component];
    }
    NSInteger number = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
         number = [_delegate numberOfComponentsInPickerView:self];
    }
    return [UIScreen mainScreen].bounds.size.width / number;
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
