# tinyxml2 library

if(NOT TARGET tinyxml2 )
  set(LIBNAME tinyxml2 )
  set(${LIBNAME}_DIR ${CMAKE_CURRENT_LIST_DIR}/../thirdparty/${LIBNAME})
  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
  endif()
  add_subdirectory(${${LIBNAME}_DIR}/)
endif()

include_directories(${${LIBNAME}_DIR}/include ${${LIBNAME}_DIR}/ ${CMAKE_BINARY_DIR}/thirdparty/${LIBNAME})

set(TinyXml2_LIBRARY   $<TARGET_OBJECTS:tinyxml2>)
set(TinyXml2_LIBRARIES $<TARGET_OBJECTS:tinyxml2>)
