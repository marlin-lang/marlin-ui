include(FetchContent)

FetchContent_Declare(marlin
                     GIT_REPOSITORY https://github.com/marlin-lang/marlin.git
                     GIT_TAG 3e4af4d7914c65dab160c86db0f8403201b7f258)

FetchContent_GetProperties(marlin)
if(NOT marlin_POPULATED)
  message("-- Populating marlin")
  FetchContent_Populate(marlin)
  add_subdirectory(${marlin_SOURCE_DIR} ${marlin_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()
