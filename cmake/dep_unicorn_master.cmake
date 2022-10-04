# unicorn library

set(TOP_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

if (NOT TARGET unicorn)
  MESSAGE("[INFO] add +++++++++++++++++++ unicorn-static ++++++++++++++++++++++++++++++++")
  set(LIBNAME unicorn)
  option(BUILD_SHARED_LIBS "enable BUILD_SHARED_LIBS" ON)
  set(${LIBNAME}_DIR thirdparty/${LIBNAME}-master)
  set(${LIBNAME}_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../${${LIBNAME}_DIR})
  set(${LIBNAME}_BIN_DIR ${CMAKE_BINARY_DIR}/${${LIBNAME}_DIR})

  message("${LIBNAME}_DIR:${${LIBNAME}_DIR}")
  if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    add_compile_definitions(DYZ)
  endif()
  add_subdirectory(${${LIBNAME}_SRC_DIR}/)
endif()

include_directories(${${LIBNAME}_SRC_DIR})
include_directories(${${LIBNAME}_SRC_DIR}/include)
include_directories(${${LIBNAME}_BIN_DIR})
include_directories(${${LIBNAME}_BIN_DIR}/include)


link_directories(${${LIBNAME}_BIN_DIR})
link_directories(${${LIBNAME}_BIN_DIR}/lib)
link_directories(${${LIBNAME}_BIN_DIR}/Debug)

#set(unicorn_LIBRARY $<TARGET_OBJECTS:unicorn>  $<TARGET_OBJECTS:x86_64-softmmu>  $<TARGET_OBJECTS:arm-softmmu>  $<TARGET_OBJECTS:aarch64-softmmu>  $<TARGET_OBJECTS:m68k-softmmu>  )
set(unicorn_LIBRARY $<TARGET_OBJECTS:unicorn> x86_64-softmmu  arm-softmmu  aarch64-softmmu  m68k-softmmu  mips-softmmu  mipsel-softmmu  mips64-softmmu  mips64el-softmmu  sparc-softmmu  sparc64-softmmu  ppc-softmmu  ppc64-softmmu  riscv32-softmmu  riscv64-softmmu  s390x-softmmu  tricore-softmmu unicorn-common)