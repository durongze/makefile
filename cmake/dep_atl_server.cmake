if(NOT TARGET ATL_Server)
  set(LIBNAME ATL_Server)
  set(${LIBNAME}_DIR ${CMAKE_CURRENT_LIST_DIR}/../thirdparty/${LIBNAME})
  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
  endif()
  add_subdirectory(${${LIBNAME}_DIR}/)
endif()

include_directories(${${LIBNAME}_DIR}/include ${${LIBNAME}_DIR}/ ${CMAKE_BINARY_DIR}/thirdparty/${LIBNAME})

set(ATL_SERVER_LIBRARY   $<TARGET_OBJECTS:clstencil>   $<TARGET_OBJECTS:sproxy>   $<TARGET_OBJECTS:vcdeploy>)
set(ATL_SERVER_LIBRARIES $<TARGET_OBJECTS:clstencil>   $<TARGET_OBJECTS:sproxy>   $<TARGET_OBJECTS:vcdeploy>)
