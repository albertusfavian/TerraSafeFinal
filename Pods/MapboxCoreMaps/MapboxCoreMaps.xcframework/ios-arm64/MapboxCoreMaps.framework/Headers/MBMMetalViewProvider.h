#import <Foundation/Foundation.h>
#import <MetalKit/MTKView.h>
#import <Metal/MTLTexture.h>

@protocol MBMMetalViewProvider

@optional

- (MTKView *_Nullable)getMetalViewFor:(nullable id<MTLDevice>)metalDevice;

@optional

- (nullable id<MTLTexture>)getDrawableTexture;

@end

