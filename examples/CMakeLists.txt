apply_include_paths("${EMIPLIB_INTERNAL_INCLUDES}")
apply_include_paths("${EMIPLIB_EXTERNAL_INCLUDES}")

foreach(IDX avsession feedbackexample multiplesoundfileplayer simplechain soundfileplayer soundrecorder pushtotalk
	    pushtotalk2 soundvolume audiosession)
	add_executable(${IDX} ${IDX}.cpp)
	if (NOT MSVC OR EMIPLIB_COMPILE_STATIC)
		target_link_libraries(${IDX} emiplib-static ${EMIPLIB_LINK_LIBS})
	else ()
		target_link_libraries(${IDX} emiplib-shared ${EMIPLIB_LINK_LIBS})
	endif ()
endforeach(IDX)

