if(NOT TARGET PDCurses)
    set(LIBNAME PDCurses)
    set(LIB_DIR_NAME PDCurses)
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

set(PDCurses_ROOT_DIR     ${${LIBNAME}_SRC_DIR})

set(PDCurses_INCLUDE_DIRS ${PDCurses_ROOT_DIR}     ${PDCurses_ROOT_DIR}/include  ${${LIBNAME}_BIN_DIR}/     ${${LIBNAME}_BIN_DIR}/include  )
set(PDCurses_LIBRARY_DIRS ${PDCurses_ROOT_DIR}     ${PDCurses_ROOT_DIR}/lib      ${${LIBNAME}_BIN_DIR}/     ${${LIBNAME}_BIN_DIR}/lib      ${${LIBNAME}_BIN_DIR}/Debug)

set(PDCurses_LIBRARY   $<TARGET_OBJECTS:PDCurses_static>)
set(PDCurses_LIBRARIES $<TARGET_OBJECTS:PDCurses_static>)

#include_directories(${PDCurses_INCLUDE_DIRS}  )
#link_directories   (${PDCurses_LIBRARY_DIRS}  )

