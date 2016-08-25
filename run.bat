@ECHO OFF
CLS

SET HOUR=%time:~0,2%
SET dtStamp9=%date:~-4%%date:~4,2%%date:~7,2%_0%time:~1,1%%time:~3,2%%time:~6,2% 
SET dtStamp24=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

if "%HOUR:~0,1%" == " " (SET dtStamp=%dtStamp9%) else (SET dtStamp=%dtStamp24%)

set TF_LOG=TRACE

:MENU

ECHO.
ECHO ...............................................
ECHO PRESS 1, 2 OR 3 to select your task, or 4 to EXIT.
ECHO ...............................................
ECHO.
ECHO 1 - Run terraform get
ECHO 2 - Run terraform plan
ECHO 3 - Run terraform apply
ECHO 4 - EXIT
ECHO.
CHOICE /C:1234
IF ERRORLEVEL 1 SET M=1
IF ERRORLEVEL 2 SET M=2
IF ERRORLEVEL 3 SET M=3
IF ERRORLEVEL 4 SET M=4
IF %M%==1 GOTO GET
IF %M%==2 GOTO PLAN
IF %M%==3 GOTO APPLY
IF %M%==4 GOTO EOF

:GET
terraform get 2> get_err_%dtStamp%.txt
GOTO MENU
:PLAN
Terraform plan 2> plan_err_%dtStamp%.txt
GOTO MENU
:APPLY
terraform apply 2> apply_err_%dtStamp%.txt
GOTO MENU
:EOF
ECHO OFF
Exit /B
