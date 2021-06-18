// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/**
 * Interface for receiving status updates from the OfflineSwitch.
 *
 */
NS_SWIFT_NAME(OfflineSwitchObserver)
@protocol MBXOfflineSwitchObserver
/**
 * Notify of a status change of the OfflineSwitch.
 * @param connected Currently connected.
 */
- (void)statusChangedForConnected:(BOOL)connected;
@end
