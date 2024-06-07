cmake_minimum_required(VERSION 3.10)

project(PPR_CMD)

set(PDCurses_TOP_DIR ${CMAKE_CURRENT_LIST_DIR})

set(COMMON_FLAG "-fpermissive -g -Wall ")

#set(CMAKE_BUILD_TYPE DEBUG)
set(CMAKE_C_FLAGS "${COMMON_FLAG}")
#set(CMAKE_C_FLAGS_DEBUG "${COMMON_FLAG}")
#set(CMAKE_C_FLAGS_RELEASE "${COMMON_FLAG}")
set(CMAKE_CXX_FLAGS "${COMMON_FLAG}")
#set(CMAKE_CXX_FLAGS_DEBUG "${COMMON_FLAG}")
#set(CMAKE_CXX_FLAGS_RELEASE "${COMMON_FLAG}")

#set(CMAKE_STATIC_LINKER_FLAGS  "${COMMON_FLAG}")
#set(CMAKE_SHARED_LINKR_FLAGS "${COMMON_FLAG}")
#set(CMAKE_MODULE_LINKER_FLAGS "${COMMON_FLAG}")

#set(CMAKE_FIND_ROOT_PATH /usr/i686-w64-mingw32)

#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

include_directories(${PDCurses_TOP_DIR}/)
include_directories(${PDCurses_TOP_DIR}/common)
include_directories(${PDCurses_TOP_DIR}/demos)
include_directories(${PDCurses_TOP_DIR}/dos)
include_directories(${PDCurses_TOP_DIR}/os2)
include_directories(${PDCurses_TOP_DIR}/pdcurses)
include_directories(${PDCurses_TOP_DIR}/sdl1)
include_directories(${PDCurses_TOP_DIR}/sdl2)
include_directories(${PDCurses_TOP_DIR}/wincon)
include_directories(${PDCurses_TOP_DIR}/x11)

file(GLOB common_SRCS   RELATIVE  ${PDCurses_TOP_DIR}/ ./common/*.c*)
file(GLOB demos_SRCS    RELATIVE  ${PDCurses_TOP_DIR}/ ./demos/*.c*)
file(GLOB dos_SRCS      RELATIVE  ${PDCurses_TOP_DIR}/ ./dos/*.c*)
file(GLOB os2_SRCS      RELATIVE  ${PDCurses_TOP_DIR}/ ./os2/*.c*)
file(GLOB pdcurses_SRCS RELATIVE  ${PDCurses_TOP_DIR}/ ./pdcurses/*.c* ./pdcurses/*.h*)
file(GLOB sdl1_SRCS     RELATIVE  ${PDCurses_TOP_DIR}/ ./sdl1/*.c*)
file(GLOB sdl2_SRCS     RELATIVE  ${PDCurses_TOP_DIR}/ ./sdl2/*.c*)
file(GLOB wincon_SRCS   RELATIVE  ${PDCurses_TOP_DIR}/ ./wincon/*.c* ./wincon/*.h*)
file(GLOB x11_SRCS      RELATIVE  ${PDCurses_TOP_DIR}/ ./x11/*.c* )
file(GLOB lib_SRCS      RELATIVE  ${PDCurses_TOP_DIR}/ ./*.c* ./*.h*  )

#set(all_srcs ${common_SRCS} ${dos_SRCS} ${os2_SRCS} ${pdcurses_SRCS} ${sdl1_SRCS} ${sdl2_SRCS} ${wincon_SRCS} ${x11_SRCS})

	if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
		set(all_srcs ${pdcurses_SRCS} )
	elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
		set(all_srcs ${pdcurses_SRCS} ${wincon_SRCS} ${lib_SRCS} )
	else()
		message("current platform: unkonw ") 
	endif()

add_library(PDCurses_static STATIC ${all_srcs})
add_library(PDCurses_shared SHARED ${all_srcs})

file(GLOB_RECURSE PDCurses_HDRS_LIST RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
set_target_properties(PDCurses_shared PROPERTIES PUBLIC_HEADER ${PDCurses_HDRS_LIST})

SET_TARGET_PROPERTIES(PDCurses_static PROPERTIES    CLEAN_DIRECT_OUTPUT 1    OUTPUT_NAME "libPDCurses"    )
SET_TARGET_PROPERTIES(PDCurses_shared PROPERTIES    CLEAN_DIRECT_OUTPUT 1    OUTPUT_NAME "libPDCurses"    )



file(GLOB tuidemo_SRCS  RELATIVE  ${PDCurses_TOP_DIR}/ ./demos/tui*.c*)
list(REMOVE_ITEM tuidemo_SRCS demos/firework.c)

set(dep_libs )

message("tuidemo_SRCS ${tuidemo_SRCS}")
message("[INFO] dep_libs: ${dep_libs} ")

source_group(TREE ${PDCurses_TOP_DIR} FILES ${all_srcs} ${tuidemo_SRCS})

add_executable(tuidemo  ${all_srcs} ${tuidemo_SRCS})
target_link_libraries(tuidemo ${dep_libs})

SET(install_targets tuidemo PDCurses_static PDCurses_shared)

INSTALL(TARGETS ${install_targets}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        PUBLIC_HEADER DESTINATION include
       )