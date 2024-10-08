if(NOT TARGET id3lib)
  set(LIBNAME id3lib)
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

set(ID3LIB_ROOT_DIR     ${ALL_LIB_HOME_DIR}/${LIBNAME})
set(ID3LIB_INCLUDE_DIRS ${ID3LIB_ROOT_DIR}/include)
set(ID3LIB_LIBRARY_DIRS ${ID3LIB_ROOT_DIR}/lib)
set(ID3LIB_LIBRARY      ID3LIB_static)
set(ID3LIB_LIBRARIES    ID3LIB_static)
