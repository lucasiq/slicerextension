#
# This file has been primarily designed for the purpose of Slicer extension development.
#
# This file is configured by Slicer and used by UseSlicer.cmake module
# to load Slicer's settings for an external project. External projects
# can use these setting to build new modules against a Slicer build tree.
#
#

#
# When manually building extension on macOS, in addition to the usual configure
# option (CMAKE_BUILD_TYPE, ...), the developer is also expected to
# configure it passing the variables:
#   CMAKE_OSX_ARCHITECTURES
#   CMAKE_OSX_DEPLOYMENT_TARGET
#   CMAKE_OSX_SYSROOT
# The value of these variables should match the one used to
# configure the associated Slicer build tree. These values can be
# retrieved looking at the CMakeCache.txt file located in the Slicer
# build tree.
#
# To simplify the task of manually building out-of-source modules or extensions,
# the developer could include the following statement at the top of both the main
# CMakeLists.txt of the extension and also at the top of each module CMakeLists.txt
# bundled within the extension.
# Doing so will ensure that either the extension or each bundled module could be
# built in a standalone fashion very easily without passing extra option
# at configure time:
#
#  find_package(Slicer COMPONENTS ConfigurePrerequisites REQUIRED)
#
#  project(Foo)
#
#  [...]
#
#  find_package(Slicer REQUIRED)
#  include(${Slicer_USE_FILE})
#  [...]


# Extension support can be disabled by either
#  (1) setting Slicer_DONT_USE_EXTENSION to TRUE or
#  (2) calling find_package(Slicer COMPONENTS NoExtensionSupport [...] REQUIRED)


# --------------------------------------------------------------------------
#  COMPONENTS                | CMAKE VARIABLE(S)
# --------------------------------------------------------------------------
#  NoExtensionSupport        | Slicer_USE_NOEXTENSIONSUPPORT
#                            | Slicer_DONT_USE_EXTENSION
# --------------------------------------------------------------------------
#  ConfigurePrerequisites    | Slicer_USE_CONFIGUREPREREQUISITES
# --------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.13.4)

foreach(component NoExtensionSupport ConfigurePrerequisites)
  string(TOUPPER ${component} _COMPONENT)
  set(Slicer_USE_${_COMPONENT} 0)
endforeach()

if(Slicer_FIND_COMPONENTS)
  foreach(component ${Slicer_FIND_COMPONENTS})
    string(TOUPPER ${component} _COMPONENT)
    set(Slicer_USE_${_COMPONENT} 1)
  endforeach()

  set(Slicer_DONT_USE_EXTENSION ${Slicer_USE_NOEXTENSIONSUPPORT})
endif()

if(NOT DEFINED Slicer_DONT_USE_EXTENSION)
  set(Slicer_DONT_USE_EXTENSION FALSE)
endif()

if(NOT DEFINED Slicer_USE_CONFIGUREPREREQUISITES)
  set(Slicer_USE_CONFIGUREPREREQUISITES FALSE)
endif()

if(Slicer_SOURCE_DIR)
  return()
endif()

# --------------------------------------------------------------------------
set(Slicer_CMAKE_DIR "C:/D/S4/CMake")
set(Slicer_EXTENSIONS_CMAKE_DIR "C:/D/S4/Extensions/CMake")
set(vtkAddon_CMAKE_DIR "C:/D/S4R/vtkAddon/CMake")

# Update CMAKE_MODULE_PATH
set(CMAKE_MODULE_PATH
  ${Slicer_CMAKE_DIR}
  ${Slicer_EXTENSIONS_CMAKE_DIR}
  ${vtkAddon_CMAKE_DIR}
  ${CMAKE_MODULE_PATH}
  )

# --------------------------------------------------------------------------
if(Slicer_USE_CONFIGUREPREREQUISITES)
  if(NOT Slicer_PREREQUISITES_CONFIGURED)
    if(DEFINED CMAKE_PROJECT_NAME)
      message(FATAL_ERROR
        "To be effective, 'find_package(Slicer COMPONENTS ConfigurePrerequisites)' should "
        "be placed before any calls to 'project()' or 'enable_language()'."
        "Before re-configuring, make sure to clean the build directory: ${CMAKE_CURRENT_BINARY_DIR}"
        )
    endif()
    # Note: By setting CMAKE_OSX_* variables before any enable_language() or project() calls,
    #       we ensure that the bitness will be properly detected.
    include(SlicerInitializeOSXVariables)
    set(Slicer_PREREQUISITES_CONFIGURED 1 CACHE INTERNAL "True if component 'ConfigurePrerequisites' has already been included")
  endif()
  return()
endif()

# --------------------------------------------------------------------------
# Slicer options
# --------------------------------------------------------------------------
set(Slicer_DEFAULT_BUILD_TYPE "Debug")
set(Slicer_USE_NUMPY "ON")
set(Slicer_USE_SCIPY "ON")
set(Slicer_USE_PYTHONQT "ON")
set(Slicer_USE_QtTesting "ON")
set(Slicer_USE_SimpleITK "ON")
set(Slicer_BUILD_BRAINSTOOLS "ON")
set(Slicer_BUILD_CLI_SUPPORT "ON")
set(Slicer_BUILD_DICOM_SUPPORT "ON")
set(Slicer_BUILD_DIFFUSION_SUPPORT "ON")
set(Slicer_BUILD_EXTENSIONMANAGER_SUPPORT "ON")
set(Slicer_BUILD_PARAMETERSERIALIZER_SUPPORT "OFF")
set(Slicer_BUILD_TESTING "ON")
set(Slicer_BUILD_WEBENGINE_SUPPORT "ON")

set(Slicer_REQUIRED_QT_VERSION "5.15")
set(Slicer_REQUIRED_QT_MODULES "Core;Widgets;Multimedia;Network;OpenGL;PrintSupport;UiTools;Xml;XmlPatterns;Svg;Sql;WebEngine;WebEngineWidgets;WebChannel;Script;Test")

# Launcher command
set(Slicer_USE_CTKAPPLAUNCHER "ON")
set(Slicer_LAUNCHER_EXECUTABLE "C:/D/S4R/Slicer-build/Slicer.exe")
set(Slicer_LAUNCH_COMMAND "C:/D/S4R/Slicer-build/Slicer.exe;--launch")
set(SEM_LAUNCH_COMMAND "C:/D/S4R/Slicer-build/Slicer.exe;--launch")

# VCS commands
set(Subversion_SVN_EXECUTABLE "Subversion_SVN_EXECUTABLE-NOTFOUND" CACHE FILEPATH "subversion command line client")
set(GIT_EXECUTABLE "C:/Program Files/Git/bin/git.exe"  CACHE FILEPATH "Git command line client")

# Slicer working copy Revision, URL and Root
set(Slicer_REVISION "30175")
set(Slicer_WC_REVISION "8eaa925")
set(Slicer_WC_REVISION_HASH "8eaa925")
set(Slicer_WC_URL "https://github.com/Slicer/Slicer.git")
set(Slicer_WC_ROOT "https://github.com/Slicer/Slicer.git")

# Note that the variable "Slicer_REVISION" can be forced to
# a particular value by setting environment variable of the same name.
# This is particularly useful when the revision of Slicer changes because of
# updates to the extension build system and the extensions still need to be
# built against the revision prior to the update.
if(NOT "$ENV{Slicer_REVISION}" STREQUAL "")
  set(Slicer_REVISION "$ENV{Slicer_REVISION}")
  message(STATUS "SlicerConfig: Forcing Slicer_REVISION to '${Slicer_REVISION}'")
endif()

# Slicer os and architecture
set(Slicer_OS "win")
set(Slicer_ARCHITECTURE "amd64")

# Slicer main application
set(Slicer_MAIN_PROJECT "SlicerApp")
set(Slicer_MAIN_PROJECT_APPLICATION_NAME "Slicer")

# License and Readme file
set(Slicer_LICENSE_FILE "C:/D/S4/License.txt")
set(Slicer_README_FILE "C:/D/S4/README.txt")

# Test templates directory
set(Slicer_CXX_MODULE_TEST_TEMPLATES_DIR "C:/D/S4/Base/QTGUI/Testing/Cxx")
set(Slicer_PYTHON_MODULE_TEST_TEMPLATES_DIR "C:/D/S4/Base/QTCore/Testing/Python")

# Script for generating <Extension>Config.cmake
set(Slicer_EXTENSION_GENERATE_CONFIG "C:/D/S4/CMake/SlicerExtensionGenerateConfig.cmake")

# Path to extension CPack script
set(Slicer_EXTENSION_CPACK "C:/D/S4/CMake/SlicerExtensionCPack.cmake")
set(Slicer_EXTENSION_CPACK_BUNDLE_FIXUP "C:/D/S4/CMake/SlicerExtensionCPackBundleFixup.cmake.in")
set(Slicer_EXTENSIONS_DIRNAME "Extensions-30175")

# Whether Slicer was built with modules and CLI support.
set(Slicer_BUILD_CLI "ON")
set(Slicer_BUILD_QTLOADABLEMODULES "ON")
set(Slicer_BUILD_QTSCRIPTEDMODULES "ON")

# Whether Slicer was built with shared libraries.
set(Slicer_BUILD_SHARED "ON")
set(Slicer_LIBRARY_PROPERTIES "")

# Export header for BuildModuleLogic and BuildQTModule
set(Slicer_EXPORT_HEADER_TEMPLATE "C:/D/S4/CMake/qSlicerExport.h.in")
set(Slicer_LOGOS_RESOURCE "C:/D/S4/Resources/qSlicer.qrc")

# Slicer home (top of the tree)
set(Slicer_HOME "C:/D/S4R/Slicer-build")

# Slicer binary directory
set(Slicer_BINARY_DIR "C:/D/S4R/Slicer-build")

# Slicer Core library
set(Slicer_CORE_LIBRARY qSlicerBaseQTCore)

# Slicer GUI library
set(Slicer_GUI_LIBRARY qSlicerBaseQTApp)

# MRML libraries - This variable regroup all related MRML libraries
set(MRML_LIBRARIES MRMLCore;MRMLLogic;MRMLDisplayableManager;MRMLCLI)

# Slicer Libs VTK wrapped libraries
set(Slicer_Libs_VTK_WRAPPED_LIBRARIES "vtkSegmentationCore;vtkTeem;vtkITK;MRMLCore;MRMLLogic;vtkAddon;MRMLDisplayableManager;MRMLCLI")

# Slicer VTK version
set(Slicer_VTK_VERSION_MAJOR "8")

# Slicer include directories for module

set(qSlicerCamerasModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Cameras;C:/D/S4R/Slicer-build/Modules/Loadable/Cameras")
set(qSlicerUnitsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Units;C:/D/S4R/Slicer-build/Modules/Loadable/Units")
set(qSlicerTerminologiesModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Terminologies;C:/D/S4R/Slicer-build/Modules/Loadable/Terminologies")
set(qSlicerColorsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Colors;C:/D/S4R/Slicer-build/Modules/Loadable/Colors")
set(qSlicerSubjectHierarchyModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/SubjectHierarchy;C:/D/S4R/Slicer-build/Modules/Loadable/SubjectHierarchy")
set(qSlicerAnnotationsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Annotations;C:/D/S4R/Slicer-build/Modules/Loadable/Annotations")
set(qSlicerMarkupsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Markups;C:/D/S4R/Slicer-build/Modules/Loadable/Markups")
set(qSlicerTransformsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Transforms;C:/D/S4R/Slicer-build/Modules/Loadable/Transforms")
set(qSlicerDataModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Data;C:/D/S4R/Slicer-build/Modules/Loadable/Data")
set(qSlicerDoubleArraysModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/DoubleArrays;C:/D/S4R/Slicer-build/Modules/Loadable/DoubleArrays")
set(qSlicerModelsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Models;C:/D/S4R/Slicer-build/Modules/Loadable/Models")
set(qSlicerPlotsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Plots;C:/D/S4R/Slicer-build/Modules/Loadable/Plots")
set(qSlicerSceneViewsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/SceneViews;C:/D/S4R/Slicer-build/Modules/Loadable/SceneViews")
set(qSlicerSegmentationsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Segmentations;C:/D/S4R/Slicer-build/Modules/Loadable/Segmentations")
set(qSlicerSequencesModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Sequences;C:/D/S4R/Slicer-build/Modules/Loadable/Sequences")
set(qSlicerWelcomeModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/SlicerWelcome;C:/D/S4R/Slicer-build/Modules/Loadable/SlicerWelcome")
set(qSlicerTablesModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Tables;C:/D/S4R/Slicer-build/Modules/Loadable/Tables")
set(qSlicerTextsModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Texts;C:/D/S4R/Slicer-build/Modules/Loadable/Texts")
set(qSlicerReformatModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Reformat;C:/D/S4R/Slicer-build/Modules/Loadable/Reformat")
set(qSlicerViewControllersModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/ViewControllers;C:/D/S4R/Slicer-build/Modules/Loadable/ViewControllers")
set(qSlicerVolumesModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Volumes;C:/D/S4R/Slicer-build/Modules/Loadable/Volumes")
set(qSlicerVolumeRenderingModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/VolumeRendering;C:/D/S4R/Slicer-build/Modules/Loadable/VolumeRendering")
set(qSlicerCropVolumeModule_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/CropVolume;C:/D/S4R/Slicer-build/Modules/Loadable/CropVolume")
set(qSlicerTemplateKeyModule_INCLUDE_DIRS
  "C:/D/S4/Utilities/Templates/Modules/LoadableCustomMarkups;C:/D/S4R/Slicer-build/Utilities/Templates/Modules/LoadableCustomMarkups")
set(qSlicerMultiVolumeExplorerModule_INCLUDE_DIRS
  "C:/D/S4R/MultiVolumeExplorer;C:/D/S4R/Slicer-build/E/MultiVolumeExplorer")
set(qSlicerDataStoreModule_INCLUDE_DIRS
  "C:/D/S4R/DataStore/DataStore;C:/D/S4R/Slicer-build/E/DataStore/DataStore")
set(qSlicerDynamicModelerModule_INCLUDE_DIRS
  "C:/D/S4R/SurfaceToolbox/DynamicModeler;C:/D/S4R/Slicer-build/E/SurfaceToolbox/DynamicModeler")

# Slicer include directories for module logic

set(vtkSlicerCamerasModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Cameras/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Cameras/Logic")
set(vtkSlicerUnitsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Units/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Units/Logic")
set(vtkSlicerTerminologiesModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Terminologies/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Terminologies/Logic")
set(vtkSlicerColorsModuleVTKWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Colors/VTKWidgets;C:/D/S4R/Slicer-build/Modules/Loadable/Colors/VTKWidgets")
set(vtkSlicerColorsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Colors/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Colors/Logic")
set(vtkSlicerSubjectHierarchyModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/SubjectHierarchy/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/SubjectHierarchy/Logic;C:/D/S4/Base/Logic;C:/D/S4R/Slicer-build/Base/Logic;C:/D/S4/Base/QTCore;C:/D/S4R/Slicer-build/Base/QTCore;C:/D/S4/Base/QTGUI;C:/D/S4R/Slicer-build/Base/QTGUI;C:/D/S4/Base/QTCLI;C:/D/S4R/Slicer-build/Base/QTCLI;C:/D/S4/Base/CLI;C:/D/S4R/Slicer-build/Base/CLI;C:/D/S4/Base/CLI/Testing;C:/D/S4/Modules/Core;C:/D/S4R/Slicer-build/Modules/Core;C:/D/S4/Base/QTApp;C:/D/S4R/Slicer-build/Base/QTApp")
set(vtkSlicerAnnotationsModuleVTKWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Annotations/VTKWidgets;C:/D/S4R/Slicer-build/Modules/Loadable/Annotations/VTKWidgets")
set(vtkSlicerAnnotationsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Annotations/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Annotations/Logic")
set(vtkSlicerAnnotationsModuleMRMLDisplayableManager_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Annotations/MRMLDM;C:/D/S4R/Slicer-build/Modules/Loadable/Annotations/MRMLDM")
set(vtkSlicerMarkupsModuleVTKWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Markups/VTKWidgets;C:/D/S4R/Slicer-build/Modules/Loadable/Markups/VTKWidgets")
set(vtkSlicerMarkupsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Markups/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Markups/Logic")
set(vtkSlicerMarkupsModuleMRMLDisplayableManager_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Markups/MRMLDM;C:/D/S4R/Slicer-build/Modules/Loadable/Markups/MRMLDM")
set(vtkSlicerTransformsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Transforms/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Transforms/Logic")
set(vtkSlicerTransformsModuleMRMLDisplayableManager_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Transforms/MRMLDM;C:/D/S4R/Slicer-build/Modules/Loadable/Transforms/MRMLDM")
set(vtkSlicerDataModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Data/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Data/Logic")
set(vtkSlicerDoubleArraysModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/DoubleArrays/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/DoubleArrays/Logic")
set(vtkSlicerModelsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Models/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Models/Logic")
set(vtkSlicerPlotsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Plots/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Plots/Logic")
set(vtkSlicerSceneViewsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/SceneViews/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/SceneViews/Logic")
set(vtkSlicerSegmentationsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Segmentations/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Segmentations/Logic")
set(vtkSlicerSegmentationsModuleMRMLDisplayableManager_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Segmentations/MRMLDM;C:/D/S4R/Slicer-build/Modules/Loadable/Segmentations/MRMLDM")
set(vtkSlicerSequencesModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Sequences/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Sequences/Logic")
set(vtkSlicerTablesModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Tables/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Tables/Logic")
set(vtkSlicerTextsModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Texts/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Texts/Logic")
set(vtkSlicerReformatModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Reformat/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Reformat/Logic")
set(vtkSlicerViewControllersModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/ViewControllers/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/ViewControllers/Logic")
set(vtkSlicerVolumesModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Volumes/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/Volumes/Logic")
set(vtkSlicerVolumeRenderingModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/VolumeRendering/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/VolumeRendering/Logic")
set(vtkSlicerVolumeRenderingModuleMRMLDisplayableManager_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/VolumeRendering/MRMLDM;C:/D/S4R/Slicer-build/Modules/Loadable/VolumeRendering/MRMLDM")
set(vtkSlicerCropVolumeModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/CropVolume/Logic;C:/D/S4R/Slicer-build/Modules/Loadable/CropVolume/Logic")
set(vtkSlicerDataProbeModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Scripted/DataProbe/Logic;C:/D/S4R/Slicer-build/Modules/Scripted/DataProbe/Logic")
set(vtkSlicerEditorLibModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Scripted/EditorLib/Logic;C:/D/S4R/Slicer-build/Modules/Scripted/EditorLib/Logic")
set(vtkSlicerDICOMLibModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Modules/Scripted/DICOMLib/Logic;C:/D/S4R/Slicer-build/Modules/Scripted/DICOMLib/Logic")
set(vtkSlicerTemplateKeyModuleVTKWidgets_INCLUDE_DIRS
  "C:/D/S4/Utilities/Templates/Modules/LoadableCustomMarkups/VTKWidgets;C:/D/S4R/Slicer-build/Utilities/Templates/Modules/LoadableCustomMarkups/VTKWidgets")
set(vtkSlicerTemplateKeyModuleLogic_INCLUDE_DIRS
  "C:/D/S4/Utilities/Templates/Modules/LoadableCustomMarkups/Logic;C:/D/S4R/Slicer-build/Utilities/Templates/Modules/LoadableCustomMarkups/Logic")
set(vtkSlicerMultiVolumeExplorerModuleLogic_INCLUDE_DIRS
  "C:/D/S4R/MultiVolumeExplorer/Logic;C:/D/S4R/Slicer-build/E/MultiVolumeExplorer/Logic")
set(vtkSlicerDataStoreModuleLogic_INCLUDE_DIRS
  "C:/D/S4R/DataStore/DataStore/Logic;C:/D/S4R/Slicer-build/E/DataStore/DataStore/Logic")
set(vtkSlicerDynamicModelerModuleLogic_INCLUDE_DIRS
  "C:/D/S4R/SurfaceToolbox/DynamicModeler/Logic;C:/D/S4R/Slicer-build/E/SurfaceToolbox/DynamicModeler/Logic")

# Slicer include directories for module mrml

set(vtkSlicerAnnotationsModuleMRML_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Annotations/MRML;C:/D/S4R/Slicer-build/Modules/Loadable/Annotations/MRML")
set(vtkSlicerMarkupsModuleMRML_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Markups/MRML;C:/D/S4R/Slicer-build/Modules/Loadable/Markups/MRML")
set(vtkSlicerSegmentationsModuleMRML_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Segmentations/MRML;C:/D/S4R/Slicer-build/Modules/Loadable/Segmentations/MRML")
set(vtkSlicerSequencesModuleMRML_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Sequences/MRML;C:/D/S4R/Slicer-build/Modules/Loadable/Sequences/MRML")
set(vtkSlicerVolumeRenderingModuleMRML_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/VolumeRendering/MRML;C:/D/S4R/Slicer-build/Modules/Loadable/VolumeRendering/MRML")
set(vtkSlicerCropVolumeModuleMRML_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/CropVolume/MRML;C:/D/S4R/Slicer-build/Modules/Loadable/CropVolume/MRML")
set(vtkSlicerTemplateKeyModuleMRML_INCLUDE_DIRS
  "C:/D/S4/Utilities/Templates/Modules/LoadableCustomMarkups/MRML;C:/D/S4R/Slicer-build/Utilities/Templates/Modules/LoadableCustomMarkups/MRML")
set(vtkSlicerMultiVolumeExplorerModuleMRML_INCLUDE_DIRS
  "C:/D/S4R/MultiVolumeExplorer/MRML;C:/D/S4R/Slicer-build/E/MultiVolumeExplorer/MRML")
set(vtkSlicerDynamicModelerModuleMRML_INCLUDE_DIRS
  "C:/D/S4R/SurfaceToolbox/DynamicModeler/MRML;C:/D/S4R/Slicer-build/E/SurfaceToolbox/DynamicModeler/MRML")

# Slicer include directories for module Widget

set(qSlicerUnitsModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Units/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Units/Widgets")
set(qSlicerTerminologiesModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Terminologies/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Terminologies/Widgets")
set(qSlicerSubjectHierarchyModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/SubjectHierarchy/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/SubjectHierarchy/Widgets")
set(qSlicerAnnotationsModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Annotations/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Annotations/Widgets")
set(qSlicerMarkupsModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Markups/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Markups/Widgets")
set(qSlicerTransformsModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Transforms/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Transforms/Widgets")
set(qSlicerModelsModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Models/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Models/Widgets")
set(qSlicerPlotsModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Plots/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Plots/Widgets")
set(qSlicerSegmentationsModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Segmentations/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Segmentations/Widgets")
set(qSlicerSequencesModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Sequences/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Sequences/Widgets")
set(qSlicerTablesModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Tables/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Tables/Widgets")
set(qSlicerTextsModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Texts/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Texts/Widgets")
set(qSlicerVolumesModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/Volumes/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/Volumes/Widgets")
set(qSlicerVolumeRenderingModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Loadable/VolumeRendering/Widgets;C:/D/S4R/Slicer-build/Modules/Loadable/VolumeRendering/Widgets")
set(qSlicerDICOMLibModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Modules/Scripted/DICOMLib/Widgets;C:/D/S4R/Slicer-build/Modules/Scripted/DICOMLib/Widgets")
set(qSlicerTemplateKeyModuleWidgets_INCLUDE_DIRS
  "C:/D/S4/Utilities/Templates/Modules/LoadableCustomMarkups/Widgets;C:/D/S4R/Slicer-build/Utilities/Templates/Modules/LoadableCustomMarkups/Widgets")
set(qSlicerDataStoreModuleWidgets_INCLUDE_DIRS
  "C:/D/S4R/DataStore/DataStore/Widgets;C:/D/S4R/Slicer-build/E/DataStore/DataStore/Widgets")

# See vtkAddon/CMake/vtkMacroKitPythonWrap.cmake
set(Slicer_VTK_WRAP_HIERARCHY_DIR "C:/D/S4R/Slicer-build")

# Slicer VTK wrap hierarchy files

set(vtkAddon_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkAddonHierarchy.txt")
set(vtkTeem_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkTeemHierarchy.txt")
set(vtkITK_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkITKHierarchy.txt")
set(vtkSegmentationCore_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSegmentationCoreHierarchy.txt")
set(MRMLCore_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/MRMLCoreHierarchy.txt")
set(MRMLCLI_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/MRMLCLIHierarchy.txt")
set(MRMLLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/MRMLLogicHierarchy.txt")
set(MRMLDisplayableManager_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/MRMLDisplayableManagerHierarchy.txt")
set(SlicerBaseLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/SlicerBaseLogicHierarchy.txt")
set(qSlicerBaseQTCLI_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/qSlicerBaseQTCLIHierarchy.txt")
set(vtkSlicerCamerasModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerCamerasModuleLogicHierarchy.txt")
set(vtkSlicerUnitsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerUnitsModuleLogicHierarchy.txt")
set(vtkSlicerTerminologiesModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerTerminologiesModuleLogicHierarchy.txt")
set(vtkSlicerColorsModuleVTKWidgets_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerColorsModuleVTKWidgetsHierarchy.txt")
set(vtkSlicerColorsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerColorsModuleLogicHierarchy.txt")
set(vtkSlicerSubjectHierarchyModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerSubjectHierarchyModuleLogicHierarchy.txt")
set(vtkSlicerAnnotationsModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerAnnotationsModuleMRMLHierarchy.txt")
set(vtkSlicerAnnotationsModuleVTKWidgets_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerAnnotationsModuleVTKWidgetsHierarchy.txt")
set(vtkSlicerAnnotationsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerAnnotationsModuleLogicHierarchy.txt")
set(vtkSlicerAnnotationsModuleMRMLDisplayableManager_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerAnnotationsModuleMRMLDisplayableManagerHierarchy.txt")
set(vtkSlicerMarkupsModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerMarkupsModuleMRMLHierarchy.txt")
set(vtkSlicerMarkupsModuleVTKWidgets_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerMarkupsModuleVTKWidgetsHierarchy.txt")
set(vtkSlicerMarkupsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerMarkupsModuleLogicHierarchy.txt")
set(vtkSlicerMarkupsModuleMRMLDisplayableManager_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerMarkupsModuleMRMLDisplayableManagerHierarchy.txt")
set(vtkSlicerTransformsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerTransformsModuleLogicHierarchy.txt")
set(vtkSlicerTransformsModuleMRMLDisplayableManager_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerTransformsModuleMRMLDisplayableManagerHierarchy.txt")
set(vtkSlicerDataModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerDataModuleLogicHierarchy.txt")
set(vtkSlicerDoubleArraysModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerDoubleArraysModuleLogicHierarchy.txt")
set(vtkSlicerModelsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerModelsModuleLogicHierarchy.txt")
set(vtkSlicerPlotsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerPlotsModuleLogicHierarchy.txt")
set(vtkSlicerSceneViewsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerSceneViewsModuleLogicHierarchy.txt")
set(vtkSlicerSegmentationsModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerSegmentationsModuleMRMLHierarchy.txt")
set(vtkSlicerSegmentationsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerSegmentationsModuleLogicHierarchy.txt")
set(vtkSlicerSegmentationsModuleMRMLDisplayableManager_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerSegmentationsModuleMRMLDisplayableManagerHierarchy.txt")
set(vtkSlicerSequencesModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerSequencesModuleMRMLHierarchy.txt")
set(vtkSlicerSequencesModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerSequencesModuleLogicHierarchy.txt")
set(vtkSlicerTablesModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerTablesModuleLogicHierarchy.txt")
set(vtkSlicerTextsModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerTextsModuleLogicHierarchy.txt")
set(vtkSlicerReformatModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerReformatModuleLogicHierarchy.txt")
set(vtkSlicerViewControllersModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerViewControllersModuleLogicHierarchy.txt")
set(vtkSlicerVolumesModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerVolumesModuleLogicHierarchy.txt")
set(vtkSlicerVolumeRenderingModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerVolumeRenderingModuleMRMLHierarchy.txt")
set(vtkSlicerVolumeRenderingModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerVolumeRenderingModuleLogicHierarchy.txt")
set(vtkSlicerVolumeRenderingModuleMRMLDisplayableManager_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerVolumeRenderingModuleMRMLDisplayableManagerHierarchy.txt")
set(vtkSlicerCropVolumeModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerCropVolumeModuleMRMLHierarchy.txt")
set(vtkSlicerCropVolumeModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerCropVolumeModuleLogicHierarchy.txt")
set(vtkSlicerDataProbeModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerDataProbeModuleLogicHierarchy.txt")
set(vtkSlicerEditorLibModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerEditorLibModuleLogicHierarchy.txt")
set(vtkSlicerDICOMLibModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerDICOMLibModuleLogicHierarchy.txt")
set(vtkSlicerTemplateKeyModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerTemplateKeyModuleMRMLHierarchy.txt")
set(vtkSlicerTemplateKeyModuleVTKWidgets_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerTemplateKeyModuleVTKWidgetsHierarchy.txt")
set(vtkSlicerTemplateKeyModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerTemplateKeyModuleLogicHierarchy.txt")
set(vtkSlicerMultiVolumeExplorerModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerMultiVolumeExplorerModuleMRMLHierarchy.txt")
set(vtkSlicerMultiVolumeExplorerModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerMultiVolumeExplorerModuleLogicHierarchy.txt")
set(vtkSlicerDataStoreModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerDataStoreModuleLogicHierarchy.txt")
set(vtkSlicerDynamicModelerModuleMRML_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerDynamicModelerModuleMRMLHierarchy.txt")
set(vtkSlicerDynamicModelerModuleLogic_WRAP_HIERARCHY_FILE
  "C:/D/S4R/Slicer-build/vtkSlicerDynamicModelerModuleLogicHierarchy.txt")

# Slicer Libs include file directories.
set(Slicer_Libs_INCLUDE_DIRS "C:/D/S4/Libs/ITKFactoryRegistration;C:/D/S4R/Slicer-build/Libs/ITKFactoryRegistration;C:/D/S4R/vtkAddon;C:/D/S4R/Slicer-build/Libs/vtkAddon;C:/D/S4/Libs/vtkTeem;C:/D/S4R/Slicer-build/Libs/vtkTeem;C:/D/S4/Libs/vtkITK;C:/D/S4R/Slicer-build/Libs/vtkITK;C:/D/S4/Libs/vtkSegmentationCore;C:/D/S4R/Slicer-build/Libs/vtkSegmentationCore;C:/D/S4/Libs/MRML/Core;C:/D/S4R/Slicer-build/Libs/MRML/Core;C:/D/S4R/vtkAddon;C:/D/S4R/Slicer-build/Libs/vtkAddon;C:/D/S4/Libs/vtkSegmentationCore;C:/D/S4R/Slicer-build/Libs/vtkSegmentationCore;C:/D/S4/Libs/MRML/CLI;C:/D/S4R/Slicer-build/Libs/MRML/CLI;C:/D/S4/Libs/RemoteIO;C:/D/S4R/Slicer-build/Libs/RemoteIO;C:/D/S4/Libs/MRML/Logic;C:/D/S4R/Slicer-build/Libs/MRML/Logic;C:/D/S4/Libs/MRML/DisplayableManager;C:/D/S4R/Slicer-build/Libs/MRML/DisplayableManager;C:/D/S4/Libs/MRML/IDImageIO;C:/D/S4R/Slicer-build/Libs/MRML/IDImageIO;C:/D/S4/Libs/MRML/Widgets;C:/D/S4R/Slicer-build/Libs/MRML/Widgets")

# Slicer Base include file directories.
set(Slicer_Base_INCLUDE_DIRS "C:/D/S4R/Slicer-build" "C:/D/S4/Base/Logic;C:/D/S4R/Slicer-build/Base/Logic;C:/D/S4/Base/QTCore;C:/D/S4R/Slicer-build/Base/QTCore;C:/D/S4/Base/QTGUI;C:/D/S4R/Slicer-build/Base/QTGUI;C:/D/S4/Base/QTCLI;C:/D/S4R/Slicer-build/Base/QTCLI;C:/D/S4/Base/CLI;C:/D/S4R/Slicer-build/Base/CLI;C:/D/S4/Base/CLI/Testing;C:/D/S4/Modules/Core;C:/D/S4R/Slicer-build/Modules/Core;C:/D/S4/Base/QTApp;C:/D/S4R/Slicer-build/Base/QTApp")

# Slicer Module logic include file directories.
set(Slicer_ModuleLogic_INCLUDE_DIRS "${vtkSlicerCamerasModuleLogic_INCLUDE_DIRS};${vtkSlicerUnitsModuleLogic_INCLUDE_DIRS};${vtkSlicerTerminologiesModuleLogic_INCLUDE_DIRS};${vtkSlicerColorsModuleVTKWidgets_INCLUDE_DIRS};${vtkSlicerColorsModuleLogic_INCLUDE_DIRS};${vtkSlicerSubjectHierarchyModuleLogic_INCLUDE_DIRS};${vtkSlicerAnnotationsModuleVTKWidgets_INCLUDE_DIRS};${vtkSlicerAnnotationsModuleLogic_INCLUDE_DIRS};${vtkSlicerAnnotationsModuleMRMLDisplayableManager_INCLUDE_DIRS};${vtkSlicerMarkupsModuleVTKWidgets_INCLUDE_DIRS};${vtkSlicerMarkupsModuleLogic_INCLUDE_DIRS};${vtkSlicerMarkupsModuleMRMLDisplayableManager_INCLUDE_DIRS};${vtkSlicerTransformsModuleLogic_INCLUDE_DIRS};${vtkSlicerTransformsModuleMRMLDisplayableManager_INCLUDE_DIRS};${vtkSlicerDataModuleLogic_INCLUDE_DIRS};${vtkSlicerDoubleArraysModuleLogic_INCLUDE_DIRS};${vtkSlicerModelsModuleLogic_INCLUDE_DIRS};${vtkSlicerPlotsModuleLogic_INCLUDE_DIRS};${vtkSlicerSceneViewsModuleLogic_INCLUDE_DIRS};${vtkSlicerSegmentationsModuleLogic_INCLUDE_DIRS};${vtkSlicerSegmentationsModuleMRMLDisplayableManager_INCLUDE_DIRS};${vtkSlicerSequencesModuleLogic_INCLUDE_DIRS};${vtkSlicerTablesModuleLogic_INCLUDE_DIRS};${vtkSlicerTextsModuleLogic_INCLUDE_DIRS};${vtkSlicerReformatModuleLogic_INCLUDE_DIRS};${vtkSlicerViewControllersModuleLogic_INCLUDE_DIRS};${vtkSlicerVolumesModuleLogic_INCLUDE_DIRS};${vtkSlicerVolumeRenderingModuleLogic_INCLUDE_DIRS};${vtkSlicerVolumeRenderingModuleMRMLDisplayableManager_INCLUDE_DIRS};${vtkSlicerCropVolumeModuleLogic_INCLUDE_DIRS};${vtkSlicerDataProbeModuleLogic_INCLUDE_DIRS};${vtkSlicerEditorLibModuleLogic_INCLUDE_DIRS};${vtkSlicerDICOMLibModuleLogic_INCLUDE_DIRS};${vtkSlicerTemplateKeyModuleVTKWidgets_INCLUDE_DIRS};${vtkSlicerTemplateKeyModuleLogic_INCLUDE_DIRS};${vtkSlicerMultiVolumeExplorerModuleLogic_INCLUDE_DIRS};${vtkSlicerDataStoreModuleLogic_INCLUDE_DIRS};${vtkSlicerDynamicModelerModuleLogic_INCLUDE_DIRS}"
  CACHE INTERNAL "Slicer Module logic includes" FORCE)

# Slicer Module MRML include file directories.
set(Slicer_ModuleMRML_INCLUDE_DIRS "${vtkSlicerAnnotationsModuleMRML_INCLUDE_DIRS};${vtkSlicerMarkupsModuleMRML_INCLUDE_DIRS};${vtkSlicerSegmentationsModuleMRML_INCLUDE_DIRS};${vtkSlicerSequencesModuleMRML_INCLUDE_DIRS};${vtkSlicerVolumeRenderingModuleMRML_INCLUDE_DIRS};${vtkSlicerCropVolumeModuleMRML_INCLUDE_DIRS};${vtkSlicerTemplateKeyModuleMRML_INCLUDE_DIRS};${vtkSlicerMultiVolumeExplorerModuleMRML_INCLUDE_DIRS};${vtkSlicerDynamicModelerModuleMRML_INCLUDE_DIRS}"
  CACHE INTERNAL "Slicer Module MRML includes" FORCE)

# Slicer Module Widgets include file directories.
set(Slicer_ModuleWidgets_INCLUDE_DIRS "${qSlicerUnitsModuleWidgets_INCLUDE_DIRS};${qSlicerTerminologiesModuleWidgets_INCLUDE_DIRS};${qSlicerSubjectHierarchyModuleWidgets_INCLUDE_DIRS};${qSlicerAnnotationsModuleWidgets_INCLUDE_DIRS};${qSlicerMarkupsModuleWidgets_INCLUDE_DIRS};${qSlicerTransformsModuleWidgets_INCLUDE_DIRS};${qSlicerModelsModuleWidgets_INCLUDE_DIRS};${qSlicerPlotsModuleWidgets_INCLUDE_DIRS};${qSlicerSegmentationsModuleWidgets_INCLUDE_DIRS};${qSlicerSequencesModuleWidgets_INCLUDE_DIRS};${qSlicerTablesModuleWidgets_INCLUDE_DIRS};${qSlicerTextsModuleWidgets_INCLUDE_DIRS};${qSlicerVolumesModuleWidgets_INCLUDE_DIRS};${qSlicerVolumeRenderingModuleWidgets_INCLUDE_DIRS};${qSlicerDICOMLibModuleWidgets_INCLUDE_DIRS};${qSlicerTemplateKeyModuleWidgets_INCLUDE_DIRS};${qSlicerDataStoreModuleWidgets_INCLUDE_DIRS}"
  CACHE INTERNAL "Slicer Module widgets includes" FORCE)

set(ITKFactoryRegistration_INCLUDE_DIRS "C:/D/S4/Libs/ITKFactoryRegistration;C:/D/S4R/Slicer-build/Libs/ITKFactoryRegistration"
  CACHE INTERNAL "ITKFactoryRegistration includes" FORCE)

set(MRMLCore_INCLUDE_DIRS "C:/D/S4/Libs/MRML/Core;C:/D/S4R/Slicer-build/Libs/MRML/Core;C:/D/S4R/vtkAddon;C:/D/S4R/Slicer-build/Libs/vtkAddon;C:/D/S4/Libs/vtkSegmentationCore;C:/D/S4R/Slicer-build/Libs/vtkSegmentationCore"
  CACHE INTERNAL "MRMLCore includes" FORCE)

set(MRMLLogic_INCLUDE_DIRS "C:/D/S4/Libs/MRML/Logic;C:/D/S4R/Slicer-build/Libs/MRML/Logic"
  CACHE INTERNAL "MRMLLogic includes" FORCE)

set(MRMLCLI_INCLUDE_DIRS "C:/D/S4/Libs/MRML/CLI;C:/D/S4R/Slicer-build/Libs/MRML/CLI"
  CACHE INTERNAL "MRMLCLI includes" FORCE)

set(qMRMLWidgets_INCLUDE_DIRS "C:/D/S4/Libs/MRML/Widgets;C:/D/S4R/Slicer-build/Libs/MRML/Widgets"
  CACHE INTERNAL "qMRMLWidgets includes" FORCE)

set(RemoteIO_INCLUDE_DIRS "C:/D/S4/Libs/RemoteIO;C:/D/S4R/Slicer-build/Libs/RemoteIO"
  CACHE INTERNAL "RemoteIO includes" FORCE)

set(vtkAddon_INCLUDE_DIRS "C:/D/S4R/vtkAddon;C:/D/S4R/Slicer-build/Libs/vtkAddon"
  CACHE INTERNAL "vtkAddon includes" FORCE)

set(vtkITK_INCLUDE_DIRS "C:/D/S4/Libs/vtkITK;C:/D/S4R/Slicer-build/Libs/vtkITK"
  CACHE INTERNAL "vtkITK includes" FORCE)

set(vtkSegmentationCore_INCLUDE_DIRS "C:/D/S4/Libs/vtkSegmentationCore;C:/D/S4R/Slicer-build/Libs/vtkSegmentationCore"
  CACHE INTERNAL "vtkSegmentationCore includes" FORCE)

set(vtkTeem_INCLUDE_DIRS "C:/D/S4/Libs/vtkTeem;C:/D/S4R/Slicer-build/Libs/vtkTeem"
  CACHE INTERNAL "vtkTeem includes" FORCE)

# The location of the UseSlicer.cmake file.
set(Slicer_USE_FILE "C:/D/S4R/Slicer-build/UseSlicer.cmake")

set(Slicer_BINARY_INNER_SUBDIR "Slicer-build")

# Slicer relative build directories.
set(Slicer_BIN_DIR "bin")
set(Slicer_LIB_DIR "lib/Slicer-4.13")
set(Slicer_INCLUDE_DIR "include/Slicer-4.13")
set(Slicer_SHARE_DIR "share/Slicer-4.13")
set(Slicer_ITKFACTORIES_DIR "lib/Slicer-4.13/ITKFactories")

set(Slicer_CLIMODULES_SUBDIR "cli-modules")
set(Slicer_CLIMODULES_BIN_DIR "lib/Slicer-4.13/cli-modules")
set(Slicer_CLIMODULES_LIB_DIR "lib/Slicer-4.13/cli-modules")
set(Slicer_CLIMODULES_SHARE_DIR "share/Slicer-4.13/cli-modules")

set(Slicer_QTLOADABLEMODULES_SUBDIR "qt-loadable-modules")
set(Slicer_QTLOADABLEMODULES_BIN_DIR "lib/Slicer-4.13/qt-loadable-modules")
set(Slicer_QTLOADABLEMODULES_LIB_DIR "lib/Slicer-4.13/qt-loadable-modules")
set(Slicer_QTLOADABLEMODULES_INCLUDE_DIR "include/Slicer-4.13/qt-loadable-modules")
set(Slicer_QTLOADABLEMODULES_SHARE_DIR "share/Slicer-4.13/qt-loadable-modules")
set(Slicer_QTLOADABLEMODULES_PYTHON_LIB_DIR "lib/Slicer-4.13/qt-loadable-modules/Python")

if(Slicer_USE_PYTHONQT)
  set(Slicer_QTSCRIPTEDMODULES_SUBDIR "qt-scripted-modules")
  set(Slicer_QTSCRIPTEDMODULES_BIN_DIR "lib/Slicer-4.13/qt-scripted-modules")
  set(Slicer_QTSCRIPTEDMODULES_LIB_DIR "lib/Slicer-4.13/qt-scripted-modules")
  set(Slicer_QTSCRIPTEDMODULES_INCLUDE_DIR "include/Slicer-4.13/qt-scripted-modules")
  set(Slicer_QTSCRIPTEDMODULES_SHARE_DIR "share/Slicer-4.13/qt-scripted-modules")
endif()

# ThirdParty: Corresponds to superbuild projects built
# in Slicer extension.
set(Slicer_THIRDPARTY_BIN_DIR "bin")
set(Slicer_THIRDPARTY_LIB_DIR "lib/Slicer-4.13")
set(Slicer_THIRDPARTY_SHARE_DIR  "share/Slicer-4.13")

# Python stdlib and site-package sub-directories
set(PYTHON_STDLIB_SUBDIR "Lib")
set(PYTHON_SITE_PACKAGES_SUBDIR "Lib/site-packages")

# Slicer install root
set(Slicer_INSTALL_ROOT "./")

# Slicer relative install directories.
set(Slicer_INSTALL_BIN_DIR "./bin")
set(Slicer_INSTALL_LIB_DIR "./lib/Slicer-4.13")
set(Slicer_INSTALL_INCLUDE_DIR "./include/Slicer-4.13")
set(Slicer_INSTALL_SHARE_DIR "./share/Slicer-4.13")
set(Slicer_INSTALL_ITKFACTORIES_DIR "./lib/Slicer-4.13/ITKFactories")

set(Slicer_INSTALL_CLIMODULES_BIN_DIR "./lib/Slicer-4.13/cli-modules")
set(Slicer_INSTALL_CLIMODULES_LIB_DIR "./lib/Slicer-4.13/cli-modules")
set(Slicer_INSTALL_CLIMODULES_SHARE_DIR "./share/Slicer-4.13/cli-modules")

set(Slicer_INSTALL_QTLOADABLEMODULES_BIN_DIR "./lib/Slicer-4.13/qt-loadable-modules")
set(Slicer_INSTALL_QTLOADABLEMODULES_LIB_DIR "./lib/Slicer-4.13/qt-loadable-modules")
set(Slicer_INSTALL_QTLOADABLEMODULES_PYTHON_LIB_DIR "./lib/Slicer-4.13/qt-loadable-modules/Python")
set(Slicer_INSTALL_QTLOADABLEMODULES_INCLUDE_DIR "./include/Slicer-4.13/qt-loadable-modules")
set(Slicer_INSTALL_QTLOADABLEMODULES_SHARE_DIR "./share/Slicer-4.13/qt-loadable-modules")

if(Slicer_USE_PYTHONQT)
  set(Slicer_INSTALL_QTSCRIPTEDMODULES_BIN_DIR "./lib/Slicer-4.13/qt-scripted-modules")
  set(Slicer_INSTALL_QTSCRIPTEDMODULES_LIB_DIR "./lib/Slicer-4.13/qt-scripted-modules")
  set(Slicer_INSTALL_QTSCRIPTEDMODULES_INCLUDE_DIR "./include/Slicer-4.13/qt-scripted-modules")
  set(Slicer_INSTALL_QTSCRIPTEDMODULES_SHARE_DIR "./share/Slicer-4.13/qt-scripted-modules")
endif()

set(Slicer_INSTALL_THIRDPARTY_BIN_DIR "${Slicer_INSTALL_ROOT}${Slicer_BUNDLE_EXTENSIONS_LOCATION}${Slicer_THIRDPARTY_BIN_DIR}")
set(Slicer_INSTALL_THIRDPARTY_LIB_DIR "${Slicer_INSTALL_ROOT}${Slicer_BUNDLE_EXTENSIONS_LOCATION}${Slicer_THIRDPARTY_LIB_DIR}")
set(Slicer_INSTALL_THIRDPARTY_SHARE_DIR "${Slicer_INSTALL_ROOT}${Slicer_BUNDLE_EXTENSIONS_LOCATION}${Slicer_THIRDPARTY_SHARE_DIR}")

# The Slicer install prefix (*not* defined in the install tree)
set(Slicer_INSTALL_PREFIX  "C:/D/S4R/Slicer-build/E/BRAINSTools/BRAINSTools--5.4.0")


# --------------------------------------------------------------------------
# Testing
# --------------------------------------------------------------------------
include(CTestUseLaunchers)

# --------------------------------------------------------------------------
# External data
# --------------------------------------------------------------------------
if(NOT DEFINED Slicer_ExternalData_DATA_MANAGEMENT_TARGET)
  set(Slicer_ExternalData_DATA_MANAGEMENT_TARGET "SlicerData")
endif()
if(NOT DEFINED SEM_DATA_MANAGEMENT_TARGET)
  set(SEM_DATA_MANAGEMENT_TARGET ${Slicer_ExternalData_DATA_MANAGEMENT_TARGET})
endif()
set(Slicer_ExternalData_OBJECT_STORES "C:/D/S4R/Slicer-build/ExternalData/Objects")
set(Slicer_ExternalData_URL_TEMPLATES "https://github.com/Slicer/SlicerTestingData/releases/download/%(algo)/%(hash);http://slicer.kitware.com/midas3/api/rest?method=midas.bitstream.download&checksum=%(hash)")

# --------------------------------------------------------------------------
# External projects
# --------------------------------------------------------------------------

# With the help of SuperBuild, Slicer has been configured and built against a collection
# of external projects.
#
# Considering that, by default, Slicer and most of its dependent external projects are
# built as shared library, it's important to make sure that the project including
# SlicerConfig.cmake (this file) is built against the same set of external projects if it applies.
#
# Let's consider the example of a project dependending on both VTK and Slicer. With the help of
# the macro 'slicer_config_set_ep', the build system will check that the path of the already
# defined VTK_DIR matches the VTK_DIR used to build Slicer.
#
# A typical use of this macro is illustrated below:
#
#    slicer_config_set_ep("VTK_DIR", "")
#
#
macro(slicer_config_set_ep var value)
  if(NOT "${value}" STREQUAL "")
    if(DEFINED ${var})
      get_filename_component(var_realpath "${${var}}" REALPATH)
      get_filename_component(value_realpath ${value} REALPATH)
      if(NOT ${var_realpath} STREQUAL ${value_realpath})
        message(FATAL_ERROR "Variable ${var} defined prior calling 'find_package(Slicer)' does NOT "
                            "match value used to configure Slicer. It probably means that a different "
                            "${var} has been used to configure this project and Slicer.\n"
                            "${var}=${${var}}\n"
                            "Slicer_${var}=${value}")
      endif()
    endif()
    set(${var} "${value}" ${ARGN})
  endif()
endmacro()

# SlicerExecutionModel settings
set(SlicerExecutionModel_CLI_LIBRARY_WRAPPER_CXX "C:/D/S4R/Slicer-build/Base/CLI/SEMCommandLineLibraryWrapper.cxx")
set(SlicerExecutionModel_EXTRA_INCLUDE_DIRECTORIES "C:/D/S4/Base/CLI;C:/D/S4R/Slicer-build/Base/CLI;C:/D/S4/Base/CLI/Testing;C:/D/S4/Libs/ITKFactoryRegistration;C:/D/S4R/Slicer-build/Libs/ITKFactoryRegistration")
set(SlicerExecutionModel_EXTRA_EXECUTABLE_TARGET_LIBRARIES "ITKFactoryRegistration")

# Slicer external projects variables

slicer_config_set_ep(
  Qt5_DIR
  "C:/Qt/5.15.1/msvc2019_64/lib/cmake/Qt5"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  jqPlot_DIR
  "C:/D/S4R/jqPlot"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  SWIG_EXECUTABLE
  "C:/D/S4R/swigwin-4.0.2/swig.exe"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  ZLIB_INCLUDE_DIR
  "C:/D/S4R/zlib-install/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  ZLIB_LIBRARY
  "C:/D/S4R/zlib-install/lib/zlib.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  ZLIB_ROOT
  "C:/D/S4R/zlib-install"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  OPENSSL_INCLUDE_DIR
  "C:/D/S4R/OpenSSL-install/Release/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  LIB_EAY_DEBUG
  "C:/D/S4R/OpenSSL-install/Debug/lib/libcrypto.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  LIB_EAY_RELEASE
  "C:/D/S4R/OpenSSL-install/Release/lib/libcrypto.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  SSL_EAY_DEBUG
  "C:/D/S4R/OpenSSL-install/Debug/lib/libssl.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  SSL_EAY_RELEASE
  "C:/D/S4R/OpenSSL-install/Release/lib/libssl.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  CURL_INCLUDE_DIR
  "C:/D/S4R/curl-install/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  CURL_LIBRARY
  "C:/D/S4R/curl-install/lib/libcurl.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  CTKAppLauncherLib_DIR
  "C:/D/S4R/CTKAppLauncherLib-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  BZIP2_INCLUDE_DIR
  "C:/D/S4R/bzip2"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  BZIP2_LIBRARIES
  "C:/D/S4R/bzip2-install/lib/libbz2.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  CTKAppLauncher_DIR
  "C:/D/S4R/CTKAPPLAUNCHER"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  LZMA_INCLUDE_DIR
  "C:/D/S4R/LZMA-install/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  LZMA_LIBRARY
  "C:/D/S4R/LZMA-install/lib/lzma.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  sqlite_DIR
  "C:/D/S4R/sqlite-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  sqlite_LIBRARY
  "C:/D/S4R/sqlite-install/lib/sqlite3.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  sqlite_INCLUDE_DIR
  "C:/D/S4R/sqlite-install/include/sqlite3"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  PYTHON_EXECUTABLE
  "C:/D/S4R/python-install/bin/PythonSlicer.exe"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  PYTHON_INCLUDE_DIR
  "C:/D/S4R/python-install/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  PYTHON_LIBRARY
  "C:/D/S4R/python-install/libs/python36.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  PYTHON_DEBUG_LIBRARY
  "C:/D/S4R/python-install/libs/python36.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  Python3_ROOT_DIR
  "C:/D/S4R/python-install"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  Python3_INCLUDE_DIR
  "C:/D/S4R/python-install/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  Python3_LIBRARY
  "C:/D/S4R/python-install/libs/python36.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  Python3_LIBRARY_DEBUG
  "C:/D/S4R/python-install/libs/python36.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  Python3_LIBRARY_RELEASE
  "C:/D/S4R/python-install/libs/python36.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  Python3_EXECUTABLE
  "C:/D/S4R/python-install/bin/PythonSlicer.exe"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  VTK_DIR
  "C:/D/S4R/VTK-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  Teem_DIR
  "C:/D/S4R/teem-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  DCMTK_DIR
  "C:/D/S4R/DCMTK-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  ITK_DIR
  "C:/D/S4R/ITK-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  CTK_DIR
  "C:/D/S4R/CTK-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  LibArchive_INCLUDE_DIR
  "C:/D/S4R/LibArchive-install/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  LibArchive_LIBRARY
  "C:/D/S4R/LibArchive-install/lib/archive.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  RapidJSON_INCLUDE_DIR
  "C:/D/S4R/RapidJSON/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  RapidJSON_DIR
  "C:/D/S4R/RapidJSON-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  SimpleITK_DIR
  "C:/D/S4R/SimpleITK-build/SimpleITK-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  SlicerExecutionModel_DIR
  "C:/D/S4R/SlicerExecutionModel-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  qRestAPI_DIR
  "C:/D/S4R/qRestAPI-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  JsonCpp_INCLUDE_DIR
  "C:/D/S4R/JsonCpp/include"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  JsonCpp_LIBRARY
  "C:/D/S4R/JsonCpp-build/src/lib_json/Release/jsoncpp.lib"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  QtTesting_DIR
  "C:/D/S4R/CTK-build/QtTesting-build"
  CACHE STRING "Path to project build directory or file" FORCE)

slicer_config_set_ep(
  BRAINSCommonLib_DIR
  "C:/D/S4R/Slicer-build/Modules/Remote/BRAINSTools/BRAINSCommonLib"
  CACHE STRING "Path to project build directory or file" FORCE)


# --------------------------------------------------------------------------
# Consistent Compiler Selections
# --------------------------------------------------------------------------
# Compilation Commands
set(Slicer_CMAKE_CXX_COMPILER "C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64/cl.exe")
set(Slicer_CMAKE_C_COMPILER   "C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64/cl.exe")

# With the help of SuperBuild, Slicer has been configured with specific compiler
#
# Considering that, by default, Slicer and most of its dependent external projects are
# built with a particular compiler, it's important to make sure that the project including
# SlicerConfig.cmake (this file) is built against the same compliant compiler
#
# A typical use of this macro is illustrated below:
#    slicer_config_set_compiler_ep("CMAKE_C_COMPILER", "")
#    slicer_config_set_compiler_ep("CMAKE_CXX_COMPILER", "")
#
macro(slicer_config_set_compiler_ep var value)
  if(NOT "${value}" STREQUAL "")
    if(DEFINED ${var})
      get_filename_component(var_realpath "${${var}}" REALPATH)
      get_filename_component(value_realpath ${value} REALPATH)
      if(NOT MSVC AND NOT ${var_realpath} STREQUAL ${value_realpath})
        message(FATAL_ERROR "Variable ${var} defined prior calling 'find_package(Slicer)' does NOT "
                            "match value used to configure Slicer. It probably means that a different "
                            "${var} has been used to configure this project and Slicer.\n"
                            "${var}=${${var}}\n"
                            "Slicer_${var}=${value}")
      endif()
    endif()
    set(${var} "${value}" ${ARGN})
  endif()
endmacro()
slicer_config_set_compiler_ep( CMAKE_C_COMPILER   "C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64/cl.exe"
   CACHE PATH "Path to C compiler used in Slicer build" FORCE )
slicer_config_set_compiler_ep( CMAKE_CXX_COMPILER "C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64/cl.exe"
   CACHE PATH "Path to CXX compiler used in Slicer build" FORCE )
slicer_config_set_compiler_ep( CMAKE_CXX_STANDARD "11"
   CACHE PATH "C++ standard used in Slicer build" FORCE )
slicer_config_set_compiler_ep( CMAKE_CXX_STANDARD_REQUIRED "ON"
   CACHE PATH "Whether the specified C++ standard is a requirement in Slicer build" FORCE )
slicer_config_set_compiler_ep( CMAKE_CXX_EXTENSIONS "OFF"
   CACHE PATH "Whether compiler specific extensions are requested in Slicer build" FORCE )

# On platform (i.e. Windows with Visual Studio) where it is possible to use
# either a 32 or 64 bits generator, it is important to compare bitness of Slicer
# project against project depending on Slicer (i.e. extension) to ensure there
# are no mismatch.
set(Slicer_CMAKE_SIZEOF_VOID_P "8")
set(Slicer_CMAKE_GENERATOR "Visual Studio 16 2019")
if(NOT DEFINED Slicer_SKIP_CMAKE_SIZEOF_VOID_P_CHECK)
  set(Slicer_SKIP_CMAKE_SIZEOF_VOID_P_CHECK FALSE)
endif()
if(NOT ${Slicer_SKIP_CMAKE_SIZEOF_VOID_P_CHECK})
  if(NOT Slicer_CMAKE_SIZEOF_VOID_P EQUAL CMAKE_SIZEOF_VOID_P)
    message(FATAL_ERROR
      "Mismatch between bitness of '${CMAKE_PROJECT_NAME}' and 'Slicer' project !\n"
      "\tSlicer_CMAKE_SIZEOF_VOID_P:${Slicer_CMAKE_SIZEOF_VOID_P}\n"
      "\tCMAKE_SIZEOF_VOID_P:${CMAKE_SIZEOF_VOID_P}\n"
      "Reconfigure '${CMAKE_PROJECT_NAME}' project using a compatible Generator.\n"
      "Generator used to configure Slicer was: ${Slicer_CMAKE_GENERATOR}\n"
      "See http://www.cmake.org/cmake/help/v2.8.11/cmake.html#opt:-Ggenerator-name")
  endif()
endif()

# List all required external project
set(Slicer_EXTERNAL_PROJECTS CTK;CTKAppLauncherLib;ITK;CURL;Teem;VTK;RapidJSON;CTKAppLauncher;QtTesting;SlicerExecutionModel;qRestAPI;DCMTK;PythonLibs;PythonInterp;SWIG)
set(Slicer_EXTERNAL_PROJECTS_NO_USEFILE CURL;CTKAppLauncherLib;RapidJSON;CTKAppLauncher;QtTesting;DCMTK;PythonLibs;PythonInterp;SWIG)

set(Slicer_VTK_COMPONENTS "vtkFiltersExtraction;vtkFiltersFlowPaths;vtkFiltersGeometry;vtkFiltersParallel;vtkGUISupportQtSQL;vtkIOExport;vtkIOImage;vtkIOLegacy;vtkIOPLY;vtkIOXML;vtkImagingMath;vtkImagingMorphological;vtkImagingStatistics;vtkImagingStencil;vtkInteractionImage;vtkRenderingContextOpenGL2;vtkRenderingQt;vtkRenderingVolumeOpenGL2;vtkTestingRendering;vtkViewsQt;vtkzlib;vtkGUISupportQtOpenGL;vtkWrappingPythonCore")

# Include external projects
foreach(proj ${Slicer_EXTERNAL_PROJECTS})
  set(_component_args)
  if(DEFINED Slicer_${proj}_COMPONENTS)
    set(_component_args COMPONENTS ${Slicer_${proj}_COMPONENTS})
  endif()
  find_package(${proj} ${_component_args} REQUIRED)
  # Add project CMake dir to module path
  if(DEFINED ${proj}_CMAKE_DIR)
    set(CMAKE_MODULE_PATH
      ${${proj}_CMAKE_DIR}
      ${CMAKE_MODULE_PATH}
      )
  endif()
  # Add project Utilities/CMake dir to module path
  if(DEFINED ${proj}_CMAKE_UTILITIES_DIR)
    set(CMAKE_MODULE_PATH
      ${${proj}_CMAKE_UTILITIES_DIR}
      ${CMAKE_MODULE_PATH}
      )
  endif()
endforeach()

# List all Slicer_USE_SYSTEM_* variables

set(Slicer_USE_SYSTEM_Slicer_USE_SYSTEM_python "")

# This block should be added after VTK and CTK are found.
# It will check if CTK_Qt5_DIR is valid.
include(${Slicer_CMAKE_DIR}/SlicerBlockFindQtAndCheckVersion.cmake)

# --------------------------------------------------------------------------
if(EXISTS "C:/D/S4R/Slicer-build/SlicerTargets.cmake" AND NOT TARGET SlicerBaseLogic)
  include("C:/D/S4R/Slicer-build/SlicerTargets.cmake")
endif()
