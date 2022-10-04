# pthread-win32 library

set(TOP_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

if (NOT TARGET pthreadvc2_static)
  MESSAGE("add pthread-win32")
  set(LIBNAME pthread-win32)
  set(${LIBNAME}_DIR thirdparty/${LIBNAME})
  set(${LIBNAME}_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../${${LIBNAME}_DIR})
  set(${LIBNAME}_BIN_DIR ${CMAKE_BINARY_DIR}/${${LIBNAME}_DIR})

  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
  endif()
  add_subdirectory(${${LIBNAME}_SRC_DIR}/)
endif()

include_directories(${${LIBNAME}_SRC_DIR})
include_directories(${${LIBNAME}_SRC_DIR}/inc)
include_directories(${${LIBNAME}_SRC_DIR}/include)
include_directories(${${LIBNAME}_BIN_DIR})
include_directories(${${LIBNAME}_BIN_DIR}/inc)
include_directories(${${LIBNAME}_BIN_DIR}/include)


link_directories(${${LIBNAME}_BIN_DIR})
link_directories(${${LIBNAME}_BIN_DIR}/lib)
link_directories(${${LIBNAME}_BIN_DIR}/Debug)

set(pthreadvc2_LIBRARY $<TARGET_OBJECTS:pthreadvc2_static>)