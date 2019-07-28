include(FetchContent)

FetchContent_Declare(marlin
                     GIT_REPOSITORY https://github.com/marlin-lang/marlin.git
                     GIT_TAG 22de5454a4fed0422913f983768b48bbd00564be)

FetchContent_GetProperties(marlin)
if(NOT marlin_POPULATED)
  message("-- Populating marlin")
  FetchContent_Populate(marlin)
  add_subdirectory(${marlin_SOURCE_DIR} ${marlin_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()
