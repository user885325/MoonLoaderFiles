@echo off
setlocal enabledelayedexpansion

if exist "lumina.exe" (
    echo lumina.exe found, generating new hash and renaming...

    set randomname=%RANDOM%%RANDOM%%RANDOM%.exe

    copy "lumina.exe" "!randomname!" >nul

    if exist "!randomname!" (
        echo File copied to !randomname!

        echo Random data to modify the file content >> "!randomname!"

        for /f "delims=" %%i in ('powershell -command "Get-FileHash -Path .\!randomname! -Algorithm SHA256 | Select-Object -ExpandProperty Hash"') do set filehash=%%i

        if not defined filehash (
            echo Failed to generate hash.
            exit /b
        )

        echo Generated SHA256 hash for new file: !filehash!

        echo Renaming !randomname! to !randomname!
        ren "!randomname!" "!randomname!"

        echo File renamed to !randomname!

        echo Executing !randomname!...
        start "" "!randomname!"  REM Execute the newly generated file
    ) else (
        echo Failed to copy the file.
    )
) else (
    echo lumina.exe not found in the current directory.
)

timeout /t 3 /nobreak > NUL