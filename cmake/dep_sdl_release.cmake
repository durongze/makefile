# sdl library

set(TOP_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

if (NOT TARGET SDL2)
  MESSAGE("add sdl_master")
  set(LIBNAME SDL-release)
  set(${LIBNAME}_DIR thirdparty/${LIBNAME}-2.24.0)
  set(${LIBNAME}_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../${${LIBNAME}_DIR})
  set(${LIBNAME}_BIN_DIR ${CMAKE_BINARY_DIR}/${${LIBNAME}_DIR})

  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
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

set(sdl_LIBRARY $<TARGET_OBJECTS:SDL2> $<TARGET_OBJECTS:SDL2main>)