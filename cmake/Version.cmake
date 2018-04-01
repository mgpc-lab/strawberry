set(STRAWBERRY_VERSION_MAJOR 0)
set(STRAWBERRY_VERSION_MINOR 1)
set(STRAWBERRY_VERSION_PATCH 1)
#set(STRAWBERRY_VERSION_PRERELEASE rc1)

set(INCLUDE_GIT_REVISION ON)

set(majorminorpatch "${STRAWBERRY_VERSION_MAJOR}.${STRAWBERRY_VERSION_MINOR}.${STRAWBERRY_VERSION_PATCH}")

set(STRAWBERRY_VERSION_DISPLAY "${majorminorpatch}")
set(STRAWBERRY_VERSION_RPM_V   "${majorminorpatch}")
set(STRAWBERRY_VERSION_RPM_R   "1")
set(STRAWBERRY_VERSION_PACKAGE "${majorminorpatch}")

if(${STRAWBERRY_VERSION_PATCH} EQUAL "0")
  set(STRAWBERRY_VERSION_DISPLAY "${STRAWBERRY_VERSION_MAJOR}.${STRAWBERRY_VERSION_MINOR}")
endif(${STRAWBERRY_VERSION_PATCH} EQUAL "0")

if(STRAWBERRY_VERSION_PRERELEASE)
  set(STRAWBERRY_VERSION_DISPLAY "${STRAWBERRY_VERSION_DISPLAY} ${STRAWBERRY_VERSION_PRERELEASE}")
  set(STRAWBERRY_VERSION_RPM_R   "0.${STRAWBERRY_VERSION_PRERELEASE}")
  set(STRAWBERRY_VERSION_PACKAGE "${STRAWBERRY_VERSION_PACKAGE}${STRAWBERRY_VERSION_PRERELEASE}")
endif(STRAWBERRY_VERSION_PRERELEASE)

find_program(GIT_EXECUTABLE git)

if(NOT GIT_EXECUTABLE-NOTFOUND)
  # Get the current working branch
  execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    RESULT_VARIABLE GIT_INFO_RESULT
    OUTPUT_VARIABLE GIT_BRANCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET
  )
  # Get the latest abbreviated commit hash of the working branch
  execute_process(
    COMMAND ${GIT_EXECUTABLE} log -1 --format=%h
    RESULT_VARIABLE GIT_INFO_RESULT
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_COMMIT_HASH
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET
  )
endif()

if(${GIT_INFO_RESULT} EQUAL 0)
    set(HAS_GET_REVISION ON)
    set(GIT_REV "${GIT_COMMIT_HASH}")
endif(${GIT_INFO_RESULT} EQUAL 0)

if(INCLUDE_GIT_REVISION AND HAS_GET_REVISION)
  set(STRAWBERRY_VERSION_DISPLAY "${STRAWBERRY_VERSION_DISPLAY} ${GIT_BRANCH} ${GIT_REV}")
  set(STRAWBERRY_VERSION_PACKAGE "${STRAWBERRY_VERSION_PACKAGE}-${GIT_BRANCH}-${GIT_REV}")
  set(STRAWBERRY_VERSION_RPM_V   "${STRAWBERRY_VERSION_RPM_V}.${GIT_BRANCH}.${GIT_REV}")
  set(STRAWBERRY_VERSION_RPM_R   "1")
endif(INCLUDE_GIT_REVISION AND HAS_GET_REVISION)

message(STATUS "Strawberry Version:")
message(STATUS "Display:  ${STRAWBERRY_VERSION_DISPLAY}")
message(STATUS "Package:  ${STRAWBERRY_VERSION_PACKAGE}")
message(STATUS "Rpm:      ${STRAWBERRY_VERSION_RPM_V}-${STRAWBERRY_VERSION_RPM_R}")
