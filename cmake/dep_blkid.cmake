#FindBLKID.cmake:FIND_PACKAGE_HANDLE_STANDARD_ARGS(BLKID REQUIRED_VARS KMOD_LIBRARY KMOD_INCLUDE_DIR VERSION_VAR KMOD_VERSION HANDLE_COMPONENTS) 
if(NOT TARGET blkid)
    set(LIBNAME blkid)
    set(LIB_DIR_NAME util-linux-2.35)
    set(ALL_LIB_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../thirdparty)
    set(ALL_LIB_BIN_DIR ${CMAKE_BINARY_DIR}/thirdparty)
    set(${LIBNAME}_SRC_DIR ${ALL_LIB_SRC_DIR}/${LIB_DIR_NAME})
    set(${LIBNAME}_BIN_DIR ${ALL_LIB_BIN_DIR}/${LIB_DIR_NAME})
    message("${LIBNAME}_SRC_DIR:${${LIBNAME}_SRC_DIR}")
    message("${LIBNAME}_BIN_DIR:${${LIBNAME}_BIN_DIR}")
    if(CMAKE_SYSTEM_NAME MATCHES "Linux")
        #add_compile_definitions(SYSCONFDIR="/etc")
    endif()
    add_subdirectory(${${LIBNAME}_SRC_DIR}/)
endif()

set(BLKID_ROOT_DIR     ${${LIBNAME}_SRC_DIR})

set(BLKID_INCLUDE_DIRS ${BLKID_ROOT_DIR}     ${BLKID_ROOT_DIR}/include  ${${LIBNAME}_BIN_DIR}/     ${${LIBNAME}_BIN_DIR}/include  )
set(BLKID_LIBRARY_DIRS ${BLKID_ROOT_DIR}     ${BLKID_ROOT_DIR}/lib      ${${LIBNAME}_BIN_DIR}/     ${${LIBNAME}_BIN_DIR}/lib      ${${LIBNAME}_BIN_DIR}/Debug)

set(BLKID_LIBRARY   $<TARGET_OBJECTS:blkid_static>)
set(BLKID_LIBRARIES $<TARGET_OBJECTS:blkid_static>)

#include_directories(${BLKID_INCLUDE_DIRS}  )
#link_directories   (${BLKID_LIBRARY_DIRS}  )
