//
//  LXCSortModel.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/20.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCSortModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *label;

/** 值--> 给服务器发送的 */
@property (nonatomic, strong) NSNumber *value;

@end
