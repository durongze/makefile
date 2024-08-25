if(NOT TARGET id3lib)
  set(LIBNAME id3lib)
  set(${LIBNAME}_DIR ${CMAKE_CURRENT_LIST_DIR}/../thirdparty/${LIBNAME})
  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
  endif()
  add_subdirectory(${${LIBNAME}_DIR}/)
endif()

include_directories(${${LIBNAME}_DIR}/include ${${LIBNAME}_DIR}/ ${CMAKE_BINARY_DIR}/thirdparty/${LIBNAME})

set(ID3LIB_LIBRARY   $<TARGET_OBJECTS:id3lib>)
set(ID3LIB_LIBRARIES $<TARGET_OBJECTS:id3lib>)
