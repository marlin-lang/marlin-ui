cmake_minimum_required(VERSION 3.12)

project(marlin-ui
        VERSION 0.1 DESCRIPTION "The marlin language ui"
        LANGUAGES CXX)

set(APP_NAME "marlin")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(marlin)

add_subdirectory(mac)
add_subdirectory(src)
