//
//  CC_WebView.m
//  Patient
//
//  Created by 路飞 on 2019/3/21.
//  Copyright © 2019 lufei. All rights reserved.
//
#import <Foundation/Foundation.h>
static NSString* const CCWKCookies = @"CCWKCookiesKey";

#import "CC_WebView.h"

@interface CC_WebView ()
@property (nonatomic, copy) WKWebViewConfiguration *configuration;
@property (nonatomic, strong) WKWebView *webView;
//网页加载进度视图
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, copy) NSArray<NSString*>* messageHandleArr;//JS调用Native js方法名数组；供销毁和回调用
@end
@implementation CC_WebView

#pragma mark - lifeCircle
-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    if (self = [super initWithFrame:frame]) {
        self.configuration = configuration;
        [self initViews];
    }
    return self;
}
-(void)dealloc{
    //移除注册的js方法
    for (NSString* functionStr in _messageHandleArr) {
        [[_webView configuration].userContentController removeScriptMessageHandlerForName:functionStr];
    }
    //移除观察者
    [_webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [_webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
}
#pragma mark - private
-(void)addScriptMessageName:(NSArray<NSString *> *)messageArr{
    self.messageHandleArr = messageArr;
    for (NSString* messageStr in messageArr) {
        [self.webView.configuration.userContentController addScriptMessageHandler:self name:messageStr];
    }
}
-(void)initViews{
    [self addSubview:self.webView];
    [self addSubview:self.progressView];
    //添加监测网页加载进度的观察者
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}
//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _webView) {
        NSLog(@"网页加载进度 = %f",_webView.estimatedProgress);
        self.progressView.progress = _webView.estimatedProgress;
        if (_webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }else if([keyPath isEqualToString:@"title"] && object == _webView){
        if (_delegate&& [_delegate respondsToSelector:@selector(webViewTitleChange:)]) {
            [_delegate webViewTitleChange:_webView.title];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
-(void)startLoadingHtml{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:_url];
    NSString *Domain = request.URL.host;
    
    /** 插入cookies JS */
    if (Domain)[self.configuration.userContentController addUserScript:[self searchCookieForUserScriptWithDomain:Domain]];
    /** 插入cookies PHP */
    if (Domain)[request setValue:[self phpCookieStringWithDomain:Domain] forHTTPHeaderField:@"Cookie"];
    [self.webView loadRequest:request];
}
#pragma mark - public
-(BOOL)canGoBack{
    return _webView.canGoBack;
}
-(BOOL)canGoForward{
    return _webView.canGoForward;
}
-(void)goBack{
    [_webView goBack];
}
-(void)goForward{
    [_webView goForward];
}
-(void)refresh{
    [_webView reload];
}
-(void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id _Nullable, NSError * _Nullable))completionHandler{
    [_webView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}
-(void)setCookie:(NSHTTPCookie *)cookie{
    @autoreleasepool {
        if (@available(iOS 11.0, *)) {
            WKHTTPCookieStore *cookieStore = self.configuration.websiteDataStore.httpCookieStore;
            [cookieStore setCookie:cookie completionHandler:nil];
        }
        
        NSHTTPCookieStorage * shareCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        [shareCookie setCookie:cookie];
        
        NSMutableArray *TempCookies = [NSMutableArray array];
        NSMutableArray *localCookies =[NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: CCWKCookies]];
        for (int i = 0; i < localCookies.count; i++) {
            NSHTTPCookie *TempCookie = [localCookies objectAtIndex:i];
            if ([cookie.name isEqualToString:TempCookie.name] &&
                [cookie.domain isEqualToString:TempCookie.domain]) {
                [localCookies removeObject:TempCookie];
                i--;
                break;
            }
        }
        [TempCookies addObjectsFromArray:localCookies];
        [TempCookies addObject:cookie];
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: TempCookies];
        [[NSUserDefaults standardUserDefaults] setObject:cookiesData forKey:CCWKCookies];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(NSMutableArray *)WKSharedHTTPCookieStorage{
    @autoreleasepool {
        NSMutableArray *cookiesArr = [NSMutableArray array];
        /** 获取NSHTTPCookieStorage cookies  WKHTTPCookieStore 的cookie 已经同步*/
        NSHTTPCookieStorage * shareCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in shareCookie.cookies){
            [cookiesArr addObject:cookie];
        }
        
        /** 获取自定义存储的cookies */
        NSMutableArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: CCWKCookies]];
        
        //删除过期的cookies
        for (int i = 0; i < cookies.count; i++) {
            NSHTTPCookie *cookie = [cookies objectAtIndex:i];
            if (!cookie.expiresDate) {
                [cookiesArr addObject:cookie]; //当cookie布设置国旗时间时，视cookie的有效期为长期有效。
                continue;
            }
            if ([cookie.expiresDate compare:[self currentTime]]) {
                [cookiesArr addObject:cookie];
            }else
            {
                [cookies removeObject:cookie]; //清除过期的cookie。
                i--;
            }
        }
        
        //存储最新有效的cookies
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: cookies];
        [[NSUserDefaults standardUserDefaults] setObject:cookiesData forKey:CCWKCookies];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return cookiesArr;
    }
}
-(void)deleteWKCookie:(NSHTTPCookie *)cookie completionHandler:(void (^)(void))completionHandler{
    if (@available(iOS 11.0, *)) {
        //删除WKHTTPCookieStore中的cookies
        WKHTTPCookieStore *cookieStore = self.configuration.websiteDataStore.httpCookieStore;
        [cookieStore deleteCookie:cookie completionHandler:nil];
    }
    
    //删除NSHTTPCookieStorage中的cookie
    NSHTTPCookieStorage *NSCookiesStore = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [NSCookiesStore deleteCookie:cookie];
    
    //删除磁盘中的cookie
    NSMutableArray *localCookies =[NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: CCWKCookies]];
    for (int i = 0; i < localCookies.count; i++) {
        NSHTTPCookie *TempCookie = [localCookies objectAtIndex:i];
        if ([cookie.domain isEqualToString:TempCookie.domain] &&
            [cookie.domain isEqualToString:TempCookie.domain] ) {
            [localCookies removeObject:TempCookie];
            i--;
            break;
        }
    }
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: localCookies];
    [[NSUserDefaults standardUserDefaults] setObject:cookiesData forKey:CCWKCookies];
    [[NSUserDefaults standardUserDefaults] synchronize];
    completionHandler ? completionHandler() : NULL;
}
-(void)deleteWKCookiesByHost:(NSURL *)host completionHandler:(void (^)(void))completionHandler{
    if (@available(iOS 11.0, *)) {
        //删除WKHTTPCookieStore中的cookies
        WKHTTPCookieStore *cookieStore = self.configuration.websiteDataStore.httpCookieStore;
        [cookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * cookies) {
            
            NSArray *WKCookies = cookies;
            for (NSHTTPCookie *cookie in WKCookies) {
                
                NSURL *domainURL = [NSURL URLWithString:cookie.domain];
                if ([domainURL.host isEqualToString:host.host]) {
                    [cookieStore deleteCookie:cookie completionHandler:nil];
                }
            }
        }];
    }
    
    //删除NSHTTPCookieStorage中的cookies
    NSHTTPCookieStorage *NSCookiesStore = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *NSCookies = NSCookiesStore.cookies;
    for (NSHTTPCookie *cookie in NSCookies) {
        
        NSURL *domainURL = [NSURL URLWithString:cookie.domain];
        if ([domainURL.host isEqualToString:host.host]) {
            [NSCookiesStore deleteCookie:cookie];
        }
    }
    
    //删除磁盘中的cookies
    NSMutableArray *localCookies =[NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: CCWKCookies]];
    for (int i = 0; i < localCookies.count; i++) {
        
        NSHTTPCookie *TempCookie = [localCookies objectAtIndex:i];
        NSURL *domainURL = [NSURL URLWithString:TempCookie.domain];
        if ([host.host isEqualToString:domainURL.host]) {
            [localCookies removeObject:TempCookie];
            i--;
            break;
        }
    }
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: localCookies];
    [[NSUserDefaults standardUserDefaults] setObject:cookiesData forKey:CCWKCookies];
    [[NSUserDefaults standardUserDefaults] synchronize];
    completionHandler ? completionHandler() : NULL;
}
/** js获取domain的cookie */
- (NSString *)jsCookieStringWithDomain:(NSString *)domain
{
    @autoreleasepool {
        NSMutableString *cookieSting = [NSMutableString string];
        NSArray *cookieArr = [self WKSharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookieArr) {
            if ([cookie.domain containsString:domain]) {
                [cookieSting appendString:[NSString stringWithFormat:@"document.cookie = '%@=%@';",cookie.name,cookie.value]];
            }
        }
        return cookieSting;
    }
}
- (WKUserScript *)searchCookieForUserScriptWithDomain:(NSString *)domain
{
    NSString *cookie = [self jsCookieStringWithDomain:domain];
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: cookie injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    return cookieScript;
}
/** PHP 获取domain的cookie */
- (NSString *)phpCookieStringWithDomain:(NSString *)domain
{
    @autoreleasepool {
        NSMutableString *cookieSting =[NSMutableString string];
        NSArray *cookieArr = [self WKSharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookieArr) {
            if ([cookie.domain containsString:domain]) {
                [cookieSting appendString:[NSString stringWithFormat:@"%@ = %@;",cookie.name,cookie.value]];
            }
        }
        if (cookieSting.length > 1)[cookieSting deleteCharactersInRange:NSMakeRange(cookieSting.length - 1, 1)];
        
        return (NSString *)cookieSting;
    }
}
-(void)clearWKCookies{
    if (@available(iOS 11.0, *)) {
        NSSet *websiteDataTypes = [NSSet setWithObject:WKWebsiteDataTypeCookies];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    }
    
    //删除NSHTTPCookieStorage中的cookies
    NSHTTPCookieStorage *NSCookiesStore = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [NSCookiesStore removeCookiesSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: @[]];
    [[NSUserDefaults standardUserDefaults] setObject:cookiesData forKey:CCWKCookies];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - delegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (_delegate && [_delegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [_delegate webView:webView didStartProvisionalNavigation:navigation];
    }
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
    if (_delegate && [_delegate respondsToSelector:@selector(webView:didFailProvisionalNavigation:withError:)]) {
        [_delegate webView:webView didFailProvisionalNavigation:navigation withError:error];
    }
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (_delegate && [_delegate respondsToSelector:@selector(webView:didCommitNavigation:)]) {
        [_delegate webView:webView didCommitNavigation:navigation];
    }
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (_delegate && [_delegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [_delegate webView:webView didFinishNavigation:navigation];
    }
}
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
    
    if (_delegate && [_delegate respondsToSelector:@selector(webView:didFailNavigation:withError:)]) {
        [_delegate webView:webView didFailNavigation:navigation withError:error];
    }
}
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    if (_delegate && [_delegate respondsToSelector:@selector(webView:didReceiveServerRedirectForProvisionalNavigation:)]) {
        [_delegate webView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
    }
}
// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    
    if (_delegate && [_delegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [_delegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    }else{
        //允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //存储cookies
    __weak typeof(self)weakSelf = self;
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    if ([response.URL.scheme.lowercaseString containsString:@"http"]) {
        NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
        if (@available(iOS 11.0, *)) {
            //浏览器自动存储cookie
        }else{
            //存储cookies
            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                @try{
                    //存储cookies
                    for (NSHTTPCookie *cookie in cookies) {
                        [weakSelf setCookie:cookie];
                    }
                }@catch (NSException *e) {
                    NSLog(@"failed: %@", e);
                } @finally {
                    
                }
            });
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
        [_delegate webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
    }else{
        //允许跳转
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}
//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    if (_delegate && [_delegate respondsToSelector:@selector(webViewWebContentProcessDidTerminate:)]) {
        [_delegate webViewWebContentProcessDidTerminate:webView];
    }
}
//若是https，需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if (_delegate && [_delegate respondsToSelector:@selector(webView:didReceiveAuthenticationChallenge:completionHandler:)]) {
        [_delegate webView:webView didReceiveAuthenticationChallenge:challenge completionHandler:completionHandler];
    }
}
//JS调用OC响应
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if (_delegate && [_delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [_delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    if (_delegate && [_delegate respondsToSelector:@selector(webView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [_delegate webView:webView runJavaScriptAlertPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    }
}
#pragma mark - property
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) configuration:_configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}

- (UIProgressView *)progressView
{
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
        _progressView.tintColor = [UIColor cyanColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}
-(void)setProgressTintColor:(UIColor *)progressTintColor{
    _progressTintColor = progressTintColor;
    self.progressView.tintColor = progressTintColor;
}
-(void)setProgressTrackTintColor:(UIColor *)progressTrackTintColor{
    _progressTrackTintColor = progressTrackTintColor;
    self.progressView.trackTintColor = progressTrackTintColor;
}
- (NSDate *)currentTime{
    return [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark - extention

@end
