cmake_minimum_required(VERSION 3.10.2)

project("sub")

add_library(
  sub
  src/sub.cpp
)

target_link_libraries( 
  sub
)
