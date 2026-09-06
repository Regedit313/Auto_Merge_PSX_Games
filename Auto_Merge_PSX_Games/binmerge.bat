@echo off
setlocal

set "ROOT=%~dp0"
set "INPUT=%ROOT%ORIGINAL"
set "OUTPUT=%ROOT%MERGED"

REM ============================================================
REM Si ORIGINAL n'existe pas, le creer puis quitter immediatement
REM ============================================================
if not exist "%INPUT%" (
    mkdir "%INPUT%"
    exit /b
)

REM ============================================================
REM Creer le dossier de sortie MERGED si necessaire
REM ============================================================
if not exist "%OUTPUT%" mkdir "%OUTPUT%"

REM ============================================================
REM Traiter chaque dossier de jeu contenu dans ORIGINAL
REM ============================================================
for /D %%G in ("%INPUT%\*") do (
    for %%C in ("%%G\*.cue") do (

        echo.
        echo ==========================================
        echo Traitement : %%~nxG
        echo ==========================================

        REM Nom du dossier final : "Nom du jeu MERGED"
        if not exist "%OUTPUT%\%%~nxG MERGED" (
            mkdir "%OUTPUT%\%%~nxG MERGED"
        )

        REM Nom des fichiers finaux :
        REM "Nom du jeu MERGED.bin"
        REM "Nom du jeu MERGED.cue"
        "%ROOT%binmerge.exe" --outdir "%OUTPUT%\%%~nxG MERGED" "%%C" "%%~nC MERGED"
    )
)

echo.
echo ==========================================
echo Finish.
echo ==========================================
pause