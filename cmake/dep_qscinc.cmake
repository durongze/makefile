#FindQSCINC.cmake:FIND_PACKAGE_HANDLE_STANDARD_ARGS(QSCINC REQUIRED_VARS QSCINC_LIBRARY QSCINC_INCLUDE_DIR VERSION_VAR QSCINC_VERSION HANDLE_COMPONENTS) 
if(NOT TARGET qscinc)
    set(LIBNAME      qscint)
    set(LIB_DIR_NAME qscint)

    #set(ALL_LIB_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../thirdparty)
    set(ALL_LIB_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../src)
    set(ALL_LIB_BIN_DIR ${CMAKE_BINARY_DIR}/thirdparty)

    set(${LIBNAME}_SRC_DIR ${ALL_LIB_SRC_DIR}/${LIB_DIR_NAME})
    set(${LIBNAME}_BIN_DIR ${ALL_LIB_BIN_DIR}/${LIB_DIR_NAME})

    message("${LIBNAME}_SRC_DIR:${${LIBNAME}_SRC_DIR}")
    message("${LIBNAME}_BIN_DIR:${${LIBNAME}_BIN_DIR}")

    if(CMAKE_SYSTEM_NAME MATCHES "Linux")
        add_compile_definitions(DYZ)
    endif()
    add_subdirectory(${${LIBNAME}_SRC_DIR}/)
endif()

set(QSCINC_ROOT_DIR     ${${LIBNAME}_SRC_DIR})

set(QSCINC_INCLUDE_DIRS ${QSCINC_ROOT_DIR}   ${QSCINC_ROOT_DIR}/src   ${QSCINC_ROOT_DIR}/include   ${${LIBNAME}_BIN_DIR}/      ${${LIBNAME}_BIN_DIR}/include  )
set(QSCINC_LIBRARY_DIRS ${QSCINC_ROOT_DIR}   ${QSCINC_ROOT_DIR}/lib   ${${LIBNAME}_BIN_DIR}/     ${${LIBNAME}_BIN_DIR}/lib   ${${LIBNAME}_BIN_DIR}/Debug)

set(QSCINC_LIB       $<TARGET_OBJECTS:qscinc>)

set(QSCINC_LIBRARY   $<TARGET_OBJECTS:qscinc>)
set(QSCINC_LIBRARIES $<TARGET_OBJECTS:qscinc>)

include_directories(${QSCINC_INCLUDE_DIRS})
link_directories   (${QSCINC_LIBRARY_DIRS})