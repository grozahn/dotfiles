import platform
import os
import ycm_core

def FlagsForFile( filename, **kwargs ):
  return {
    'flags': [
    '-std=c++11',
    '-x',
    'c++',
    '-Wall',
    '-Wextra',
    '-Werror',
    #'-I/usr/lib/',
    #'-I/usr/include',
    '-isystem',
    '/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/7.2.0/../../../../include/c++/7.2.0',
    '-isystem',
    '/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/7.2.0/../../../../include/c++/7.2.0/x86_64-pc-linux-gnu',
    '-isystem',
    '/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/7.2.0/../../../../include/c++/7.2.0/backward',
    '-isystem',
    '/usr/local/include',
    '-isystem',
    '/usr/lib/clang/5.0.0/include',
    '-isystem',
    '/usr/include'
    ]
  }

SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]

