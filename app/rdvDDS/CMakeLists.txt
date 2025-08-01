cmake_minimum_required(VERSION 3.16)

project(rdvDDS VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)

include_directories(${CMAKE_HOME_DIRECTORY})

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

find_package(DDS REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup()

qt_add_executable(apprdvDDS
    main.cpp
)

qt_add_qml_module(apprdvDDS
    URI rdv.dds
    VERSION 1.0
    QML_FILES Main.qml
    SOURCES qrtiddshandler.h qrtiddshandler.cpp
    SOURCES qrtidds.h qrtidds.cpp
    SOURCES qrtiddslistener.h qrtiddslistener.cpp
    RESOURCES qml.qrc
)

set_target_properties(apprdvDDS PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(apprdvDDS PUBLIC RTI_WIN32)
target_compile_definitions(apprdvDDS PUBLIC NDDS_DLL_VARIABLE)

target_include_directories(apprdvDDS PRIVATE ${DDS_INCLUDE_DIRS})

target_link_libraries(apprdvDDS PRIVATE ${DDS_LIBRARIES})
target_link_libraries(apprdvDDS PRIVATE Qt6::Quick)
target_link_libraries(apprdvDDS PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS apprdvDDS
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
