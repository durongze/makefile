
set(LIB_3RD_HOME ${CMAKE_CURRENT_LIST_DIR}/../../out/)

function(gen_dep_lib_dir all_dep_lib_dir)

    if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
        set(ALL_LIB_HOME_DIR "${LIB_3RD_HOME}/linux")
        EXECUTE_PROCESS(COMMAND ls ${ALL_LIB_HOME_DIR}
            TIMEOUT 5
            OUTPUT_VARIABLE ALL_LIB_DIR_LIST
            OUTPUT_STRIP_TRAILING_WHITESPACE
            )
    elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
        string(REPLACE "/" "\\" LIB_3RD_HOME "${LIB_3RD_HOME}")
        set(ALL_LIB_HOME_DIR "${LIB_3RD_HOME}\\windows")
        message("[INFO] ALL_LIB_HOME_DIR: ${ALL_LIB_HOME_DIR}")
        EXECUTE_PROCESS(COMMAND cmd /c dir /ad /b ${ALL_LIB_HOME_DIR}
            OUTPUT_VARIABLE ALL_LIB_DIR_LIST
            OUTPUT_STRIP_TRAILING_WHITESPACE
            )
    else()
        message("current platform: unkonw ") 
    endif()
    set(dep_lib_dir ${ALL_LIB_DIR_LIST})
    add_dep_lib_dir("${dep_lib_dir}")
    set(DepLibs ${DepLibs} PARENT_SCOPE)
endfunction()

function(add_dep_lib_dir dep_lib_dir )
    string(REPLACE "\n" ";" LIB_DIR_LIST "${ALL_LIB_DIR_LIST}")
    foreach(LIB_DIR ${LIB_DIR_LIST})
        include_directories(${ALL_LIB_HOME_DIR}/${LIB_DIR}/)
        include_directories(${ALL_LIB_HOME_DIR}/${LIB_DIR}/include)
        link_directories(${ALL_LIB_HOME_DIR}/${LIB_DIR}/lib)
        message("[INFO] ${ALL_LIB_HOME_DIR}/${LIB_DIR}/lib")
        if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
            file(GLOB cur_lib_name "${ALL_LIB_HOME_DIR}/${LIB_DIR}/lib/*.a")
            EXECUTE_PROCESS(COMMAND ls ${cur_lib_name}
                TIMEOUT 5
                OUTPUT_VARIABLE CUR_LIB_NAMES
                OUTPUT_STRIP_TRAILING_WHITESPACE
                )
        elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
            EXECUTE_PROCESS(COMMAND cmd /c dir ${ALL_LIB_HOME_DIR}\\${LIB_DIR}\\lib\\*.lib /b 
                OUTPUT_VARIABLE CUR_LIB_NAMES
                OUTPUT_STRIP_TRAILING_WHITESPACE
                )
        endif()
        message("[INFO] CUR_LIB_NAMES: ${CUR_LIB_NAMES}")
        list(APPEND dep_libs  ${CUR_LIB_NAMES})
    endforeach()

    message("[INFO] dep_libs: ${dep_libs}")
    string(REPLACE ".lib" "" DepLibs "${dep_libs}")
    string(REPLACE ";" "\n" DepLibs "${DepLibs}")
    string(REPLACE "\n" ";" DepLibs "${DepLibs}")
    string(REGEX REPLACE " $" "" DepLibs "${DepLibs}")
    set(DepLibs ${DepLibs} PARENT_SCOPE)
endfunction()