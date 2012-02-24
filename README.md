# Restful Metrics Objective-C Client

Tracks your app's custom business metrics in your Objective-c apps.

For more detailed instructions, check out our [Dev Center](http://devcenter.restful-labs.com/metrics/objc_initialize).

## Install

The API code is completely isolated to RestfulMetrics.h and RestfulMetrics.m.
You can either reference this project from yours to link it, or embed those
files straight into your project.

## Example

Within this repository there is a project in RestfulMetricsExample which uses
the API in a simple demo app.

## Using the library

``` objective-c
    #include <RestfulMetrics.h>

    - (void) sendSingleMetric
    {
        RestfulMetrics *rm = [[RestfulMetrics alloc] initWithAppName:@"my-great-app" apiKey:@"1234567..."];

        // Send a data point.
        [rm addMetric:@"example_event1"];

        // Send a data point with a distinct identifier.
        [rm addMetric:@"example_event2" identifier:@"session-2"];

        // Send a data point with a count.
        [rm addMetric:@"example_event3" count:17];

        // Send a data point with a count and identifier.
        [rm addMetric:@"example_event4" count:34 identifier:@"session-4"];

        // Send a compound data point.
        [rm addCompoundMetric:@"example_event5" value:@"apple"];

        // Send a compound data point with multiple values.
        NSArray *values6 = [NSArray arrayWithObjects:@"apple", @"orange", nil];
        [rm addCompoundMetric:@"example_event6" values:values6];

        // Send a compound data point with a distinct identifier.
        [rm addCompoundMetric:@"example_event7" value:@"apple" identifier:@"session-7"];

        // Send a compound data point with multiple values and an identifier.
        NSArray *values8 = [NSArray arrayWithObjects:@"apple", @"orange", nil];
        [rm addCompoundMetric:@"example_event8" values:values8 identifier:@"session-8"];
    }
```

## Copyright

Copyright (c) 2012 Restful Labs LLC. See LICENSE for details.

## Authors

* [Alex McHale](http://github.com/alexmchale)
