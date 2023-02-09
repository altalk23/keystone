if( WIN32 AND NOT CYGWIN )
  # We consider Cygwin as another Unix
  set(PURE_WINDOWS 1)
endif()

include(CheckIncludeFile)
include(CheckIncludeFileCXX)
include(CheckLibraryExists)
include(CheckSymbolExists)
include(CheckFunctionExists)
include(CheckCXXSourceCompiles)
include(TestBigEndian)

include(HandleLLVMStdlib)

if( UNIX AND NOT BEOS )
  # Used by check_symbol_exists:
  set(CMAKE_REQUIRED_LIBRARIES m)
endif()
# x86_64 FreeBSD 9.2 requires libcxxrt to be specified explicitly.
if( CMAKE_SYSTEM MATCHES "FreeBSD-9.2-RELEASE" AND
    CMAKE_SIZEOF_VOID_P EQUAL 8 )
  list(APPEND CMAKE_REQUIRED_LIBRARIES "cxxrt")
endif()

# Helper macros and functions
macro(add_cxx_include result files)
  set(${result} "")
  foreach (file_name ${files})
     set(${result} "${${result}}#include<${file_name}>\n")
  endforeach()
endmacro(add_cxx_include files result)

function(check_type_exists type files variable)
  add_cxx_include(includes "${files}")
  CHECK_CXX_SOURCE_COMPILES("
    ${includes} ${type} typeVar;
    int main() {
        return 0;
    }
    " ${variable})
endfunction()

# include and symbol checks
# changing for geode: takes too much of the configure time
if (PURE_WINDOWS)
  set(HAVE_DIRENT_H 0)
  set(HAVE_DLFCN_H 0)
  set(HAVE_ERRNO_H 1)
  set(HAVE_EXECINFO_H 0)
  set(HAVE_FCNTL_H 1)
  set(HAVE_INTTYPES_H 1)
  set(HAVE_LIMITS_H 1)
  set(HAVE_LINK_H 0)
  set(HAVE_MALLOC_H 1)
  set(HAVE_MALLOC_MALLOC_H 0)
  set(HAVE_NDIR_H 0)
  set(HAVE_PTHREAD_H 0)
  set(HAVE_SIGNAL_H 1)
  set(HAVE_STDINT_H 1)
  set(HAVE_SYS_DIR_H 0)
  set(HAVE_SYS_IOCTL_H 0)
  set(HAVE_SYS_MMAN_H 0)
  set(HAVE_SYS_NDIR_H 0)
  set(HAVE_SYS_PARAM_H 0)
  set(HAVE_SYS_RESOURCE_H 0)
  set(HAVE_SYS_STAT_H 1)
  set(HAVE_SYS_TIME_H 0)
  set(HAVE_SYS_UIO_H 0)
  set(HAVE_TERMIOS_H 0)
  set(HAVE_UNISTD_H 0)
  set(HAVE_UTIME_H 0)
  set(HAVE_DECL_FE_ALL_EXCEPT 1)
  set(HAVE_DECL_FE_INEXACT 1)
  
  set(HAVE_MACH_MACH_H 0)
  set(HAVE_MACH_O_DYLD_H 0)
  set(HAVE_HISTEDIT_H 0)
  
  set(HAVE_CXXABI_H 0)
  
  set(HAVE_LIBPTHREAD 0)
  set(HAVE_PTHREAD_GETSPECIFIC 0)
  set(HAVE_PTHREAD_RWLOCK_INIT 0)
  set(HAVE_PTHREAD_MUTEX_LOCK 0)
  set(PTHREAD_IN_LIBC 0)
  set(HAVE_PTHREAD_GETSPECIFIC 0)
  set(HAVE_PTHREAD_RWLOCK_INIT 0)
  set(HAVE_PTHREAD_MUTEX_LOCK 0)
  set(HAVE_LIBDL 0)
  set(HAVE_LIBRT 0)
  
  set(HAVE_DECL_ARC4RANDOM 0)
  set(HAVE_BACKTRACE 0)
  set(HAVE_GETPAGESIZE 0)
  set(HAVE_GETRUSAGE 0)
  set(HAVE_SETRLIMIT 0)
  set(HAVE_ISATTY 0)
  set(HAVE_FUTIMENS 0)
  set(HAVE_FUTIMES 0)
  
  set(HAVE_MALLCTL 0)
  set(HAVE_MALLINFO 0)
  set(HAVE_MALLOC_ZONE_STATISTICS 0)
  set(HAVE_MKDTEMP 0)
  set(HAVE_MKSTEMP 0)
  set(HAVE_MKTEMP 0)
  set(HAVE_CLOSEDIR 0)
  set(HAVE_OPENDIR 0)
  set(HAVE_READDIR 0)
  set(HAVE_GETCWD 0)
  set(HAVE_GETTIMEOFDAY 0)
  set(HAVE_GETRLIMIT 0)
  set(HAVE_POSIX_SPAWN 0)
  set(HAVE_PREAD 0)
  set(HAVE_REALPATH 0)
  set(HAVE_SBRK 0)
  set(HAVE_RAND48_SRAND48 0)
  set(HAVE_RAND48_LRAND48 0)
  set(HAVE_RAND48_DRAND48 0)
  set(HAVE_RAND48 0)

  set(HAVE_STRTOLL 1)
  set(HAVE_STRTOQ 0)
  set(HAVE_STRERROR 1)
  set(HAVE_STRERROR_R 0)
  set(HAVE_DECL_STRERROR_S 1)
  set(HAVE_SETENV 0)

  set(HAVE__CHSIZE_S 0)
  set(HAVE__ALLOCA 0)
  set(HAVE___ALLOCA 0)
  set(HAVE___CHKSTK 0)
  set(HAVE___CHKSTK_MS 0)
  set(HAVE____CHKSTK 0)
  set(HAVE____CHKSTK_MS 0)
  set(HAVE___ASHLDI3 0)
  set(HAVE___ASHRDI3 0)
  set(HAVE___DIVDI3 0)
  set(HAVE___FIXDFDI 0)
  set(HAVE___FIXSFDI 0)
  set(HAVE___FLOATDIDF 0)
  set(HAVE___LSHRDI3 0)
  set(HAVE___MODDI3 0)
  set(HAVE___UDIVDI3 0)
  set(HAVE___UMODDI3 0)
  set(HAVE___MAIN 0)
  set(HAVE___CMPDI2 0)
  
  set(LLVM_USING_GLIBC 0)

  set(HAVE_INT64_T 1)
  set(HAVE_UINT64_T 1)
  set(HAVE_U_INT64_T 0)

elseif (APPLE)
  set(HAVE_DIRENT_H 1)
  set(HAVE_DLFCN_H 1)
  set(HAVE_ERRNO_H 1)
  set(HAVE_EXECINFO_H 1)
  set(HAVE_FCNTL_H 1)
  set(HAVE_INTTYPES_H 1)
  set(HAVE_LIMITS_H 1)
  set(HAVE_LINK_H 0)
  set(HAVE_MALLOC_H 0)
  set(HAVE_MALLOC_MALLOC_H 1)
  set(HAVE_NDIR_H 0)
  set(HAVE_PTHREAD_H 1)
  set(HAVE_SIGNAL_H 1)
  set(HAVE_STDINT_H 1)
  set(HAVE_SYS_DIR_H 1)
  set(HAVE_SYS_IOCTL_H 1)
  set(HAVE_SYS_MMAN_H 1)
  set(HAVE_SYS_NDIR_H 0)
  set(HAVE_SYS_PARAM_H 1)
  set(HAVE_SYS_RESOURCE_H 1)
  set(HAVE_SYS_STAT_H 1)
  set(HAVE_SYS_TIME_H 1)
  set(HAVE_SYS_UIO_H 1)
  set(HAVE_TERMIOS_H 1)
  set(HAVE_UNISTD_H 1)
  set(HAVE_UTIME_H 1)
  set(HAVE_DECL_FE_ALL_EXCEPT 1)
  set(HAVE_DECL_FE_INEXACT 1)
  
  set(HAVE_MACH_MACH_H 1)
  set(HAVE_MACH_O_DYLD_H 1)
  set(HAVE_HISTEDIT_H 1)
  
  set(HAVE_CXXABI_H 1)
  
  set(HAVE_LIBPTHREAD 1)
  set(HAVE_PTHREAD_GETSPECIFIC 1)
  set(HAVE_PTHREAD_RWLOCK_INIT 1)
  set(HAVE_PTHREAD_MUTEX_LOCK 1)
  set(PTHREAD_IN_LIBC 1)
  set(HAVE_PTHREAD_GETSPECIFIC 1)
  set(HAVE_PTHREAD_RWLOCK_INIT 1)
  set(HAVE_PTHREAD_MUTEX_LOCK 1)
  set(HAVE_LIBDL 1)
  set(HAVE_LIBRT 0)
  
  set(HAVE_DECL_ARC4RANDOM 1)
  set(HAVE_BACKTRACE 1)
  set(HAVE_GETPAGESIZE 1)
  set(HAVE_GETRUSAGE 1)
  set(HAVE_SETRLIMIT 1)
  set(HAVE_ISATTY 1)
  set(HAVE_FUTIMENS 1)
  set(HAVE_FUTIMES 1)
  
  set(HAVE_MALLCTL 0)
  set(HAVE_MALLINFO 0)
  set(HAVE_MALLOC_ZONE_STATISTICS 1)
  set(HAVE_MKDTEMP 1)
  set(HAVE_MKSTEMP 1)
  set(HAVE_MKTEMP 1)
  set(HAVE_CLOSEDIR 1)
  set(HAVE_OPENDIR 1)
  set(HAVE_READDIR 1)
  set(HAVE_GETCWD 1)
  set(HAVE_GETTIMEOFDAY 1)
  set(HAVE_GETRLIMIT 1)
  set(HAVE_POSIX_SPAWN 1)
  set(HAVE_PREAD 1)
  set(HAVE_REALPATH 1)
  set(HAVE_SBRK 1)
  set(HAVE_RAND48_SRAND48 1)
  set(HAVE_RAND48_LRAND48 1)
  set(HAVE_RAND48_DRAND48 1)
  set(HAVE_RAND48 1)

  set(HAVE_STRTOLL 1)
  set(HAVE_STRTOQ 1)
  set(HAVE_STRERROR 1)
  set(HAVE_STRERROR_R 1)
  set(HAVE_DECL_STRERROR_S 0)
  set(HAVE_SETENV 1)

  set(HAVE__CHSIZE_S 0)
  set(HAVE__ALLOCA 0)
  set(HAVE___ALLOCA 0)
  set(HAVE___CHKSTK 0)
  set(HAVE___CHKSTK_MS 0)
  set(HAVE____CHKSTK 0)
  set(HAVE____CHKSTK_MS 0)
  set(HAVE___ASHLDI3 0)
  set(HAVE___ASHRDI3 0)
  set(HAVE___DIVDI3 0)
  set(HAVE___FIXDFDI 0)
  set(HAVE___FIXSFDI 0)
  set(HAVE___FLOATDIDF 0)
  set(HAVE___LSHRDI3 0)
  set(HAVE___MODDI3 0)
  set(HAVE___UDIVDI3 0)
  set(HAVE___UMODDI3 0)
  set(HAVE___MAIN 0)
  set(HAVE___CMPDI2 0)
  
  set(LLVM_USING_GLIBC 0)

  set(HAVE_INT64_T 1)
  set(HAVE_UINT64_T 1)
  set(HAVE_U_INT64_T 1)
endif()

# available programs checks
function(llvm_find_program name)
  string(TOUPPER ${name} NAME)
  string(REGEX REPLACE "\\." "_" NAME ${NAME})

  find_program(LLVM_PATH_${NAME} NAMES ${ARGV})
  mark_as_advanced(LLVM_PATH_${NAME})
  if(LLVM_PATH_${NAME})
    set(HAVE_${NAME} 1 CACHE INTERNAL "Is ${name} available ?")
    mark_as_advanced(HAVE_${NAME})
  else(LLVM_PATH_${NAME})
    set(HAVE_${NAME} "" CACHE INTERNAL "Is ${name} available ?")
  endif(LLVM_PATH_${NAME})
endfunction()

# Define LLVM_HAS_ATOMICS if gcc or MSVC atomic builtins are supported.
include(CheckAtomic)

if( LLVM_ENABLE_PIC )
  set(ENABLE_PIC 1)
else()
  set(ENABLE_PIC 0)
  check_cxx_compiler_flag("-fno-pie" SUPPORTS_NO_PIE_FLAG)
  if(SUPPORTS_NO_PIE_FLAG)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fno-pie")
  endif()
endif()

check_cxx_compiler_flag("-Wno-variadic-macros" SUPPORTS_NO_VARIADIC_MACROS_FLAG)

set(USE_NO_MAYBE_UNINITIALIZED 0)
set(USE_NO_UNINITIALIZED 0)

# Disable gcc's potentially uninitialized use analysis as it presents lots of
# false positives.
if (CMAKE_COMPILER_IS_GNUCXX)
  check_cxx_compiler_flag("-Wmaybe-uninitialized" HAS_MAYBE_UNINITIALIZED)
  if (HAS_MAYBE_UNINITIALIZED)
    set(USE_NO_MAYBE_UNINITIALIZED 1)
  else()
    # Only recent versions of gcc make the distinction between -Wuninitialized
    # and -Wmaybe-uninitialized. If -Wmaybe-uninitialized isn't supported, just
    # turn off all uninitialized use warnings.
    check_cxx_compiler_flag("-Wuninitialized" HAS_UNINITIALIZED)
    set(USE_NO_UNINITIALIZED ${HAS_UNINITIALIZED})
  endif()
endif()

# By default, we target the host, but this can be overridden at CMake
# invocation time.
include(GetHostTriple)
get_host_triple(LLVM_INFERRED_HOST_TRIPLE)

set(LLVM_HOST_TRIPLE "${LLVM_INFERRED_HOST_TRIPLE}" CACHE STRING
    "Host on which LLVM binaries will run")

# Determine the native architecture.
string(TOLOWER "${LLVM_TARGET_ARCH}" LLVM_NATIVE_ARCH)
if( LLVM_NATIVE_ARCH STREQUAL "host" )
  string(REGEX MATCH "^[^-]*" LLVM_NATIVE_ARCH ${LLVM_HOST_TRIPLE})
endif ()

if (LLVM_NATIVE_ARCH MATCHES "i[2-6]86")
  set(LLVM_NATIVE_ARCH X86)
elseif (LLVM_NATIVE_ARCH STREQUAL "x86")
  set(LLVM_NATIVE_ARCH X86)
elseif (LLVM_NATIVE_ARCH STREQUAL "amd64")
  set(LLVM_NATIVE_ARCH X86)
elseif (LLVM_NATIVE_ARCH STREQUAL "x86_64")
  set(LLVM_NATIVE_ARCH X86)
elseif (LLVM_NATIVE_ARCH MATCHES "sparc")
  set(LLVM_NATIVE_ARCH Sparc)
elseif (LLVM_NATIVE_ARCH MATCHES "powerpc")
  set(LLVM_NATIVE_ARCH PowerPC)
elseif (LLVM_NATIVE_ARCH MATCHES "aarch64")
  set(LLVM_NATIVE_ARCH AArch64)
elseif (LLVM_NATIVE_ARCH MATCHES "arm64")
  set(LLVM_NATIVE_ARCH AArch64)
elseif (LLVM_NATIVE_ARCH MATCHES "arm")
  set(LLVM_NATIVE_ARCH ARM)
elseif (LLVM_NATIVE_ARCH MATCHES "mips")
  set(LLVM_NATIVE_ARCH Mips)
elseif (LLVM_NATIVE_ARCH MATCHES "xcore")
  set(LLVM_NATIVE_ARCH XCore)
elseif (LLVM_NATIVE_ARCH MATCHES "msp430")
  set(LLVM_NATIVE_ARCH MSP430)
elseif (LLVM_NATIVE_ARCH MATCHES "hexagon")
  set(LLVM_NATIVE_ARCH Hexagon)
elseif (LLVM_NATIVE_ARCH MATCHES "s390x")
  set(LLVM_NATIVE_ARCH SystemZ)
elseif (LLVM_NATIVE_ARCH MATCHES "wasm32")
  set(LLVM_NATIVE_ARCH WebAssembly)
elseif (LLVM_NATIVE_ARCH MATCHES "wasm64")
  set(LLVM_NATIVE_ARCH WebAssembly)
else ()
  message(FATAL_ERROR "Unknown architecture ${LLVM_NATIVE_ARCH}")
endif ()

# If build targets includes "host", then replace with native architecture.
list(FIND LLVM_TARGETS_TO_BUILD "host" idx)
if( NOT idx LESS 0 )
  list(REMOVE_AT LLVM_TARGETS_TO_BUILD ${idx})
  list(APPEND LLVM_TARGETS_TO_BUILD ${LLVM_NATIVE_ARCH})
  list(REMOVE_DUPLICATES LLVM_TARGETS_TO_BUILD)
endif()

list(FIND LLVM_TARGETS_TO_BUILD ${LLVM_NATIVE_ARCH} NATIVE_ARCH_IDX)
if (NATIVE_ARCH_IDX EQUAL -1)
  message(STATUS
    "Native target ${LLVM_NATIVE_ARCH} is not selected; lli will not JIT code")
else ()
  message(STATUS "Native target architecture is ${LLVM_NATIVE_ARCH}")
  set(LLVM_NATIVE_TARGET LLVMInitialize${LLVM_NATIVE_ARCH}Target)
  set(LLVM_NATIVE_TARGETINFO LLVMInitialize${LLVM_NATIVE_ARCH}TargetInfo)
  set(LLVM_NATIVE_TARGETMC LLVMInitialize${LLVM_NATIVE_ARCH}TargetMC)
  set(LLVM_NATIVE_ASMPRINTER LLVMInitialize${LLVM_NATIVE_ARCH}AsmPrinter)

  # We don't have an ASM parser for all architectures yet.
  if (EXISTS ${CMAKE_SOURCE_DIR}/lib/Target/${LLVM_NATIVE_ARCH}/AsmParser/CMakeLists.txt)
    set(LLVM_NATIVE_ASMPARSER LLVMInitialize${LLVM_NATIVE_ARCH}AsmParser)
  endif ()

  # We don't have an disassembler for all architectures yet.
  if (EXISTS ${CMAKE_SOURCE_DIR}/lib/Target/${LLVM_NATIVE_ARCH}/Disassembler/CMakeLists.txt)
    set(LLVM_NATIVE_DISASSEMBLER LLVMInitialize${LLVM_NATIVE_ARCH}Disassembler)
  endif ()
endif ()

if( MINGW )
  set(HAVE_LIBPSAPI 1)
  set(HAVE_LIBSHELL32 1)
  # TODO: Check existence of libraries.
  #   include(CheckLibraryExists)
endif( MINGW )

if (NOT HAVE_STRTOLL)
  # Use _strtoi64 if strtoll is not available.
  check_symbol_exists(_strtoi64 stdlib.h have_strtoi64)
  if (have_strtoi64)
    set(HAVE_STRTOLL 1)
    set(strtoll "_strtoi64")
    set(strtoull "_strtoui64")
  endif ()
endif ()

if( MSVC )
  set(SHLIBEXT ".lib")
  set(stricmp "_stricmp")
  set(strdup "_strdup")

  # See if the DIA SDK is available and usable.
  set(MSVC_DIA_SDK_DIR "$ENV{VSINSTALLDIR}DIA SDK")

  # Due to a bug in MSVC 2013's installation software, it is possible
  # for MSVC 2013 to write the DIA SDK into the Visual Studio 2012
  # install directory.  If this happens, the installation is corrupt
  # and there's nothing we can do.  It happens with enough frequency
  # though that we should handle it.  We do so by simply checking that
  # the DIA SDK folder exists.  Should this happen you will need to
  # uninstall VS 2012 and then re-install VS 2013.
  if (IS_DIRECTORY ${MSVC_DIA_SDK_DIR})
    set(HAVE_DIA_SDK 1)
  else()
    set(HAVE_DIA_SDK 0)
  endif()
else()
  set(HAVE_DIA_SDK 0)
endif( MSVC )

if( PURE_WINDOWS )
  CHECK_CXX_SOURCE_COMPILES("
    #include <windows.h>
    #include <imagehlp.h>
    extern \"C\" void foo(PENUMLOADED_MODULES_CALLBACK);
    extern \"C\" void foo(BOOL(CALLBACK*)(PCSTR,ULONG_PTR,ULONG,PVOID));
    int main(){return 0;}"
    HAVE_ELMCB_PCSTR)
  if( HAVE_ELMCB_PCSTR )
    set(WIN32_ELMCB_PCSTR "PCSTR")
  else()
    set(WIN32_ELMCB_PCSTR "PSTR")
  endif()
endif( PURE_WINDOWS )

# FIXME: Signal handler return type, currently hardcoded to 'void'
set(RETSIGTYPE void)

if( LLVM_ENABLE_THREADS )
  # Check if threading primitives aren't supported on this platform
  if( NOT HAVE_PTHREAD_H AND NOT WIN32 )
    set(LLVM_ENABLE_THREADS 0)
  endif()
endif()

if( LLVM_ENABLE_THREADS )
  message(STATUS "Threads enabled.")
else( LLVM_ENABLE_THREADS )
  message(STATUS "Threads disabled.")
endif()

if (LLVM_ENABLE_ZLIB )
  # Check if zlib is available in the system.
  if ( NOT HAVE_ZLIB_H OR NOT HAVE_LIBZ )
    set(LLVM_ENABLE_ZLIB 0)
  endif()
endif()

set(LLVM_PREFIX ${CMAKE_INSTALL_PREFIX})

find_program(GOLD_EXECUTABLE NAMES ${LLVM_DEFAULT_TARGET_TRIPLE}-ld.gold ld.gold ${LLVM_DEFAULT_TARGET_TRIPLE}-ld ld DOC "The gold linker")
set(LLVM_BINUTILS_INCDIR "" CACHE PATH
	"PATH to binutils/include containing plugin-api.h for gold plugin.")

if(APPLE)
  find_program(LD64_EXECUTABLE NAMES ld DOC "The ld64 linker")
endif()

string(REPLACE " " ";" LLVM_BINDINGS_LIST "${LLVM_BINDINGS}")
