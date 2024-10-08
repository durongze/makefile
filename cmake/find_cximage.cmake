if(NOT TARGET cximage)
  set(LIBNAME cximage)
endif()

if("$ENV{HomeDir}" STREQUAL "")
    if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
        set(ALL_LIB_HOME_DIR ${CMAKE_CURRENT_LIST_DIR}/../out/linux)
    elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
        set(ALL_LIB_HOME_DIR ${CMAKE_CURRENT_LIST_DIR}/../out/windows)
        string(REPLACE "/" "\\" ALL_LIB_HOME_DIR "${ALL_LIB_HOME_DIR}")
    else()
        message("current platform: unkonw ") 
    endif()
else()
    set(ALL_LIB_HOME_DIR "$ENV{HomeDir}")
endif()

set(CXIMAGE_ROOT_DIR     ${ALL_LIB_HOME_DIR}/${LIBNAME})
set(CXIMAGE_INCLUDE_DIRS ${CXIMAGE_ROOT_DIR}/include)
set(CXIMAGE_LIBRARY_DIRS ${CXIMAGE_ROOT_DIR}/lib)
set(CXIMAGE_LIBRARY      CXIMAGE_static)
set(CXIMAGE_LIBRARIES    CXIMAGE_static)
