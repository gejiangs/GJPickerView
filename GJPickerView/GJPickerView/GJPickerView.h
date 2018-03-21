//
//  GJPickerView.h
//  GJPickerView
//
//  Created by gejiangs on 16/3/16.
//  Copyright © 2016年 guojiang. All rights reserved.
//  Version 1.0.1
//

#import <UIKit/UIKit.h>

@class GJPickerView;

@protocol GJPickerViewDelegate<NSObject>

@optional

- (NSInteger)numberOfComponentsInPickerView:(GJPickerView *)comboBoxView;
- (CGFloat)pickerView:(GJPickerView *)comboBoxView widthForComponent:(NSInteger)component;
- (NSInteger)pickerView:(GJPickerView *)comboBoxView numberOfRowsInComponent:(NSInteger)component;
- (NSString *)pickerView:(GJPickerView *)comboBoxView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(GJPickerView *)comboBoxView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)pickerViewConfirm:(GJPickerView *)comboBoxView;//点击确认按钮
- (void)pickerViewCancel:(GJPickerView *)comboBoxView;//点击取消按钮

@end

@interface GJPickerView : UIView

@property(nonatomic,weak) id<GJPickerViewDelegate> delegate;

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *leftText;
@property (nonatomic, copy)   NSString *rightText;


+ (instancetype)showInView:(UIView *)view;
+ (instancetype)showInView:(UIView *)view delegate:(id<GJPickerViewDelegate>)delegate;

-(void)setLeftText:(NSString *)text textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor;
-(void)setRightText:(NSString *)text textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor;

- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (NSInteger)selectedRowInComponent:(NSInteger)component;

@end
