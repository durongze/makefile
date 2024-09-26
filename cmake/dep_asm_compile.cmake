# from libffi
# cl.exe   /EP      /I  ${src_dir}/include         ${src_dir}/src/x86/win64_intel.S    >    ${src_dir}/win64_plain.asm
# ml64.exe /c  /Cx  /Fo ${src_dir}/win64.obj                                                ${src_dir}/win64_plain.asm

#file                (GLOB    INTEL_S_SRCS     RELATIVE    ${LC3_TOP_DIR}      ./asm/*.S                        )
#masm_compile_64     (        MASM_S_SRCS                  ${INTEL_S_SRCS}                                      )
#masm_compile_32     (        MASM_S_SRCS                  ${INTEL_S_SRCS}                                      )

set(SRC_TOP_DIR CMAKE_CURRENT_SOURCE_DIR)
set(BIN_TOP_DIR CMAKE_BINARY_DIR)

# HAVE_64BIT
function(masm_compile_64 asm_var)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any asm files")
        return()
    endif()

    if (MSVC)
        set(SYMBOL_UNDERSCORE 1)
        set(HAVE_HIDDEN_VISIBILITY_ATTRIBUTE 0)
        foreach(src_file ${ARGN})
            get_filename_component(abs_file  ${src_file}     ABSOLUTE)
            get_filename_component(abs_path  ${abs_file}     PATH)
            get_filename_component(file_name ${src_file}     NAME_WE)
            file(RELATIVE_PATH     rel_path ${SRC_TOP_DIR} ${abs_path})

            set (out_name ${file_name})
            set (out_path ${BIN_TOP_DIR}/${rel_path})
            set (out_file ${BIN_TOP_DIR}/${out_name})

            message("[INFO]: ${CMAKE_CURRENT_FUNCTION}    src_file=${src_file}")
            message("abs_file=${abs_file}    abs_path=${abs_path}    file_name=${file_name}")
            message("out_file=${out_file}    out_path=${out_path}    out_name=${out_name}")

                set(TARGET X86_WIN64)
                set(HAVE_AS_X86_64_UNWIND_SECTION_TYPE 1)  
                set(pre_file "${out_file}.i")
                configure_file("${abs_file}" "${pre_file}" COPYONLY)
                set(masm_flags "/c /Cx /Fo")

            set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /Oy- /Oi /Gy /Zi /GL /Gd")
            set(CMAKE_C_FLAGS_DEBUG   "${CMAKE_C_FLAGS_DEBUG}   /Oy-")

            add_custom_target(preprocess
                COMMAND ${CMAKE_C_COMPILER} ${pre_file} /I ${SRC_TOP_DIR}/include /I ${SRC_TOP_DIR}/   /EP > ${out_file}
                SOURCES ${pre_file}
            )
        endforeach()

        set_source_files_properties(${${asm_var}} PROPERTIES GENERATED TRUE)
        set(${asm_var} ${${asm_var}} PARENT_SCOPE)
    endif()
endfunction()


function(masm_compile_32 asm_var)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any asm files")
        return()
    endif()

    if (MSVC)
        set(SYMBOL_UNDERSCORE 1)
        set(HAVE_HIDDEN_VISIBILITY_ATTRIBUTE 0)
        foreach(src_file ${ARGN})
            get_filename_component(abs_file  ${src_file}     ABSOLUTE)
            get_filename_component(abs_path  ${abs_file}     PATH)
            get_filename_component(file_name ${src_file}     NAME_WE)
            file(RELATIVE_PATH     rel_path ${SRC_TOP_DIR} ${abs_path})

            set (out_name ${file_name})
            set (out_path ${BIN_TOP_DIR}/${rel_path})
            set (out_file ${BIN_TOP_DIR}/${out_name})

            message("[INFO]: ${CMAKE_CURRENT_FUNCTION}    src_file=${src_file}")
            message("abs_file=${abs_file}    abs_path=${abs_path}    file_name=${file_name}")
            message("out_file=${out_file}    out_path=${out_path}    out_name=${out_name}")

                set(TARGET X86_WIN32)
                set(HAVE_AS_X86_64_UNWIND_SECTION_TYPE 0)
                set(pre_file "${out_file}.i")
                configure_file("${abs_file}" "${pre_file}" COPYONLY)
                set(masm_flags "/c /Cx /coff /safeseh /Fo")

            set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /Oy- /Oi /Gy /Zi /GL /Gd")
            set(CMAKE_C_FLAGS_DEBUG   "${CMAKE_C_FLAGS_DEBUG}   /Oy-")

            add_custom_target(preprocess
                COMMAND ${CMAKE_C_COMPILER} ${pre_file} /I ${SRC_TOP_DIR}/include /I ${SRC_TOP_DIR}/  /EP > ${out_file}
                SOURCES ${pre_file}
            )
        endforeach()

        set_source_files_properties(${${asm_var}} PROPERTIES GENERATED TRUE)
        set(${asm_var} ${${asm_var}} PARENT_SCOPE)
    endif()
endfunction()