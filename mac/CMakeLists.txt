set(HEADERS AppDelegate.h Document.h SourceLineItem.h SourceViewController.h)

set(SOURCES
    AppDelegate.mm
    Document.mm
    main.mm
    SourceLineItem.mm
    SourceViewController.mm)

set(RESOURCES
    Info.plist
    marlin.entitlements
    Assets.xcassets
    Base.lproj/Main.storyboard
    SourceLineItem.xib)

add_executable(${APP_NAME} MACOSX_BUNDLE ${HEADERS} ${SOURCES} ${RESOURCES})

set_target_properties(${APP_NAME} PROPERTIES RESOURCE "${RESOURCES}")

set_target_properties(${APP_NAME}
                      PROPERTIES MACOSX_BUNDLE_INFO_PLIST
                                 "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist")

target_link_libraries(${APP_NAME} "-framework AppKit")
