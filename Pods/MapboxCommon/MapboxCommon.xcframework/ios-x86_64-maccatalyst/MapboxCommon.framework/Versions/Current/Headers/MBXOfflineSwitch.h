// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

@protocol MBXOfflineSwitchObserver;

/** Instance that allows connecting or disconnecting the Mapbox stack to the network. */
NS_SWIFT_NAME(OfflineSwitch)
__attribute__((visibility ("default")))
@interface MBXOfflineSwitch : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/**
 * Connects or disconnects the Mapbox stack. If set to false, current and new HTTP requests will fail
 * with HttpRequestErrorType#ConnectionError.
 *
 * @param connected Set false to disconnect the Mapbox stack
 */
- (void)setMapboxStackConnectedForConnected:(BOOL)connected;
/**
 * Provides information if the Mapbox stack is connected or disconnected via OfflineSwitch.
 *
 * @return True if the Mapbox stack is disconnected via setMapboxStackConnected(), false otherwise.
 */
- (BOOL)isMapboxStackConnected;
/** Returns the OfflineSwitch singleton instance. */
+ (nonnull MBXOfflineSwitch *)getInstance __attribute((ns_returns_retained));

@end
