set(HEADERS AppDelegate.h Document.h ViewController.h)

set(SOURCES AppDelegate.mm Document.mm main.mm ViewController.mm)

set(RESOURCES
    Assets.xcassets
    Base.lproj/Main.storyboard
    Info.plist
    marlin.entitlements)

add_executable(${APP_NAME} MACOSX_BUNDLE ${HEADERS} ${SOURCES} ${RESOURCES})

set_target_properties(${APP_NAME} PROPERTIES RESOURCE "${RESOURCES}")

set_target_properties(${APP_NAME}
                      PROPERTIES MACOSX_BUNDLE_INFO_PLIST
                                 "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist")

target_link_libraries(${APP_NAME} "-framework AppKit")
