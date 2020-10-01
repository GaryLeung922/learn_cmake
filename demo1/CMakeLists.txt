# CMake 最低版本的要求
cmake_minimum_required(VERSION 3.15)

# 项目信息
project(learn_cmake)

set(CMAKE_CXX_STANDARD 14)

# 指定生成目标
add_executable(learn_cmake main.cpp ../demo2/main.cpp ../demo2/MathFunctions.h ../demo2/MathFunctions.cpp)