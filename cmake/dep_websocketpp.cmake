if(NOT TARGET websocketpp)
  set(LIBNAME websocketpp)
  set(${LIBNAME}_DIR thirdparty/${LIBNAME})
  set(${LIBNAME}_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../${${LIBNAME}_DIR})
  set(${LIBNAME}_BIN_DIR ${CMAKE_BINARY_DIR}/${${LIBNAME}_DIR})

  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_definitions(-DDYZ_DBG)
  elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
    add_definitions(-DBUILD_TESTS=OFF)
    add_definitions(-DBUILD_EXAMPLES=OFF)
  endif()
  add_subdirectory(${${LIBNAME}_SRC_DIR}/)
endif()

include_directories(${${LIBNAME}_SRC_DIR})
include_directories(${${LIBNAME}_SRC_DIR}/include)
include_directories(${${LIBNAME}_BIN_DIR})
include_directories(${${LIBNAME}_BIN_DIR}/include)


link_directories(${${LIBNAME}_BIN_DIR})
link_directories(${${LIBNAME}_BIN_DIR}/lib)
link_directories(${${LIBNAME}_BIN_DIR}/Debug)

set(WEBSOCKETPP_LIBRARY $<TARGET_OBJECTS:websocketpp>)
set(WEBSOCKETPP_LIBRARIES $<TARGET_OBJECTS:websocketpp>)