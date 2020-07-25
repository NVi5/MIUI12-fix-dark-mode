# Download baksmali-2.4.0.jar and smali-2.4.0.jar into repository
# Copy services.jar from \system\framework to internal memory, then pull it
get:
	adb pull /sdcard/services.jar
	powershell mv services.jar services.apk
	java -jar baksmali-2.4.0.jar disassemble services.apk -o app
	
# Update UiModeManagerService.smali in \app\com\android\server
asm:
	java -jar smali-2.4.0.jar assemble app -o classes.dex

#Replace classes.dex in services.apk
move:
	powershell mv services.apk \Fix-Dark-Mode\system\framework\services.jar

#Zip files in Fix-Dark-Mode to make magisk module
