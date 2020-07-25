# MIUI12-fix-dark-mode

Based on [alex4o/magisk-fix-darkmode-miui-services](https://github.com/alex4o/magisk-fix-darkmode-miui-services) solution, but made my own version, because I had trouble using his repo.\
You can use module I put in repo or create one for yourself using own services.jar file.\
In case phone doesn't start you can remove module folder using twrp. 

Changes that need to be done after decompiling.\
Remove commented code related to dark mode from these methods in com/android/server/UiModeManagerService.smali:

```smali   
.method private setDarkProp(II)V
    .registers 6

    const/4 v0, 0x0

    const/4 v1, 0x2

    if-ne p1, v1, :cond_5

    const/4 v0, 0x1

    :cond_5
    invoke-virtual {p0}, Lcom/android/server/UiModeManagerService;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "dark_mode_enable"

    invoke-static {v1, v2, v0, p2}, Landroid/provider/Settings$System;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    invoke-virtual {p0}, Lcom/android/server/UiModeManagerService;->getContext()Landroid/content/Context;

    # move-result-object v1

    # invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    # move-result-object v1

    # const-string/jumbo v2, "smart_dark_enable"

    # invoke-static {v1, v2, v0, p2}, Landroid/provider/Settings$System;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    # const/4 v1, 0x1

    # if-ne v0, v1, :cond_27

    # const-string/jumbo v1, "true"

    # goto :goto_29

    # :cond_27
    # const-string v1, "false"

    # :goto_29
    # const-string v2, "debug.hwui.force_dark"

    # invoke-static {v2, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private setForceDark(Landroid/content/Context;)V
    .registers 7

    invoke-virtual {p0}, Lcom/android/server/UiModeManagerService;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget v1, p0, Lcom/android/server/UiModeManagerService;->mNightMode:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_f

    const/4 v1, 0x1

    goto :goto_10

    :cond_f
    const/4 v1, 0x0

    :goto_10
    invoke-static {}, Landroid/os/UserHandle;->getCallingUserId()I

    move-result v3

    const-string v4, "dark_mode_enable"

    invoke-static {v0, v4, v1, v3}, Landroid/provider/Settings$System;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    sget-object v0, Lcom/android/server/UiModeManagerService;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "mNightMode: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lcom/android/server/UiModeManagerService;->mNightMode:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget v0, p0, Lcom/android/server/UiModeManagerService;->mNightMode:I

    # if-ne v0, v2, :cond_3e

    # const-string v0, "debug.hwui.force_dark"

    # const-string/jumbo v1, "true"

    # invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    # :cond_3e
    return-void
.end method

```
