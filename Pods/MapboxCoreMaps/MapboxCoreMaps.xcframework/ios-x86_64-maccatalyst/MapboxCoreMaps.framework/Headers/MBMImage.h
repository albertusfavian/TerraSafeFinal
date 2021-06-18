// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** @brief Image type */
NS_SWIFT_NAME(Image)
__attribute__((visibility ("default")))
@interface MBMImage : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithWidth:(uint32_t)width
                               height:(uint32_t)height
                                 data:(nonnull NSData *)data;

/** @brief width of the image, in screen pixels. */
@property (nonatomic, readonly) uint32_t width;

/** @brief height of the image, in screen pixels. */
@property (nonatomic, readonly) uint32_t height;

/**
 * 32-bit premultiplied RGBA image data.
 *
 * Uncompressed image data encoded in 32-bit RGBA format with premultiplied
 * alpha. This field should contain exactly 4 * width * height bytes. It
 * should consist of a sequence of scanlines.
 */
@property (nonatomic, readonly, nonnull) NSData *data;


@end
