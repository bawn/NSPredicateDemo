//
//  ViewController.m
//  NSPredicateDemo
//
//  Created by bawn on 2020/3/5.
//  Copyright © 2020 bawn. All rights reserved.
//

#import "ViewController.h"
#import "Man.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray<Man *> *sourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableArray<Man *> *array = @[].mutableCopy;
    for (NSInteger n = 0; n <= 10; n++) {
        Man *man = Man.new;
        man.age = n;
        man.name = [NSString stringWithFormat:@"name-%@", @(n).stringValue];
        [array addObject:man];
    }
    

    NSMutableArray<Man *> *sourceArray = array.copy;
    NSPredicate *pre = [NSPredicate predicateWithBlock:^BOOL(Man *  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject.age != 0;
    }];
    [sourceArray filterUsingPredicate:pre];
    
    
    
    self.sourceArray = sourceArray;
    
    {
//        sourceArray.firstObject.name = nil;
//        self.sourceArray.firstObject.name = NSNull.null;
        // 筛选出所有 age == 2 的数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name == %@ OR name.length == %@", nil, @0];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出所有 age == 2 的数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"age == %@", @2];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出所有 name == “name-0” 的数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name == %@", @"name-0"];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出所有 name.length == 0 的数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name.length == %@", @0];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出所有 age>= 2 的数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"age >= %@", @2];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出所有 name 包含 “0” 字符串的数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@", @"0"];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出所有 name 中以 “name-”开头的字符串数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@", @"name-"];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出所有 name 中以 “0”结尾的字符串数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH %@", @"0"];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出所有 1 <= age >= 3 结尾的字符串数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"age BETWEEN {%@, %@}", @1, @3];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // LIKE
        // 筛选出所有 name 中以 “name-”开头后面接一个任意字符的字符串数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name LIKE %@", @"name-?"];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    
    {
        // 筛选出 age 符合指定集合中的数据
        NSArray *otherArray = @[@1, @3];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF.age IN %@", otherArray];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 筛选出 age 符合指定集合中的数据
        NSArray *otherArray = @[@1, @3];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF.age BETWEEN %@", otherArray];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        // 组合 AND
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"age >= %d AND age <= %d AND age != %d", 2, 8, 5];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    
    {
        // 用于 NSMutableArray 删除数据
        // array 删除 age == 2 的数据
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"NOT (age == %@)", @2];
        [array filterUsingPredicate:pre];
        NSLog(@"%@", [array valueForKeyPath:@"name"]);
    }
    
    
    {
        // 看得懂的写法
        NSPredicate *pre = [NSPredicate predicateWithBlock:^BOOL(Man * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject.name hasSuffix:@"0"];
        }];
        NSArray *targetArray = [sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    
}

/// 匹配用法
- (IBAction)matchButtonAction:(id)sender {
    
    {
        self.sourceArray.firstObject.name = @"";
        // self.sourceArray 里的所有数据的 age 都小于 8
//        NSPredicate *nullPre = [NSPredicate predicateWithFormat:@"ANY name isKindOfClass:%@", NSNull.class];
        NSPredicate *nilPre = [NSPredicate predicateWithFormat:@"ANY name.length == %@", @0];
        NSCompoundPredicate *pre = [NSCompoundPredicate orPredicateWithSubpredicates:@[nilPre]];
        NSLog(@"%d", [pre evaluateWithObject:self.sourceArray]);
        
    }
    
    {
        self.sourceArray.firstObject.name = NSNull.null;
//         self.sourceArray 里的所有数据的 age 都小于 8
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"AN name.length == %@", @0];
        NSLog(@"%d", [pre evaluateWithObject:self.sourceArray]);
        
    }
    
    {
        // self.sourceArray 里的所有数据的 age 都小于 8
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"ALL ae < %@", @8];
        NSLog(@"%d", [pre evaluateWithObject:self.sourceArray]);
    }
    
    {
        
        // self.sourceArray 里的所有数据的 age 都小于 8
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@"ANY name isEqualToString:%@", @"name-0"];
//        NSLog(@"%d", [pre evaluateWithObject:self.sourceArray]);
    }
    
    {
        // self.sourceArray 里的任意一数据的 age 是否小于 8
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"ANY age < %@", @2];
        NSLog(@"%d", [pre evaluateWithObject:self.sourceArray]);
    }
    
    {
        // 正则匹配
        NSString *numRegex = @"^[0-9]+(.[0-9]{1})?$";
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
        NSLog(@"%d", [pre evaluateWithObject:@"1.2"]);

    }
    
    
    {
        // array 中的对象是否都是 Man 实例
        NSArray *array = @[Man.new, @"2", @1];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"ALL SELF isKindOfClass:%@", Man.class];
        NSLog(@"%d", [pre evaluateWithObject:array]);
        
    }
    
    

}



- (IBAction)buttonAction:(id)sender {
    NSMutableArray<NSDictionary *> *array = @[].mutableCopy;
    for (NSInteger n = 0; n <= 10; n++) {
        [array addObject:@{@"age": @(n)}];
    }
    
    {
        
//        self.sourceArray.firstObject = NSNull.null;
        // 不会crash
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name == %@", @"name-0"];
        NSArray *targetArray = [self.sourceArray filteredArrayUsingPredicate:pre];
//        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
    {
        /// crash
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"address == %@", @"22"];
        NSArray *targetArray = [self.sourceArray filteredArrayUsingPredicate:pre];
        NSLog(@"%@", [targetArray valueForKeyPath:@"name"]);
    }
    
}


@end
