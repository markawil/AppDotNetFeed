//
//  NumberComparisonOperation.h
//  NSUnit
//
//  Created by Jackson Harper on 8/5/12.
//  Copyright (c) 2012 Jackson Harper. All rights reserved.
//  Copyright (c) 2012 Benjamin van der Veen. All rights reserved
//

#import <Foundation/Foundation.h>
#import "BlockOperation.h"


@interface NumberComparisonOperation : BlockOperation {
    
    NSArray *_allowed;
}

- (id) initWithRValue:(NSObject *)rvalue andAllowedComparisonValues:(NSArray *) allowed;


@end
