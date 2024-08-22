@echo off

echo This is a script meant for Cybertitan use only! Are you aware of the risks and accept to proceed?
echo MAKE SURE TO RUN THIS AS AN ADMINISTRATOR!!
set /p play= [y/n]

if %play% equ y (
	goto:startup
)

:startup
	cls
	echo What script would you like to run?
	echo 1. Add Users
	echo 2. Delete Users
	echo 3. Create a Group
	echo 4. Delete a Group
	echo 5. Add User to Group
	set /p script= Script:
	
	if %script% equ 1 (
		goto:script1

	)
	if %script% equ 2 (
		goto:script2
		
	)
	if %script% equ 3 (
		goto:script3
	
	)
	if %script% equ 4 (
		goto:script4
	
	)
	if %script% equ 5 (
		goto:script5
	
	)
	pause





:script1

	cls
	
	echo Welcome to Adding Users
	
	set /p newuser= Username:
	set /p newpass= Password:

	net user %newuser% %newpass% /add
	
	cls
	
	echo Is this an Administrator?
	
	set /p adminuser= [y/n]
	
	if %adminuser% equ y (
		cls
		net localgroup administrators %newuser% /add
		echo The User is now an Administrator
	)
	
	cls
	
	echo Add another User?
	set /p addmoreuser= [y/n]
	
	if %addmoreuser% equ y (
		goto:script1
	)
	if %addmoreuser% equ n (
		goto:startup
	)

:script2
	
	cls
	
	echo Welcome to Removing Users 
	
	set /p removeuser= User:
	
	cls
	
	net user %removeuser% /delete
	echo Removed user
	
	echo Remove another user?
	
	set /p removeanotheruser= [y/n]
	
	if %removeanotheruser% equ y (
		goto:script2
	)
	if %removeanotheruser% equ n (
		goto:startup
	)
	else (
		goto:startup
	)	
:script3

	cls 
	
	echo Welcome to Creating a Group
	set /p addgroup= Name for new Group:
	
	cls
	
	net localgroup %addgroup% /add
	echo Added Group
	
	cls
	
	echo Add another group?
	set /p addanothergroup= [y/n]
	
	if %addanothergroup% equ y (
		goto:script3
	)
	else (
		goto:startup
	)
	
:script4

	cls 
	
	echo Welcome to Removing a Group
	set /p removegroup= Name Group to Remove:
	
	cls
	
	net localgroup %removegroup% /delete
	echo Removed Group
	
	cls 
	
	echo Remove another group?
	set /p removeanothergroup= [y/n]
	
	if %removeanothergroup% equ y (
		goto:script4
	)
	else (
		goto:startup
	)
	
:script5

	cls
	
	echo Welcome to Adding Users to a Group
	set /p addusertogroup= What User to add:
	set /p usertogroup= What Group:
	
	cls
	
	echo Adding User to Group
	net localgroup %usertogroup% %addusertogroup% /add
	
	echo Add another user to Group?
	set /p anotherusertogroup= [y/n]
	
	if %anotherusertogroup% equ y (
		goto:script5
	)
	else (
		goto:startup
	)
	
