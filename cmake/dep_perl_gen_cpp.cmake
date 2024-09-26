#file                (GLOB    PERL_D_SRCS     RELATIVE     ${LC3_TOP_DIR}      ./*.dat                        )
#perl_generate       (        PERL_C_SRCS                  ${PERL_FILE}    ${PERL_OPTS}    ${PERL_D_SRCS}                                     )

set(PERL5LIB $ENV{PERL5LIB} ${CMAKE_CURRENT_SOURCE_DIR}/perllib      ${CMAKE_CURRENT_SOURCE_DIR}      ${CMAKE_CURRENT_SOURCE_DIR}/x86      ${CMAKE_CURRENT_SOURCE_DIR}/asm)
set(PERL    "perl        -I ${CMAKE_CURRENT_SOURCE_DIR}/perllib   -I ${CMAKE_CURRENT_SOURCE_DIR}   -I ${CMAKE_CURRENT_SOURCE_DIR}/x86   -I ${CMAKE_CURRENT_SOURCE_DIR}/asm")

function(perl_generate_insns c_var pl_file)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/${rel_path})
        set (out_file ${out_path}/${out_name}n.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        list(APPEND ${c_var} ${out_path}/iflag.c     ${out_path}/iflaggen.h   ${out_path}/insnsb.c    )
        list(APPEND ${c_var} ${out_path}/insnsa.c    ${out_path}/insnsd.c     ${out_path}/insnsi.h    ${out_path}/insnsn.c)

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                # COMMAND ${CMAKE_COMMAND} -E remove_directory "${out_path}"
                COMMAND ${CMAKE_COMMAND} -E copy_directory   "${abs_path}"    "${out_path}"
                COMMAND ${PERL}    ${pl_file}    -fc ${abs_file}    ${out_path}/iflag.c
                COMMAND ${PERL}    ${pl_file}    -fh ${abs_file}    ${out_path}/iflaggen.h
                COMMAND ${PERL}    ${pl_file}    -b  ${abs_file}    ${out_path}/insnsb.c
                COMMAND ${PERL}    ${pl_file}    -a  ${abs_file}    ${out_path}/insnsa.c
                COMMAND ${PERL}    ${pl_file}    -d  ${abs_file}    ${out_path}/insnsd.c
                COMMAND ${PERL}    ${pl_file}    -i  ${abs_file}    ${out_path}/insnsi.h
                COMMAND ${PERL}    ${pl_file}    -n  ${abs_file}    ${out_path}/insnsn.c
                DEPENDS ${abs_file}
                COMMENT  "[1] ${CMAKE_CURRENT_FUNCTION} ${PERL} ${pl_file} Generate ${out_name} by ${abs_file} or ${src_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()

function(perl_generate_ver c_var pl_file)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/) # ${rel_path}
        set (out_file ${out_path}/${out_name}.h)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        list(APPEND ${c_var} ${CMAKE_BINARY_DIR}/version.h      ${CMAKE_BINARY_DIR}/version.mac    ${CMAKE_BINARY_DIR}/version.sed)
        list(APPEND ${c_var} ${CMAKE_BINARY_DIR}/version.mak    ${CMAKE_BINARY_DIR}/version.nsh)
        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND ${PERL}    ${pl_file}   h    <   ${abs_file}   >  ${CMAKE_BINARY_DIR}/version.h
                COMMAND ${PERL}    ${pl_file}   mac  <   ${abs_file}   >  ${CMAKE_BINARY_DIR}/version.mac
                COMMAND ${PERL}    ${pl_file}   sed  <   ${abs_file}   >  ${CMAKE_BINARY_DIR}/version.sed
                COMMAND ${PERL}    ${pl_file}   make <   ${abs_file}   >  ${CMAKE_BINARY_DIR}/version.mak
                COMMAND ${PERL}    ${pl_file}   nsis <   ${abs_file}   >  ${CMAKE_BINARY_DIR}/version.nsh
                DEPENDS ${abs_file}
                COMMENT  "[2] ${CMAKE_CURRENT_FUNCTION} ${PERL} ${pl_file} Generate ${out_name} by ${abs_file} or ${src_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()

function(perl_generate_regs c_var pl_file)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}) #${rel_path}
        set (out_file ${out_path}/${out_name}.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        list(APPEND ${c_var}  ${CMAKE_BINARY_DIR}/regs.c    ${CMAKE_BINARY_DIR}/regflags.c    ${CMAKE_BINARY_DIR}/regdis.c)
        list(APPEND ${c_var}  ${CMAKE_BINARY_DIR}/regdis.h    ${CMAKE_BINARY_DIR}/regvals.c    ${CMAKE_BINARY_DIR}/regs.h)

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND  ${PERL}    ${pl_file}   c  ${abs_file}  > ${CMAKE_BINARY_DIR}/regs.c
                COMMAND  ${PERL}    ${pl_file}  fc  ${abs_file}  > ${CMAKE_BINARY_DIR}/regflags.c
                COMMAND  ${PERL}    ${pl_file}  dc  ${abs_file}  > ${CMAKE_BINARY_DIR}/regdis.c
                COMMAND  ${PERL}    ${pl_file}  dh  ${abs_file}  > ${CMAKE_BINARY_DIR}/regdis.h
                COMMAND  ${PERL}    ${pl_file}  vc  ${abs_file}  > ${CMAKE_BINARY_DIR}/regvals.c
                COMMAND  ${PERL}    ${pl_file}   h  ${abs_file}  > ${CMAKE_BINARY_DIR}/regs.h
                DEPENDS ${abs_file}
                COMMENT  "[3] ${CMAKE_CURRENT_FUNCTION} ${PERL} ${pl_file} Generate ${out_name} by ${abs_file} or ${src_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()

function(perl_generate_warn c_var pl_file)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/) # ${rel_path}
        set (out_file ${out_path}/${out_name}.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        list(APPEND ${c_var}  ${CMAKE_BINARY_DIR}/warnings.c    ${CMAKE_BINARY_DIR}/warnings.h    ${CMAKE_BINARY_DIR}/warnings.src  )

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND  ${PERL}    ${pl_file}  c   ${CMAKE_BINARY_DIR}/warnings.c         ${abs_path}
                COMMAND  ${PERL}    ${pl_file}  h   ${CMAKE_BINARY_DIR}/warnings.h         ${abs_path}
                COMMAND  ${PERL}    ${pl_file}  doc ${CMAKE_BINARY_DIR}/warnings.src       ${abs_path}
                DEPENDS ${abs_file}
                COMMENT  "[4] ${CMAKE_CURRENT_FUNCTION} ${PERL} ${pl_file} Generate ${out_name} by ${abs_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()

function(perl_generate_tokhash c_var pl_file)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/) # ${rel_path}
        set (out_file ${out_path}/tokhash.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        list(APPEND ${c_var}  ${CMAKE_BINARY_DIR}/tokhash.c    ${CMAKE_BINARY_DIR}/tokhash.h    )

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND ${CMAKE_COMMAND} -E copy   "${CMAKE_CURRENT_SOURCE_DIR}/perllib/phash.ph"               ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E copy   "${CMAKE_CURRENT_SOURCE_DIR}/perllib/random_sv_vectors.ph"   ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E copy   "${CMAKE_CURRENT_SOURCE_DIR}/perllib/crc64.ph"               ${CMAKE_BINARY_DIR}
                COMMAND  ${PERL}    ${pl_file}  c   ${CMAKE_CURRENT_SOURCE_DIR}/x86/insns.dat   ${CMAKE_CURRENT_SOURCE_DIR}/x86/regs.dat   ${CMAKE_CURRENT_SOURCE_DIR}/asm/tokens.dat  >  ${CMAKE_BINARY_DIR}/tokhash.c
                COMMAND  ${PERL}    ${pl_file}  h   ${CMAKE_CURRENT_SOURCE_DIR}/x86/insns.dat   ${CMAKE_CURRENT_SOURCE_DIR}/x86/regs.dat   ${CMAKE_CURRENT_SOURCE_DIR}/asm/tokens.dat  >  ${CMAKE_BINARY_DIR}/tokens.h
                DEPENDS ${abs_file}
                COMMENT  "[5] ${CMAKE_CURRENT_FUNCTION} ${PERL} ${pl_file} Generate ${out_name} by ${abs_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()

function(perl_generate_pptok c_var pl_file)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/${rel_path})
        set (out_file ${out_path}/pptok.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        list(APPEND ${c_var}  ${out_path}/pptok.c    ${out_path}/pptok.h    ${out_path}/pptok.ph)

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND  ${PERL}    ${pl_file}  c   ${CMAKE_CURRENT_SOURCE_DIR}/asm/pptok.dat    ${out_path}/pptok.c
                COMMAND  ${PERL}    ${pl_file}  h   ${CMAKE_CURRENT_SOURCE_DIR}/asm/pptok.dat    ${out_path}/pptok.h
                COMMAND  ${PERL}    ${pl_file}  ph  ${CMAKE_CURRENT_SOURCE_DIR}/asm/pptok.dat    ${out_path}/pptok.ph
                DEPENDS ${abs_file}
                COMMENT  "[6] ${CMAKE_CURRENT_FUNCTION} ${PERL} ${pl_file} Generate ${out_name} by ${abs_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()

function(perl_generate_dc_hash c_var pl_file)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/) # ${rel_path}
        set (out_file ${out_path}/directbl.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        list(APPEND ${c_var}  ${CMAKE_BINARY_DIR}/directbl.c    ${CMAKE_BINARY_DIR}/directiv.h    )

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND  ${PERL}    ${pl_file}  c   ${CMAKE_CURRENT_SOURCE_DIR}/asm/directiv.dat    ${CMAKE_BINARY_DIR}/directbl.c
                COMMAND  ${PERL}    ${pl_file}  h   ${CMAKE_CURRENT_SOURCE_DIR}/asm/directiv.dat    ${CMAKE_BINARY_DIR}/directiv.h
                DEPENDS ${abs_file}
                COMMENT  "[7] ${CMAKE_CURRENT_FUNCTION} ${PERL} ${pl_file} Generate ${out_name} by ${abs_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()


function(perl_generate_macros c_var pl_file)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/) # ${rel_path}
        set (out_file ${out_path}/macros.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        list(APPEND ${c_var}  ${CMAKE_BINARY_DIR}/macros.c    )

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND ${CMAKE_COMMAND} -E copy_directory  "${CMAKE_CURRENT_SOURCE_DIR}/asm"    "${CMAKE_BINARY_DIR}/asm"
                COMMAND  ${PERL}    ${pl_file}   ${CMAKE_BINARY_DIR}/version.mac    ${CMAKE_CURRENT_SOURCE_DIR}/macros/*.mac    ${CMAKE_CURRENT_SOURCE_DIR}/output/*.mac  
                DEPENDS ${abs_file} ${CMAKE_BINARY_DIR}/version.mac 
                COMMENT  "[7] ${CMAKE_CURRENT_FUNCTION} ${PERL} ${pl_file} Generate ${out_name} by ${abs_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()


function(perl_generate c_var pl_file pl_opts)
    if(NOT ARGN)
        message(SEND_ERROR "Error: ${CMAKE_CURRENT_FUNCTION} called without any f files")
        return()
    endif()

    set(${c_var})
    message("[INFO]: ${CMAKE_CURRENT_FUNCTION} ${pl_file} ${pl_opts} srcs: ${ARGN}")
    foreach(src_file ${ARGN})
        get_filename_component(abs_file  ${src_file}     ABSOLUTE)
        get_filename_component(abs_path  ${abs_file}     PATH)
        get_filename_component(file_name ${src_file}     NAME_WE)
        file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${abs_path})
        set (pl_opts  ${pl_opts})
        set (out_name ${file_name})
        set (out_path ${CMAKE_BINARY_DIR}/${rel_path})
        set (out_file ${CMAKE_BINARY_DIR}/${out_name}.c)
        message("[INFO]: ${CMAKE_CURRENT_FUNCTION} src_file =${src_file}")
        message("[INFO]:       abs_file =${abs_file}")
        message("[INFO]:       file_name=${file_name}")
        message("[INFO]:       abs_path =${abs_path}")
        message("[INFO]:       rel_path =${rel_path}")
        message("[INFO]:       out_name =${out_name}")
        message("[INFO]:       out_path =${out_path}")
        message("[INFO]:       out_file =${out_file}")
        message("[INFO]:       CMAKE_CURRENT_SOURCE_DIR =${CMAKE_CURRENT_SOURCE_DIR}")
        message("[INFO]:       PROJECT_SOURCE_DIR =${PROJECT_SOURCE_DIR}")
        list(APPEND ${c_var} "${out_file}")

        add_custom_command(
                OUTPUT "${out_file}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${out_path}"
                COMMAND echo ${PERL}    ${pl_opts}    ${abs_file}    x    ${out_name} 
                DEPENDS ${abs_file}
                COMMENT  "[1] ${PERL} Generate ${out_name} by ${abs_file}" VERBATIM)
    endforeach()

    set_source_files_properties(${${c_var}} PROPERTIES GENERATED TRUE)
    set(${c_var} ${${c_var}} PARENT_SCOPE)
endfunction()