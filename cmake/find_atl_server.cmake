if(NOT TARGET ATL_Server)
  set(LIBNAME ATL_Server)
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

set(ATL_SERVER_ROOT_DIR     ${ALL_LIB_HOME_DIR}/${LIBNAME})
set(ATL_SERVER_INCLUDE_DIRS ${ATL_SERVER_ROOT_DIR}/include)
set(ATL_SERVER_LIBRARY_DIRS ${ATL_SERVER_ROOT_DIR}/lib)
set(ATL_SERVER_LIBRARY      ATL_SERVER_static)
set(ATL_SERVER_LIBRARIES    ATL_SERVER_static)
