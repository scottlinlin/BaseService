//
//  PostbeManage.m
//  TTY
//
//  Created by scott.lin on 16/1/27.
//  Copyright © 2016年 ChinaPnR. All rights reserved.
//

#import "PostbeManage.h"
#import "PostbeDB.h"
#import "PostbeService.h"

static PostbeManage *instance = nil;

@interface PostbeManage ()<PostbeServiceDelegate>
@property (nonatomic,strong) NSMutableArray *sendQueue;  /*!<发送postbe数据队列*/
//@property(atomic,assign)  BOOL isSending;              /*!<是否正在发送，YES正在发送，NO发送完成*/
@property(nonatomic,strong)NSCondition *conditon;        /*!<条件锁，用于同步批量发送*/


@end
@implementation PostbeManage
/*!
 *  @author scott.lin, 16-01-28
 *
 *  @brief 获取PostbeManage单例
 */
+(instancetype)shareInstance{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;

}

-(id)init{
    self = [super init];
    if (self) {
        self.sendQueue = [NSMutableArray new];
        self.conditon = [NSCondition new];
    }
    return self;
}

/*!
 *  @author scott.lin, 16-02-04
 *
 *  @brief 配置postbe头部参数
 *  @param name  参数名
 *  @param value 参数值
 */
-(void)configHeadParam:(NSString*)name value:(id)value{
    NSMutableDictionary *param = [[PostbeSetting shareInstance] headData];
    if (value) {
        [param setObject:value forKey:name];
    }
}

/*!
 *  @author scott.lin, 16-02-19
 *
 *  @brief 参与check的key配置
 *  @param checkKeys 参与check的key集合
 */
-(void)configCheckKeys:(NSArray*)checkKeys{
     NSMutableArray *checkKeysV = [[PostbeSetting shareInstance] checkKeys];
    for (NSString *key in checkKeys) {
        [checkKeysV addObject:key];
    }
}

/*!
 *  @author scott.lin, 16-02-19
 *
 *  @brief 配置postbe附加参数
 *  @param name  参数名
 *  @param value 参数值
 */
-(void)configAdditionParam:(NSString*)name value:(id)value{
    NSMutableDictionary *param = [[PostbeSetting shareInstance] additionParam];
    if (value) {
        [param setObject:value forKey:name];
    }
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 初始化Post管理程序，批量发送数量为默认
 */
-(void)startup{
#ifdef POSTBE_ON
    [self startupWithSendCount:POSTBE_SEND_COUNT_DEFAULT];
#endif
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 初始化Post管理程序，并配置批量发送的数量
 *  @param count 批量发送的数量
 */
-(void)startupWithSendCount:(NSUInteger)count{
#ifdef POSTBE_ON
    if (count > POSTBE_SEND_COUNT_MAX) {
        count = POSTBE_SEND_COUNT_MAX;
    }
   
    [self startSendThread:count];
#endif
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 启动发送线程，往发送队列中写入数据
 */
-(void)startSendThread:(NSUInteger)count{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        while(YES){
            if (self.sendQueue.count == 0 ) {//访问数据库，读取数据并发送
                    NSUInteger dbCount = [[PostbeDB sharedInstance] getNum];
                    if (dbCount >= count) {
                        [self.conditon lock];
                        self.sendQueue = [[PostbeDB sharedInstance] getData:count];
                        NSLog(@"BATCH SEND POSTBE... ");
                        [PostbeService batchPostbe:self.sendQueue delegate:self];
                        [self.conditon wait];
                        [self.conditon unlock];
                    }
                }
                else{//直接批量发送
                    [self.conditon lock];
                     NSLog(@"BATCH SEND POSTBE ... ");
                    [PostbeService batchPostbe:self.sendQueue delegate:self ];
                    
                    [self.conditon wait];
                    [self.conditon unlock];
                }
            }
            NSLog(@"SEND THREAD PROCCESSING... ");
            sleep(1);
        
    });
}

/*!
 *  @author scott.lin, 16-01-28
 *
 *  @brief 批量发送成功回调
 */
-(void)onBatchPostbeSuccess{
    
    [self.conditon lock];
    [[PostbeDB sharedInstance] deleteData:self.sendQueue];
    [self.conditon signal];
    [self.conditon unlock];
     NSLog(@"BATCH SEND POSTBE SUCCESSED ");
}


/*!
 *  @author scott.lin, 16-01-28
 *
 *  @brief 批量发送失败回调
 */
-(void)onBatchPostbeFail{
    
    [self.conditon lock];
    [self.conditon signal];
    [self.conditon unlock];
     NSLog(@"BATCH SEND POSTBE FAILED ");
}


@end
