//
//  ProjectHelper.h
//  ProjectBaseFrame
//
//  Created by Josh.Shron on 10/21/15.
//  Copyright © 2015 josh.shron. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^applicationBlock)(id datas);
typedef void(^imageSelectBlock)(NSDictionary *result);

@interface ProjectHelper : NSObject

+ (instancetype)shareHelper;

@property (nonatomic, strong) NSString *DocumentsPath;

//打电话
- (void)callCellPhone:(NSString *)cellPhone title:(NSString *)title block:(void (^)(NSInteger result)) block;

//取照片
- (void)imageControllerFromcamera:(BOOL)camera result:(imageSelectBlock) result viewController:(id)viewController;

- (void)displayMessageWithContent:(NSString *)content repice:(NSArray *)repice viewController:(id)viewController block:(applicationBlock)block;

//判断能否发短信
- (BOOL)canSendText;

@end
