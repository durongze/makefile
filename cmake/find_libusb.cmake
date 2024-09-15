if(NOT TARGET libusb)
  set(LIBNAME libusb)
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

set(LIBUSB_ROOT_DIR     ${ALL_LIB_HOME_DIR}/${LIBNAME})

set(LIBUSB_INCLUDE_DIRS ${LIBUSB_ROOT_DIR}/include )
set(LIBUSB_LIBRARY_DIRS ${LIBUSB_ROOT_DIR}/lib     )

set(LIBUSB_LIBRARY      usb-1.0)
set(LIBUSB_LIBRARIES    usb-1.0)

include_directories(${LIBUSB_INCLUDE_DIRS})
link_directories   (${LIBUSB_LIBRARY_DIRS})

message("[INFO] LIBUSB_ROOT_DIR: ${LIBUSB_ROOT_DIR} ") 