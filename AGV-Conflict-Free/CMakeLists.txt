cmake_minimum_required(VERSION 3.16)

project(AGV-Conflict-Free VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets Core Sql)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Core Sql)

set(PROJECT_SOURCES
        main.cpp
        mainwindow.cpp
        mainwindow.h
        mainwindow.ui
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(AGV-Conflict-Free
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        PortSimulation.h
        DecisionVariables.h
        lowerbound.h lowerbound.cpp
        initialsolution.h initialsolution.cpp
        bbapproach.h bbapproach.cpp
        BBDefs.h
        DATAFILE.h
        DATAFILE.cpp
        PortSimulation.cpp
        equipments.h equipments.cpp
        portlayout.h portlayout.cpp
        DecisionVariables.cpp
        containerjobs.h containerjobs.cpp containerjobs.ui
        connection.h
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET AGV-Conflict-Free APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(AGV-Conflict-Free SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(AGV-Conflict-Free
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(AGV-Conflict-Free
    PRIVATE Qt${QT_VERSION_MAJOR}::Widgets
    PRIVATE Qt6::Core
    PRIVATE Qt6::Sql
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.AGV-Conflict-Free)
endif()
set_target_properties(AGV-Conflict-Free PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS AGV-Conflict-Free
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(AGV-Conflict-Free)
endif()
