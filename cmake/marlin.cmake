include(FetchContent)

FetchContent_Declare(marlin
                     GIT_REPOSITORY https://github.com/marlin-lang/marlin.git
                     GIT_TAG 0142976783725b87c07909bfb7308bdf6c70a2ff)

FetchContent_GetProperties(marlin)
if(NOT marlin_POPULATED)
  message("-- Populating marlin")
  FetchContent_Populate(marlin)
  add_subdirectory(${marlin_SOURCE_DIR} ${marlin_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()
