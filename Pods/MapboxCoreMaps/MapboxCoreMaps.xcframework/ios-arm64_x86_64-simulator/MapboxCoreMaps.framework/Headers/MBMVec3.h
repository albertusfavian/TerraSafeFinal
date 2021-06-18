// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** @brief 3 component vector */
NS_SWIFT_NAME(Vec3)
__attribute__((visibility ("default")))
@interface MBMVec3 : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithX:(double)x
                                y:(double)y
                                z:(double)z;

@property (nonatomic, readonly) double x;
@property (nonatomic, readonly) double y;
@property (nonatomic, readonly) double z;

@end
