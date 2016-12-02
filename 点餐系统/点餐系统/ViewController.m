//
//  ViewController.m
//  点餐系统
//
//  Created by lihonggui on 2016/11/15.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
#warning 数据中已经是字符串了
@property(nonatomic,strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *fruitLabel;
@property (weak, nonatomic) IBOutlet UILabel *meanLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    //设置软件启动后默认显示
//    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
//    [self pickerView:self.pickerView didSelectRow:0 inComponent:1];
//    [self pickerView:self.pickerView didSelectRow:0 inComponent:2];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        [self pickerView:self.pickerView didSelectRow:0 inComponent:i];
    }

}
-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"01foods.plist" ofType:nil];
        //直接转换为数组
        _dataArray = [NSArray arrayWithContentsOfFile:filePath];
        
    }
    return _dataArray;
}
#pragma mark
#pragma mark -  选着
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"%ld",component);
    //取出数据
    NSString *str = self.dataArray[component][row];
    if (component == 0) {
        self.fruitLabel.text = str;
    }else if (component == 1) {
        self.meanLabel.text = str;
    }else if (component == 2)
        self.wineLabel.text = str;

}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    NSLog(@"component%ld",component);
}
#pragma mark
#pragma mark -  组
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSLog(@"self.dataArray.count%ld",self.dataArray.count);
    return self.dataArray.count;
}
#pragma mark
#pragma mark -  行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //取出数据
    NSArray *temp = self.dataArray[component];
    return temp.count;
}
#pragma mark
#pragma mark -  内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //获取数据
    NSArray *temp = self.dataArray[component];
    return temp[row];
}
- (IBAction)randomButton:(UIButton *)sender {
    /*
     pickerView上变化
     label变化
     */
    //获取数据
    
    for (int i = 0; i < self.dataArray.count; i++) {
       
        NSInteger randomNumber = [self.dataArray[i]count];
        u_int32_t number = arc4random_uniform((int)randomNumber);
        NSLog(@"number%u",number);
        //会有重复的出现,先取出数据进行对比,相等的话,就在随机生成一次
        NSInteger n = [self.pickerView selectedRowInComponent:i];
        while (n == number) {
           number = arc4random_uniform((int)randomNumber);
        }
        [self pickerView:self.pickerView didSelectRow:number inComponent:i];
        [self.pickerView selectRow:number inComponent:i animated:YES];
    }
}

@end
