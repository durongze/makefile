if(NOT TARGET udev-master)
  set(LIBNAME udev-master)
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

set(UDEV_ROOT_DIR     ${ALL_LIB_HOME_DIR}/${LIBNAME})

set(UDEV_INCLUDE_DIRS ${UDEV_ROOT_DIR}/include)
set(UDEV_LIBRARY_DIRS ${UDEV_ROOT_DIR}/lib)

set(UDEV_LIBRARY      udev)
set(UDEV_LIBRARIES    udev)

include_directories(${UDEV_INCLUDE_DIRS})
link_directories   (${UDEV_LIBRARY_DIRS})

message("[INFO] UDEV_ROOT_DIR: ${UDEV_ROOT_DIR} ") 