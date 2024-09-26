#file                (GLOB    LEX_F_LC3     RELATIVE     ${LC3_TOP_DIR}      ./fsrc/lc3.f                        )
#flex_generate       (        LEX_C_LC3                  ${LEX_F_LC3}                                       )

set (FLEX    flex)
function(flex_generate c_var)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})

    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/${rel_path})
        set (out_file ${CMAKE_BINARY_DIR}/lex.${out_name}.c)
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
                COMMAND ${FLEX} --nounistd -i -P ${out_name} ${abs_file}
                DEPENDS ${abs_file}
                COMMENT  "[1] ${FLEX} Generate ${out_name} by ${abs_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()