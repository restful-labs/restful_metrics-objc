#import <Foundation/Foundation.h>

@interface RestfulMetrics : NSObject <NSURLConnectionDelegate>

@property (strong) NSString *appName;
@property (strong) NSString *apiKey;
@property (strong) NSURL *metricUrl;
@property (strong) NSURL *compoundUrl;
@property (strong) NSMutableDictionary *connections;

- (id) initWithAppName:(NSString *)appName apiKey:(NSString *)apiKey;

- (BOOL) addMetric:(NSString *)name;
- (BOOL) addMetric:(NSString *)name identifier:(NSString *)identifier;
- (BOOL) addMetric:(NSString *)name count:(NSInteger )count;
- (BOOL) addMetric:(NSString *)name count:(NSInteger )count identifier:(NSString *)identifier;

- (BOOL) addCompoundMetric:(NSString *)name value:(NSString *)value;
- (BOOL) addCompoundMetric:(NSString *)name values:(NSArray *)values;
- (BOOL) addCompoundMetric:(NSString *)name value:(NSString *)value identifier:(NSString *)identifier;
- (BOOL) addCompoundMetric:(NSString *)name values:(NSArray *)values identifier:(NSString *)identifier;

@end
