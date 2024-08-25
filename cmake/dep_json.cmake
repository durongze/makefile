# json library

if (NOT TARGET json)
  MESSAGE("json test")
  MESSAGE(${CMAKE_CURRENT_LIST_DIR})
  MESSAGE(${CMAKE_BINARY_DIR})
  
  set(JSONCPP_WITH_TESTS OFF CACHE BOOL "Disable glog test")
  add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/../thirdparty/json ${CMAKE_BINARY_DIR}/thirdparty/json)
endif()

include_directories(${CMAKE_CURRENT_LIST_DIR}/../third_party/json/include)

set(JSON_LIBRARY json)
