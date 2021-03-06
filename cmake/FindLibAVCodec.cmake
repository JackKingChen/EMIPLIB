
set(LIBAVCODEC_OLD FALSE)
set(LIBAVCODEC_NEW FALSE)

find_path(LIBAVCODEC_INCLUDE_DIR_NEW libavcodec/avcodec.h)
if (NOT LIBAVCODEC_INCLUDE_DIR_NEW)
	find_path(LIBAVCODEC_INCLUDE_DIR_OLD ffmpeg/avcodec.h)
	if (LIBAVCODEC_INCLUDE_DIR_OLD)
		set(LIBAVCODEC_INCLUDE_DIRS ${LIBAVCODEC_INCLUDE_DIR_OLD})
		set(LIBAVCODEC_OLD TRUE)
		set(LIBAVCODEC_AVCODEC_INIT TRUE)
	endif (LIBAVCODEC_INCLUDE_DIR_OLD)
else (NOT LIBAVCODEC_INCLUDE_DIR_NEW)
	set(LIBAVCODEC_INCLUDE_DIRS ${LIBAVCODEC_INCLUDE_DIR_NEW})
	set(LIBAVCODEC_NEW TRUE)
	set(CMAKE_REQUIRED_INCLUDES ${LIBAVCODEC_INCLUDE_DIR_NEW})
	check_cxx_source_compiles("#ifndef __STDC_CONSTANT_MACROS\n#define __STDC_CONSTANT_MACROS\n#endif\n#include <stdint.h>\nextern \"C\"\n{\n#include <libavcodec/avcodec.h>\n#include <libswscale/swscale.h>\n}\n\nint main(void)\n{\navcodec_init();\nreturn 0;\n}\n" LIBAVCODEC_AVCODEC_INIT)
	if (LIBAVCODEC_AVCODEC_INIT)
		set(LIBAVCODEC_AVCODEC_INIT TRUE)
	else ()
		set(LIBAVCODEC_AVCODEC_INIT FALSE)
	endif()
endif (NOT LIBAVCODEC_INCLUDE_DIR_NEW)

if (LIBAVCODEC_OLD OR LIBAVCODEC_NEW)
	find_library(LIBAVCODEC_LIB_AVCODEC avcodec)

	if (LIBAVCODEC_LIB_AVCODEC)
		set(LIBAVCODEC_LIBRARIES ${LIBAVCODEC_LIB_AVCODEC})
		find_library(LIBAVCODEC_LIB_AVUTIL avutil)
		find_library(LIBAVCODEC_LIB_SWSCALE swscale)
		find_library(LIBAVCODEC_LIB_AVCORE avcore)
		find_library(LIBAVCODEC_LIB_AVFILTER avfilter)
		if (LIBAVCODEC_LIB_AVUTIL)
			set(LIBAVCODEC_LIBRARIES ${LIBAVCODEC_LIBRARIES} ${LIBAVCODEC_LIB_AVUTIL})
		endif (LIBAVCODEC_LIB_AVUTIL)
		if (LIBAVCODEC_LIB_SWSCALE)
			set(LIBAVCODEC_LIBRARIES ${LIBAVCODEC_LIBRARIES} ${LIBAVCODEC_LIB_SWSCALE})
		endif (LIBAVCODEC_LIB_SWSCALE)
		if (LIBAVCODEC_LIB_AVCORE)
			set(LIBAVCODEC_LIBRARIES ${LIBAVCODEC_LIBRARIES} ${LIBAVCODEC_LIB_AVCORE})
		endif (LIBAVCODEC_LIB_AVCORE)
	endif (LIBAVCODEC_LIB_AVCODEC)
endif (LIBAVCODEC_OLD OR LIBAVCODEC_NEW)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(LibAVCodec DEFAULT_MSG LIBAVCODEC_INCLUDE_DIRS LIBAVCODEC_LIBRARIES)

