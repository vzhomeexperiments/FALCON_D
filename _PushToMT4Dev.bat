rem Script to Deploy files from Version Control repository to All Terminals
rem Use when you need to publish all files to All Terminals

@echo off
setlocal enabledelayedexpansion

set SOURCE_DIR="C:\Users\fxtrams\Documents\000_TradingRepo\FALCON_D"
set DEST_DIR2="C:\Program Files (x86)\FxPro - Terminal2\MQL4\Experts\FALCON_D"

ROBOCOPY %SOURCE_DIR% %DEST_DIR2% *.mq4



