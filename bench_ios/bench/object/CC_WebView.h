//
//  CC_WebView.h
//  Patient
//
//  Created by 路飞 on 2019/3/21.
//  Copyright © 2019 lufei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CC_WebViewDelegate <NSObject>
@optional;

/**
 *  页面标题
 */
-(void)webViewTitleChange:(NSString*)title;

/**
 *  页面开始加载时调用
 */
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;

/**
 *  页面加载失败时调用
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

/**
 *  当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;

/**
 *  页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;

/**
 *  提交发生错误时调用
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error;

/**
 *  接收到服务器跳转请求即服务重定向时之后调用
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;

/**
 *  根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

/**
 *  根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;

/**
 *  进程被终止时调用
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView;

/**
 *  若是https，需要响应身份验证时调用 同样在block中需要传入用户身份凭证
 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;

/**
 *  JS调用OC响应
 */
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

/**
 *  html的alert弹框
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;

@end

@interface CC_WebView : UIView<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, weak) id<CC_WebViewDelegate>delegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSURL *url;
/**
 *  进度条tint颜色
 */
@property (nonatomic, strong) UIColor *progressTintColor;
/**
 *  进度条trackTint颜色
 */
@property (nonatomic, strong) UIColor *progressTrackTintColor;

/**
 初始化
 
 @param frame frame
 @param configuration webview配置信息
 @return 实例
 */
-(instancetype)initWithFrame:(CGRect)frame  configuration:(WKWebViewConfiguration *)configuration;

/**
 JS调用OC方法名

 @param messageArr 方法名数组
 */
-(void)addScriptMessageName:(NSArray<NSString*>*)messageArr;
/**
 开始加载网页
 */
-(void)startLoadingHtml;

-(BOOL)canGoBack;
-(BOOL)canGoForward;
-(void)goBack;
-(void)goForward;
-(void)refresh;

/**
 注入JSString 调用html方法

 @param javaScriptString javaScriptString description
 @param completionHandler 回调函数
 */
- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

#pragma mark - cookies管理
/**
 提供cookies插入，用于loadRequest 网页之前
 @param cookie NSHTTPCookie 类型
 cookie 需要设置 cookie 的name，value，domain，expiresDate（过期时间，当不设置过期时间，cookie将不会自动清除）；
 cookie 设置expiresDate时使用 [cookieProperties setObject:expiresDate forKey:NSHTTPCookieExpires];将不起作用，原因不明；使用 cookieProperties[expiresDate] = expiresDate; 设置cookies 设置时间。
 */
- (void)setCookie:(NSHTTPCookie *)cookie;

/**
 读取本地磁盘的cookies，包括WKWebview的cookies和sharedHTTPCookieStorage存储的cookies
 @return 返回包含所有的cookies的数组；
 当系统低于 iOS11 时，cookies 将同步NSHTTPCookieStorage的cookies，当系统大于iOS11时，cookies 将同步
 */
- (NSMutableArray *)WKSharedHTTPCookieStorage;

/** 删除单个cookie */
- (void)deleteWKCookie:(NSHTTPCookie *)cookie completionHandler:(nullable void (^)(void))completionHandler;

/** 删除域名下的所有的cookie */
- (void)deleteWKCookiesByHost:(NSURL *)host completionHandler:(nullable void (^)(void))completionHandler;

/** 清除所有的cookies */
- (void)clearWKCookies;

/** js获取domain的cookie */
- (NSString *)jsCookieStringWithDomain:(NSString *)domain;

/** PHP 获取domain的cookie */
- (NSString *)phpCookieStringWithDomain:(NSString *)domain;

/** 搜索指定域名下的cookies */
- (WKUserScript *)searchCookieForUserScriptWithDomain:(NSString *)domain;

@end

NS_ASSUME_NONNULL_END
