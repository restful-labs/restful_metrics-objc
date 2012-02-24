#import "RestfulMetrics.h"

@implementation RestfulMetrics

@synthesize appName, apiKey, metricUrl, compoundUrl;



#pragma mark Initialization

- (id) initWithAppName:(NSString *)myAppName apiKey:(NSString *)myApiKey
{
    NSString *format, *url;
    
    if (self = [self init]) {
        self.appName = myAppName;
        self.apiKey = myApiKey;
        
        format = @"http://track.restfulmetrics.com/apps/%@/metrics.json";
        url = [NSString stringWithFormat:format, myAppName];
        self.metricUrl = [NSURL URLWithString:url];
        
        format = @"http://track.restfulmetrics.com/apps/%@/compound_metrics.json";
        url = [NSString stringWithFormat:format, myAppName];
        self.compoundUrl = [NSURL URLWithString:url];
    }
    
    return self;
}



#pragma mark Storing Metric Data Points

- (BOOL) addMetric:(NSString *)name
{
    return [self addMetric:name count:1];
}

- (BOOL)addMetric:(NSString *)name identifier:(NSString *)identifier
{
    return [self addMetric:name count:1 identifier:identifier];
}

- (BOOL) addMetric:(NSString *)name count:(NSInteger)count
{
    return [self addMetric:name count:count identifier:nil];
}

- (BOOL) addMetric:(NSString *)name count:(NSInteger)count identifier:(NSString *)identifier
{
    NSMutableURLRequest *request =
        [[NSMutableURLRequest alloc]
             initWithURL:self.metricUrl];
    
    NSDictionary *metric =
        [NSDictionary dictionaryWithObjectsAndKeys:        
             name, @"name",
             [NSNumber numberWithInt:count], @"value",
             identifier, @"distinct_id",
             nil];
    
    NSDictionary *bodyDict =
        [NSDictionary
             dictionaryWithObject:metric
             forKey:@"metric"];
    
    NSString *bodyString =
        [self objectToJson:bodyDict];
    
    NSData *bodyData =
        [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:bodyData];
    [request setHTTPMethod:@"POST"];
    [request setValue:self.apiKey forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *connection =
        [NSURLConnection
             connectionWithRequest:request
             delegate:self];
    
    return connection != nil;
}



#pragma mark Storing Compound Metric Data Points

- (BOOL)addCompoundMetric:(NSString *)name value:(NSString *)value
{
    return [self addCompoundMetric:name values:[NSArray arrayWithObject:value]];
}

- (BOOL) addCompoundMetric:(NSString *)name values:(NSArray *)values
{
    return [self addCompoundMetric:name values:values identifier:nil];
}

- (BOOL)addCompoundMetric:(NSString *)name value:(NSString *)value identifier:(NSString *)identifier
{
    return [self addCompoundMetric:name values:[NSArray arrayWithObject:value] identifier:identifier];
}

- (BOOL)addCompoundMetric:(NSString *)name values:(NSArray *)values identifier:(NSString *)identifier
{
    NSMutableURLRequest *request =
        [[NSMutableURLRequest alloc]
             initWithURL:self.compoundUrl];
    
    NSDictionary *metric =
        [NSDictionary dictionaryWithObjectsAndKeys:        
             name, @"name",
             values, @"values",
             identifier, @"distinct_id",
             nil];
    
    NSDictionary *bodyDict =
        [NSDictionary
             dictionaryWithObject:metric
             forKey:@"compound_metric"];
    
    NSString *bodyString =
        [self objectToJson:bodyDict];
    
    NSData *bodyData =
        [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:bodyData];
    [request setHTTPMethod:@"POST"];
    [request setValue:self.apiKey forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *connection =
        [NSURLConnection
             connectionWithRequest:request
             delegate:self];
    
    return connection != nil;    
}



#pragma mark NSURLConnection Delegate Methods

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Connection failed.
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Connection succeeded.
}



#pragma mark Private Methods

- (NSString *) objectToJson:(id)obj
{
    if ([obj isKindOfClass:[NSString class]]) return [self stringToJson:obj];
    if ([obj isKindOfClass:[NSArray class]]) return [self arrayToJson:obj];
    if ([obj isKindOfClass:[NSDictionary class]]) return [self dictionaryToJson:obj];
    if ([obj isKindOfClass:[NSNumber class]]) return [(NSNumber *)obj stringValue];
    return nil;
}

- (NSString *) stringToJson:(NSString *)string
{
    NSString *encodedString;
    encodedString = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    encodedString = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    return [NSString stringWithFormat:@"\"%@\"", encodedString];
}

- (NSString *) arrayToJson:(NSArray *)array
{
    NSMutableArray *encodedArray = [NSMutableArray array];
    
    for (id e in array) {        
        [encodedArray addObject:[self objectToJson:e]];
    }
    
    NSString *joinedArray = [encodedArray componentsJoinedByString:@", "];
    
    return [NSString stringWithFormat:@"[%@]", joinedArray];
}

- (NSString *) dictionaryToJson:(NSDictionary *)dict
{
    NSMutableArray *encodedArray = [NSMutableArray array];
    
    for (id key in dict) {
        NSString *encodedKey = [self objectToJson:key];
        NSString *encodedValue = [self objectToJson:[dict objectForKey:key]];
        NSString *encodedPair = [NSString stringWithFormat:@"%@: %@", encodedKey, encodedValue];
        [encodedArray addObject:encodedPair];
    }
    
    NSString *joinedArray = [encodedArray componentsJoinedByString:@", "];
    
    return [NSString stringWithFormat:@"{%@}", joinedArray];
}



@end
