rem Script to Deploy files from Version Control repository to All Terminals
rem Use when you need to publish all files to All Terminals

@echo off
setlocal enabledelayedexpansion

:: Source Directory where Version Control Repository is located
set SOURCE_DIR="%PATH_DSS_Repo%\FALCON_D"
:: Destination Directory where Expert Advisor is located
set DEST_DIR="%PATH_T2_E%\FALCON_D"

ROBOCOPY %SOURCE_DIR% %DEST_DIR% *.mq4



