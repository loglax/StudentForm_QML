cmake_minimum_required(VERSION 3.14)
project(StudentForm_GTest_2)
 
set(CMAKE_CXX_STANDARD 11)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_PREFIX_PATH "C:/Qt/5.14.2/mingw73_64/lib/cmake")  # Update as needed
 
find_package(Qt5 REQUIRED COMPONENTS Core Gui)
 
add_subdirectory(googletest)
 
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/googletest/googletest/include)
 
add_executable(student_gtests
    studentmodel_test.cpp
    studentmodel.cpp
    studentmodel.h
)
 
target_link_libraries(student_gtests
    Qt5::Core
    Qt5::Gui
    gtest
)
 
set_target_properties(student_gtests PROPERTIES
    AUTOMOC ON
)