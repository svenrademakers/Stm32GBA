cmake_minimum_required(VERSION 3.8.2)
include(Stixx/cmake_helpers/EnableCXX17.cmake)

option(MICROTESTS "Build micro tests" ON)

add_subdirectory(Stixx)

add_library(GbaEmulator GbaEmulator.hpp GbaEmulator.cpp)
EnableCXX17(GbaEmulator)

target_include_directories(GbaEmulator
	PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		$<INSTALL_INTERFACE:GbaEmulator>)
		
target_link_libraries(GbaEmulator Stixx)

if(MICROTESTS)
	include(Stixx/cmake_helpers/AddMicroTest.cmake)
	AddMicroTest(GbaEmulator ${CMAKE_CURRENT_SOURCE_DIR}/test/TestGbaSimulator.cpp)
		
	if(MSVC)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17")
	endif(MSVC)
endif()
