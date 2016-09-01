#################################################################
#								#
#	Copyright 2013 Fidelity Information Services, Inc	#
#								#
#	This source code contains the intellectual property	#
#	of its copyright holder(s), and is made available	#
#	under a license.  If you do not know the terms of	#
#	the license, please stop and do not read further.	#
#								#
#################################################################

set(arch "x86_64")
set(bits 64)
set(srdir "sr_darwin")

# Platform directories
list(APPEND gt_src_list sr_darwin sr_x86_64 sr_x86_regs)
set(gen_xfer_desc 1)

# Assembler
#enable_language(ASM_NASM)
set(CMAKE_INCLUDE_FLAG_ASM "-Wa,-I") # gcc -I does not make it to "as"
#set(CMAKE_SHARED_MODULE_CREATE_C_FLAGS "${CMAKE_SHARED_MODULE_CREATE_C_FLAGS} -flat_namespace -undefined suppress")
#list(APPEND CMAKE_ASM_COMPILE_OBJECT "objcopy --prefix-symbols=_ <OBJECT>")

# Compiler
set(CMAKE_C_FLAGS
  "${CMAKE_C_FLAGS} -fsigned-char -fPIC -Wmissing-prototypes -fno-omit-frame-pointer -mmacosx-version-min=10.11")

set(CMAKE_C_FLAGS_RELEASE  "${CMAKE_C_FLAGS_RELEASE} -fno-strict-aliasing")

# https://cmake.org/pipermail/cmake/2009-June/029929.html
SET(CMAKE_C_CREATE_STATIC_LIBRARY
  "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> <OBJECTS> "
	"<CMAKE_RANLIB> -c <TARGET> "
  )

add_definitions(
  #-DNOLIBGTMSHR #gt_cc_option_DBTABLD=-DNOLIBGTMSHR
  -D_GNU_SOURCE
  -D_FILE_OFFSET_BITS=64
  -D_XOPEN_SOURCE=600L
  -D_LARGEFILE64_SOURCE
  -D_DARWIN_C_SOURCE
  )

# Linker
set(gtm_link  "-Wl,-U,gtm_filename_to_id -Wl,-U,gtm_zstatus -Wl,-v -Wl,-exported_symbols_list \"${GTM_BINARY_DIR}/gtmexe_symbols.export\"")
set(libgtmshr_link "-Wl,-U,gtm_ci -Wl,-U,gtm_filename_to_id -Wl,-exported_symbols_list \"${GTM_BINARY_DIR}/gtmshr_symbols.export\"")
set(libgtmshr_dep  "${GTM_BINARY_DIR}/gtmexe_symbols.export")

set(libmumpslibs "-lncurses -lm -ldl -lc -lpthread -lelf")


include_directories (/opt/local/include /Volumes/Vault/ports/include)
link_directories (/opt/local/lib/)
