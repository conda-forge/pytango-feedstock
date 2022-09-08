setlocal EnableDelayedExpansion

mkdir build
cd build

cmake -G "NMake Makefiles" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_CXX_FLAGS="-DLOG4TANGO_HAS_DLL -DTANGO_HAS_DLL" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
      -DTANGO_PKG_INCLUDE_DIRS:PATH="%LIBRARY_INC%\tango" ^
      -DTANGO_ROOT:PATH="%LIBRARY_PREFIX%" ^
      -DPYTHON_VER="%CONDA_PY%" ^
      -DPYTHON_ROOT:PATH="%PREFIX%" ^
      ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit

cd ..

rmdir /s /q pytango.egg-info
python -m pip install --no-binary=:all: -vv .
if errorlevel 1 exit
