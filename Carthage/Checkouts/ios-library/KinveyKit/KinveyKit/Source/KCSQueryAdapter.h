//
//  KCSQueryAdapter.h
//  Kinvey
//
//  Created by Victor Barros on 2015-12-17.
//  Copyright © 2015 Kinvey. All rights reserved.
//

@import Foundation;

#import "KCSQueryProtocol.h"

@interface KCSQueryAdapter : NSObject <KCSQuery>

-(instancetype)initWithQuery:(id)query;

@end
