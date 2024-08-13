
if(NOT TARGET mbedtls)
  set(LIBNAME mbedtls)
  set(${LIBNAME}_DIR thirdparty/${LIBNAME}-2.28)
  set(${LIBNAME}_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../${${LIBNAME}_DIR})
  set(${LIBNAME}_BIN_DIR ${CMAKE_BINARY_DIR}/${${LIBNAME}_DIR})

  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_definitions(-DDYZ)
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

set(MBEDTLS_LIBRARY $<TARGET_OBJECTS:mbedtls>)
set(MBEDTLS_LIBRARIES $<TARGET_OBJECTS:mbedtls>)