if(NOT TARGET crypto)
  set(LIBNAME crypto)
  set(${LIBNAME}_DIR ${CMAKE_CURRENT_LIST_DIR}/../thirdparty/${LIBNAME})
  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
  endif()
  add_subdirectory(${${LIBNAME}_DIR}/)
endif()

set (CRYPTO_INCS ${${LIBNAME}_DIR}/include ${${LIBNAME}_DIR}/ ${CMAKE_BINARY_DIR}/thirdparty/${LIBNAME})

set(CRYPTO_LIBRARY   $<TARGET_OBJECTS:cryptlib>)
set(CRYPTO_LIBRARIES $<TARGET_OBJECTS:cryptlib>)
