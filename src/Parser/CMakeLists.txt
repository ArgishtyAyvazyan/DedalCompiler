project(Parser)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


find_program(LEX_EXE
    flex
)
if(LEX_EXE STREQUAL "LEX_EXE-NOTFOUND")
    message(FATAL_ERROR "dear user, plase install flex!")
endif(LEX_EXE STREQUAL "LEX_EXE-NOTFOUND")

find_program(YACC_EXE
    bison
)
if(YACC_EXE STREQUAL "YACC_EXE-NOTFOUND")
    message(FATAL_ERROR "dear user, plase install bison!")
endif(YACC_EXE STREQUAL "YACC_EXE-NOTFOUND")

# reuseable cmake macro for yacc
MACRO(YACC_FILE _filename)
    GET_FILENAME_COMPONENT(_basename ${_filename} NAME_WE)
    ADD_CUSTOM_COMMAND(
        OUTPUT  ${CMAKE_CURRENT_BINARY_DIR}/${_basename}.cpp
                ${CMAKE_CURRENT_BINARY_DIR}/${_basename}.h
        COMMAND ${YACC_EXE} -d -y
                --output=${_basename}.cpp
                ${CMAKE_CURRENT_SOURCE_DIR}/${_filename}
        DEPENDS ${_filename}
    )
ENDMACRO(YACC_FILE)

# reuseable cmake macro for lex
MACRO(LEX_FILE _filename)
    GET_FILENAME_COMPONENT(_basename ${_filename} NAME_WE)
    ADD_CUSTOM_COMMAND(
        OUTPUT  ${CMAKE_CURRENT_BINARY_DIR}/${_basename}.cpp
        COMMAND ${LEX_EXE}
                -o${_basename}.cpp
                ${CMAKE_CURRENT_SOURCE_DIR}/${_filename}
        DEPENDS ${_filename} )
ENDMACRO(LEX_FILE)

YACC_FILE(Parser.y)
LEX_FILE(Lexer.l)


add_library(Parser_lib STATIC Parser.cpp Lexer.cpp CParser.cpp CParserHelper.cpp)

# INTERFACE targets only have INTERFACE properties
target_include_directories(Parser_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(Parser_lib PRIVATE Generic_lib UserOutWriter_lib Core_lib)

target_compile_features(Parser_lib INTERFACE cxx_std_17)
