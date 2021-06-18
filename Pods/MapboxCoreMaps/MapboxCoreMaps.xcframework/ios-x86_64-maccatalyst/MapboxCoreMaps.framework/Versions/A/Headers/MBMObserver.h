// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

@class MBMEvent;

/** @brief Observer interface used to subscribe for an Observable events. */
NS_SWIFT_NAME(Observer)
@protocol MBMObserver
/**
 * @brief Notifies an Observer about an Event.
 *
 * @param event an Event
 */
- (void)notifyForEvent:(nonnull MBMEvent *)event;
@end
