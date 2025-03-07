# the name of the target operating system
set(CMAKE_SYSTEM_NAME      Generic)
set(CMAKE_SYSTEM_VERSION   1)
set(CMAKE_SYSTEM_PROCESSOR 8051)

set(CMAKE_C_FLAGS "--model-large --less-pedantic --opt-code-size")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
# which compilers to use for C and C++
set(CMAKE_C_COMPILER sdcc)

# here is the target environment is located

if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    SET(CMAKE_FIND_ROOT_PATH  /usr/share/sdcc)
elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    SET(CMAKE_FIND_ROOT_PATH  F:/program/sdcc/bin)
    #string(REPLACE "/" "\\" ALL_LIB_HOME_DIR "${ALL_LIB_HOME_DIR}")
else()
    message("current platform: unkonw ") 
endif()

# adjust the default behaviour of the FIND_XXX() commands:
# search headers and libraries in the target environment, search 
# programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)