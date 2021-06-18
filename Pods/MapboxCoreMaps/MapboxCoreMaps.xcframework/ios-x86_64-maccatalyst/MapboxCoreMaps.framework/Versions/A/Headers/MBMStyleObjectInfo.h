// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** @brief information about style object (source or layer) */
NS_SWIFT_NAME(StyleObjectInfo)
__attribute__((visibility ("default")))
@interface MBMStyleObjectInfo : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithId:(nonnull NSString *)id
                              type:(nonnull NSString *)type;

/** @brief object's id */
@property (nonatomic, readonly, nonnull, copy) NSString *id;

/** @brief object's type */
@property (nonatomic, readonly, nonnull, copy) NSString *type;


@end
