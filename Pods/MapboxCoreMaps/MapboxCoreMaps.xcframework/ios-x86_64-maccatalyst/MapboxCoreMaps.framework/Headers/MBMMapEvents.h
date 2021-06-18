// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/**
 * @brief List of supported event types by the Map and MapSnapshotter objects,
 * and event data format specification for each event.
 *
 * Simplified diagram for events emitted by the Map object.
 *
 * ┌─────────────┐               ┌─────────┐                   ┌──────────────┐
 * │ Application │               │   Map   │                   │ResourceLoader│
 * └──────┬──────┘               └────┬────┘                   └───────┬──────┘
 *        │                           │                                │
 *        ├───────setStyleURI────────▶│                                │
 *        │                           ├───────────get style───────────▶│
 *        │                           │                                │
 *        │                           │◀─────────style data────────────┤
 *        │                           │                                │
 *        │                           ├─parse style─┐                  │
 *        │                           │             │                  │
 *        │      StyleDataLoaded      ◀─────────────┘                  │
 *        │◀────{"type": "style"}─────┤                                │
 *        │                           ├─────────get sprite────────────▶│
 *        │                           │                                │
 *        │                           │◀────────sprite data────────────┤
 *        │                           │                                │
 *        │                           ├──────parse sprite───────┐      │
 *        │                           │                         │      │
 *        │      StyleDataLoaded      ◀─────────────────────────┘      │
 *        │◀───{"type": "sprite"}─────┤                                │
 *        │                           ├─────get source TileJSON(s)────▶│
 *        │                           │                                │
 *        │     SourceDataLoaded      │◀─────parse TileJSON data───────┤
 *        │◀──{"type": "metadata"}────┤                                │
 *        │                           │                                │
 *        │                           │                                │
 *        │      StyleDataLoaded      │                                │
 *        │◀───{"type": "sources"}────┤                                │
 *        │                           ├──────────get tiles────────────▶│
 *        │                           │                                │
 *        │◀───────StyleLoaded────────┤                                │
 *        │                           │                                │
 *        │     SourceDataLoaded      │◀─────────tile data─────────────┤
 *        │◀────{"type": "tile"}──────┤                                │
 *        │                           │                                │
 *        │                           │                                │
 *        │◀────RenderFrameStarted────┤                                │
 *        │                           ├─────render─────┐               │
 *        │                           │                │               │
 *        │                           ◀────────────────┘               │
 *        │◀───RenderFrameFinished────┤                                │
 *        │                           ├──render, all tiles loaded──┐   │
 *        │                           │                            │   │
 *        │                           ◀────────────────────────────┘   │
 *        │◀────────MapLoaded─────────┤                                │
 *        │                           │                                │
 *        │                           │                                │
 *        │◀─────────MapIdle──────────┤                                │
 *        │                    ┌ ─── ─┴─ ─── ┐                         │
 *        │                    │   offline   │                         │
 *        │                    └ ─── ─┬─ ─── ┘                         │
 *        │                           │                                │
 *        ├─────────setCamera────────▶│                                │
 *        │                           ├───────────get tiles───────────▶│
 *        │                           │                                │
 *        │                           │┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
 *        │◀─────────MapIdle──────────┤   waiting for connectivity  │  │
 *        │                           ││  Map renders cached data      │
 *        │                           │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘  │
 *        │                           │                                │
 *
 */
NS_SWIFT_NAME(MapEvents)
__attribute__((visibility ("default")))
@interface MBMMapEvents : NSObject

    /**
     * @brief The Map's style has been fully loaded, and the Map has rendered all visible tiles.
     *
     * Event data format (Object).
     */
    @property (nonatomic, class, readonly) NSString * MapLoaded;
    /**
     * @brief Describes an error that has occured while loading the Map. The 'type' property defines what resource could
     * not be loaded and the 'message' property will contain a descriptive error message.
     *
     * Event data format (Object):
     * .
     * ├── type - String ("style" | "sprite" | "source" | "tile" | "glyphs")
     * └── message - String
     */
    @property (nonatomic, class, readonly) NSString * MapLoadingError;
    /**
     * @brief The Map has entered the idle state. The Map is in the idle state when there are no ongoing transitions
     * and the Map has rendered all available tiles. The event will not be emitted if Map#setUserAnimationInProgress
     * and / or Map#setGestureInProgress is set to true.
     *
     * Event data format (Object).
     */
    @property (nonatomic, class, readonly) NSString * MapIdle;
    /**
     * @brief The requested style data has been loaded. The 'type' property defines what kind of style data has been loaded.
     * Event may be emitted synchronously, for example, when StyleManager#setStyleJSON is used to load style.
     *
     * Based on an event data 'type' property value, following use-cases may be implemented:
     * - 'style': Style is parsed, style layer properties could be read and modified, style layers and sources could be
     *   added or removed before rendering is started.
     * - 'sprite': Style's sprite sheet is parsed and it is possible to add or update images.
     * - 'sources': All sources defined by the style are loaded and their properties could be read and updated if needed.
     *
     * Event data format (Object):
     * .
     * └── type - String ("style" | "sprite" | "sources")
     */
    @property (nonatomic, class, readonly) NSString * StyleDataLoaded;
    /**
     * @brief The requested style has been fully loaded, including the style, specified sprite and sources' metadata.
     *
     * Event data format (Object).
     */
    @property (nonatomic, class, readonly) NSString * StyleLoaded;
    /**
     * @brief A style has a missing image. This event is emitted when the Map renders visible tiles and
     * one of the required images is missing in the sprite sheet. Subscriber has to provide the missing image
     * by calling StyleManager#addStyleImage method.
     *
     * Event data format (Object):
     * .
     * └── id - String
     */
    @property (nonatomic, class, readonly) NSString * StyleImageMissing;
    /**
     * @brief An image added to the Style is no longer needed and can be removed using StyleManager#removeStyleImage method.
     *
     * Event data format (Object):
     * .
     * └── id - String
     */
    @property (nonatomic, class, readonly) NSString * StyleImageRemoveUnused;
    /**
     * @brief Source data has been loaded.
     * Event may be emitted synchronously in cases when source's metadata is available when source is added to the style.
     *
     * The 'id' property defines the source id.
     *
     * The 'type' property defines if source's metadata (e.g., TileJSON) or tile has been loaded. The property of 'metadata'
     * value might be useful to identify when particular source's metadata is loaded, thus all source's properties are
     * readable and can be updated before map will start requesting data to be rendered.
     *
     * The 'loaded' property will be set to 'true' if all source's data required for Map's visible viewport, are loaded.
     * The 'tile-id' property defines the tile id if the 'type' field equals 'tile'.
     *
     * Event data format (Object):
     * .
     * ├── id - String
     * ├── type - String ("metadata" | "tile")
     * ├── loaded - optional Boolean
     * └── tile-id optional Object
     *     ├── z Number (zoom level)
     *     ├── x Number (x coorinate)
     *     └── y Number (y coorinate)
     */
    @property (nonatomic, class, readonly) NSString * SourceDataLoaded;
    /**
     * @brief Source has been added with StyleManager#addStyleSource runtime API.
     * The event is emitted synchronously, therefore, it is possible to immediately
     * read added source's properties.
     *
     * Event data format (Object):
     * .
     * └── id - String
     */
    @property (nonatomic, class, readonly) NSString * SourceAdded;
    /**
     * @brief Source has been removed with StyleManager#removeStyleSource runtime API.
     * The event is emitted synchronously, thus, StyleManager#getStyleSources will be
     * in sync when the Observer receives notification.
     *
     * Event data format (Object):
     * .
     * └── id - String
     */
    @property (nonatomic, class, readonly) NSString * SourceRemoved;
    /**
     * @brief The Map started rendering a frame.
     *
     * Event data format (Object).
     */
    @property (nonatomic, class, readonly) NSString * RenderFrameStarted;
    /**
     * @brief The Map finished rendering a frame.
     * The 'render-mode' property tells whether the Map has all data ("full") required to render the visible viewport.
     * The 'needs-repaint' property provides information about ongoing transitions that trigger Map repaint.
     * The 'placement-changed' property tells if the symbol placement has been changed in the visible viewport.
     *
     * Event data format (Object):
     * .
     * ├── render-mode - String ("partial" | "full")
     * ├── needs-repaint - Boolean
     * └── placement-changed - Boolean
     */
    @property (nonatomic, class, readonly) NSString * RenderFrameFinished;
    /**
     * @brief Camera has changed. This event is emitted whenever the visible viewport
     * changes due to the invocation of Map#setSize, Map#setBounds methods or when the camera
     * is modified by calling Map camera methods. The event is emitted synchronously,
     * so that an updated camera state can be fetched immediately.
     *
     * Event data format (Object).
     */
    @property (nonatomic, class, readonly) NSString * CameraChanged;
    /**
     * @brief ResourceRequest event allows client to observe resource requests made by a
     * Map or MapSnapshotter objects.
     *
     * Event data format (Object):
     * .
     * ├── data-source - String ("resource-loader" | "network" | "database" | "asset" | "file-system")
     * ├── request - Object
     * │   ├── url - String
     * │   ├── kind - String ("unknown" | "style" | "source" | "tile" | "glyphs" | "sprite-image" | "sprite-json" | "image")
     * │   ├── priority - String ("regular" | "low")
     * │   └── loading-method - Array ["cache" | "network"]
     * ├── response - optional Object
     * │   ├── no-content - Boolean
     * │   ├── not-modified - Boolean
     * │   ├── must-revalidate - Boolean
     * │   ├── source - String ("network" | "cache" | "tile-store" | "local-file")
     * │   ├── size - Number (size in bytes)
     * │   ├── modified - optional String, rfc1123 timestamp
     * │   ├── expires - optional String, rfc1123 timestamp
     * │   ├── etag - optional String
     * │   └── error - optional Object
     * │       ├── reason - String ("success" | "not-found" | "server" | "connection" | "rate-limit" | "other")
     * │       └── message - String
     * └── cancelled - Boolean
     */
    @property (nonatomic, class, readonly) NSString * ResourceRequest;

@end
