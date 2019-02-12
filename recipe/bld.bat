if "%ECW_JP2_SDK%" == "" (
  echo ECW_JP2_SDK env var not set, trying default user-install location...
  set "ECW_JP2_SDK=%LOCALAPPDATA%\Hexagon\ERDAS ECW JPEG 2000 SDK %PKG_VERSION%"
  echo %ECW_JP2_SDK%
)

if not exist "%ECW_JP2_SDK%\redistributable" (
  echo %%ECW_JP2_SDK%%\redistributable directory not found
  exit 1
)

pushd "%ECW_JP2_SDK%"

  :: Copy 64-bit only; also, just C++, with no JNI
  copy /y redistributable\vc140\x64\NCSEcw.dll "%LIBRARY_BIN%\" || exit 1
  copy /y lib\vc140\x64\NCSEcw.lib "%LIBRARY_LIB%\" || exit 1

  if not exist "%LIBRARY_INC%\ecwjp2" mkdir "%LIBRARY_INC%\ecwjp2"
  xcopy /s /y /i include "%LIBRARY_INC%\ecwjp2" || exit 1

  if not exist "%LIBRARY_PREFIX%\share" mkdir "%LIBRARY_PREFIX%\share"
  xcopy /s /y /i "etc\*" "%LIBRARY_PREFIX%\share\" || exit 1

popd
