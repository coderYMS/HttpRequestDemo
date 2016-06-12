//
//  ViewController.m
//  HttpRequestDemo
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 yms. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import "Result.h"

static NSString *const urlStr = @"http://app.eyisheng.net.cn/eyisheng/patientapi/getHospital?we_account_id=100102200";
static NSString *const uploadUrlStr = @"http://app.eyisheng.net.cn/eyisheng/thirdphase/saveupload";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)normalRequest{
//    普通请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html", nil];
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
            Result *result = [Result yy_modelWithJSON:responseObject];
            NSLog(@"success--%@",result);
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"fail--%@",error);
        }];
}

- (void)uploadRequest{
    //上传图片
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [paramDic setObject:@"diseaseid" forKey:@"232"];//写反了
    [paramDic setObject:@"version" forKey:@"2.1.7"];
    [paramDic setObject:@"record_type" forKey:@"2"];
    [paramDic setObject:@"member_id" forKey:@"10437"];
    [paramDic setObject:@"type" forKey:@"1"];
    [paramDic setObject:@"id" forKey:@"71"];
    
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"onePhoto"], 0.1);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    serializer.acceptableContentTypes =[NSSet setWithObjects: @"text/html", nil];
    
    manager.responseSerializer = serializer;
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:uploadUrlStr parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"data" fileName:@"test.jpeg" mimeType:@"image/jpeg"];
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error--%@",error);
        }else{
            NSLog(@"success -- %@===%@==",response,responseObject);
        }
    }];
    
    [uploadTask resume];

}

- (IBAction)btnClick:(id)sender {
    [self normalRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
