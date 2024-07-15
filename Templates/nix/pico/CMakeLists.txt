set(CMAKE_EXPORT_COMPILE_COMMANDS
    ON
    CACHE INTERNAL "")

set(PROJECT simplest)
cmake_minimum_required(VERSION 3.13)

# initialize the SDK based on PICO_SDK_PATH note: this must happen before
# project()
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(my_project)

project(${PROJECT} C CXX ASM)

# Avoid building 'pioasm'
add_executable(Pioasm IMPORTED)
set_property(TARGET Pioasm PROPERTY IMPORTED_LOCATION $ENV{PICO_SDK_BIN}/pioasm)
set(Pioasm_FOUND 1)

# Avoid building 'elf2uf2'
add_executable(ELF2UF2 IMPORTED)
set_property(TARGET ELF2UF2 PROPERTY IMPORTED_LOCATION
                                     $ENV{PICO_SDK_BIN}/elf2uf2)
set(ELF2UF2_FOUND 1)

# initialize the Raspberry Pi Pico SDK
pico_sdk_init()

add_executable(hello_usb hello_usb.c)

# pull in common dependencies
target_link_libraries(hello_usb pico_stdlib)

# enable usb output, disable uart output
pico_enable_stdio_usb(hello_usb 1)
pico_enable_stdio_uart(hello_usb 0)

# create map/bin/hex/uf2 file etc.
pico_add_extra_outputs(hello_usb)
