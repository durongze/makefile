#file                (GLOB    NONE_SRCS       RELATIVE     ${LIBWDI_TOP_DIR}      ./*.none  )
#embedder_generate   (        EMBEDDER_HDRS   ${EMBEDDER_HDRS})

set(SRC_TOP_DIR ${CMAKE_SOURCE_DIR})   # ${CMAKE_CURRENT_LIST_DIR}   ${CMAKE_CURRENT_SOURCE_DIR}   ${CMAKE_SOURCE_DIR}
set(BIN_TOP_DIR ${CMAKE_BINARY_DIR})

function(embedder_generate hdrs_var )
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any hdr files")
        return()
    endif()

    set(${hdrs_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} srcs: ${ARGN}")
    set(index 100)
    foreach(src_file ${ARGN})
        math(EXPR index "${index} + 1")
        set (out_path ${CMAKE_BINARY_DIR})
        set (out_file ${out_path}//${src_file})
            message("[INFO]:${index} ${CMAKE_CURRENT_FUNCTION}    src_file=${src_file}")
            message("      out_file=${out_file}    out_path=${out_path}    ")
        list(APPEND ${hdrs_var} ${out_file})

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                # COMMAND ${CMAKE_COMMAND} -E remove_directory "${out_path}"
                COMMAND ${CMAKE_COMMAND} -E make_directory   "${out_path}"
                # COMMAND ${CMAKE_COMMAND} -E copy_directory   "${abs_path}"   "${out_path}"
                COMMAND ${embedder_app}    ${out_file}
                DEPENDS ${embedder_app}
                COMMENT  "[${index}] ${CMAKE_CURRENT_FUNCTION} ${embedder_app}    ${out_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${hdrs_var}} PROPERTIES GENERATED TRUE)
    set(${hdrs_var} ${${hdrs_var}} PARENT_SCOPE)
endfunction()

function(embedder_fcopy src_f dest_dir)
    add_custom_command(OUTPUT ${dest_dir}
                       COMMAND "${CMAKE_COMMAND}" -E remove "${dest_dir}"
                       COMMAND "${CMAKE_COMMAND}" -E copy "${src_f}" "${dest_dir}"
                       DEPENDS "${src_f}"
                       COMMENT "${CMAKE_COMMAND} -E copy ${src_f} ${dest_dir}" VERBATIM)
endfunction()

function(embedder_dcopy src_d dest_dir)
    add_custom_command(OUTPUT ${dest_dir}
                       COMMAND "${CMAKE_COMMAND}" -E remove_directory "${dest_dir}"
                       COMMAND "${CMAKE_COMMAND}" -E copy_directory "${src_d}" "${dest_dir}"
                       DEPENDS "${src_d}"
                       COMMENT "${CMAKE_COMMAND} -E copy_directory ${src_d} ${dest_dir}" VERBATIM)
endfunction()

#include(target_system)
message(STATUS "CMAKE_CL_64                 = ${CMAKE_CL_64} ")
message(STATUS "CMAKE_SIZEOF_VOID_P         = ${CMAKE_SIZEOF_VOID_P} ")
message(STATUS "CMAKE_SYSTEM_PROCESSOR      = ${CMAKE_SYSTEM_PROCESSOR} ")      # target  : x86_64,AMD64,i386 
message(STATUS "CMAKE_GENERATOR_PLATFORM    = ${CMAKE_GENERATOR_PLATFORM} ")    # platform: Win32,x64
message(STATUS "CMAKE_HOST_SYSTEM_PROCESSOR = ${CMAKE_HOST_SYSTEM_PROCESSOR} ") # current : x86_64,AMD64,i386 


