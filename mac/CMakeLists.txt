set(HEADERS
    AppDelegate.h
    Document.h
    SourceViewController.h)

set(SOURCES
    AppDelegate.mm
    Document.mm
    main.mm
    SourceViewController.mm)

set(RESOURCES
    Info.plist
    marlin.entitlements
    Assets.xcassets
    Base.lproj/Main.storyboard)

add_executable(${PROJECT_NAME}.mac MACOSX_BUNDLE ${HEADERS} ${SOURCES} ${RESOURCES})

set_target_properties(${PROJECT_NAME}.mac
                      PROPERTIES OUTPUT_NAME marlin MACOSX_BUNDLE_INFO_PLIST
                                 "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist"
                                 RESOURCE
                                 "${RESOURCES}")

target_link_libraries(${PROJECT_NAME}.mac "-framework AppKit" ${PROJECT_NAME}.core)
