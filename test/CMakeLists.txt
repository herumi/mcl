# Tests
set(MCL_TEST_BASE fp_test ec_test fp_util_test window_method_test elgamal_test bls12_test
	fp_tower_test gmp_test bn_test glv_test static_init_test)
foreach(base IN ITEMS ${MCL_TEST_BASE})
	add_executable(${base} ${base}.cpp)
	target_link_libraries(${base} PRIVATE mcl::mcl)
	set_target_properties(${base} PROPERTIES
		CXX_STANDARD 11
		CXX_STANDARD_REQUIRED YES
		CXX_EXTENSIONS NO)
	target_compile_options(${base} PRIVATE ${MCL_COMPILE_OPTIONS})
	target_compile_definitions(${base} PRIVATE MCL_DONT_EXPORT)
	add_test(NAME ${base} COMMAND ${base})
endforeach()

# Tests for mclbnXXX
foreach(bit IN ITEMS 384_256) # 256 384
	add_executable(bn_c${bit}_test bn_c${bit}_test.cpp)
	target_link_libraries(bn_c${bit}_test PRIVATE mcl::mcl_st)
	set_target_properties(bn_c${bit}_test PROPERTIES
		CXX_STANDARD 11
		CXX_STANDARD_REQUIRED YES
		CXX_EXTENSIONS NO)
	target_compile_options(bn_c${bit}_test PRIVATE ${MCL_COMPILE_OPTIONS})
	target_compile_definitions(bn_c${bit}_test PRIVATE MCL_DONT_EXPORT)
	add_test(NAME bn_c${bit}_test COMMAND bn_c${bit}_test)
endforeach()

if(MCL_TEST_WITH_GMP)
	set(MCL_TEST_WITH_GMP bint_test vint_test)
	foreach(base IN ITEMS ${MCL_TEST_WITH_GMP})
		add_executable(${base} ${base}.cpp)
		target_link_libraries(${base} PRIVATE mcl::mcl)
		if(MSVC)
			target_link_libraries(${base} PUBLIC mcl::windows_specific)
		else()
			target_link_libraries(${base} PRIVATE GMP::GMPXX GMP::GMP)
		endif()
		set_target_properties(${base} PROPERTIES
			CXX_STANDARD 11
			CXX_STANDARD_REQUIRED YES
			CXX_EXTENSIONS NO)
		target_compile_options(${base} PRIVATE ${MCL_COMPILE_OPTIONS})
		target_compile_definitions(${base} PRIVATE MCL_DONT_EXPORT)
		add_test(NAME ${base} COMMAND ${base})
	endforeach()
endif()
