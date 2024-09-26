#file                (GLOB    LEX_Y_SRCS     RELATIVE     ${LC3_TOP_DIR}      ./ysrc/*.y                        )
#bison_generate      (        LEX_C_SRCS                  ${LEX_Y_SRCS}                                       )

set (BISON    bison)
function(bison_generate c_var)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any y files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/${rel_path})
        set (out_file ${CMAKE_BINARY_DIR}/${out_name}y.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} abs_file =${abs_file}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} file_name=${file_name}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} abs_path =${abs_path}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} rel_path =${rel_path}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} out_name =${out_name}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} out_path =${out_path}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} out_file =${out_file}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} CMAKE_CURRENT_SOURCE_DIR =${CMAKE_CURRENT_SOURCE_DIR}")
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} PROJECT_SOURCE_DIR =${PROJECT_SOURCE_DIR}")
        list(APPEND ${c_var} "${out_file}")

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND ${BISON}   -v -o ${out_file} ${abs_file}
                DEPENDS ${abs_file}
                COMMENT  "[1] ${BISON} Generate ${out_file} by ${abs_file}" VERBATIM    )
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()