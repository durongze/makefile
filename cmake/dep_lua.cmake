if(NOT TARGET lua)
  set(LIBNAME lua)
  set(${LIBNAME}_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../thirdparty/${LIBNAME})
  set(${LIBNAME}_BIN_DIR ${CMAKE_BINARY_DIR}/thirdparty/${LIBNAME})
  message("${LIBNAME}_SRC_DIR:${${LIBNAME}_SRC_DIR}")
  message("${LIBNAME}_BIN_DIR:${${LIBNAME}_BIN_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
  endif()
  add_subdirectory(${${LIBNAME}_SRC_DIR}/)
endif()

include_directories(${${LIBNAME}_SRC_DIR}/include ${${LIBNAME}_SRC_DIR}/src ${${LIBNAME}_SRC_DIR}/ ${${LIBNAME}_BIN_DIR}/)

set(LUA_LIBRARY lua)

set(LUA_LIBRARIES $<TARGET_OBJECTS:lua_static>)
