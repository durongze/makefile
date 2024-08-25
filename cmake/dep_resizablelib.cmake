if(NOT TARGET ResizableLib)
  set(LIBNAME ResizableLib)
  set(${LIBNAME}_DIR ${CMAKE_CURRENT_LIST_DIR}/../thirdparty/${LIBNAME})
  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
  endif()
  add_subdirectory(${${LIBNAME}_DIR}/)
endif()

include_directories(${${LIBNAME}_DIR}/include ${${LIBNAME}_DIR}/ ${CMAKE_BINARY_DIR}/thirdparty/${LIBNAME})

set(ResizableLib_LIBRARY   $<TARGET_OBJECTS:ResizableLib>)
set(ResizableLib_LIBRARIES $<TARGET_OBJECTS:ResizableLib>)
