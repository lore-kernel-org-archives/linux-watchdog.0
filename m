Return-path: <j.uzycki@elproma.com.pl>
Message-ID: <540D9DBD.5050105@elproma.com.pl>
Date: Mon, 08 Sep 2014 14:14:53 +0200
From: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
References: <S1751381AbaIDOwq/20140904145246Z+988@vger.kernel.org> <54088996.4040500@elproma.com.pl> <540C9383.9050307@roeck-us.net> <540D02E1.90403@elproma.com.pl> <540D1F8F.2080802@roeck-us.net>
In-Reply-To: <540D1F8F.2080802@roeck-us.net>
Content-Type: multipart/mixed;
 boundary="------------000907000909070102010203"
List-ID: <linux-watchdog@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000907000909070102010203
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 7bit

W dniu 2014-09-08 05:16, Guenter Roeck pisze:
>>>> * Shoud dynamic or static timer_list be used (small structure...)?
>> dynamic or static timer?
> I am fine with dynamic, though I would probably make it static.
> It is not as if there are dozens or hundreds of watchdogs
> in the system where it would make much of a difference.
> The code itself is already much larger than the size of
> the data structure.
ok, switched to static

>> Can kernel suspend a started (stoppable) watchdog? It dissapeared in 
>> 3.x. Now userland reaction seems to be required.
> Really ? I see a number of watchdog drivers implementing it.
I thought it was discarded and PM in other watchdog drivers is deprecated
when I didn't find it for not so old stmp3xxx_rtc_wdt.c.
For suspend/resume drivers call own stop/start functions and use 
watchdog_active() - good
but it could be likely unified.
Some drivers duplicate active flag, eg. omap_wdt.c: omap_wdt_users.

>> I also attached the patch file - I don't trust email client in text 
>> formatting (tabs)
> You'll have to sort that out. Try using git send-email, for example.
I found Thunderbird is accepted but I'm not sure.

>>> I would not call this "kernel ping". We'll need to find a better
>>> name. Proposals welcome. Something indicating the status, ie something
>>> indicating that the wdt is always running and can not be stopped.
>> "keep on" proposed (I changed the subject also)
>
> Hmm ... but that isn't right either. It should reflect that the watchdog
> is always active / running.
I can't fully agree here.
"Always active / running" means for me hardware watchdog's attribute.
stmp3xxx allows to stop the watchdog and it can be stopped even the 
feature is set.
This case happens on suspend for example.
Therefore "always running" / WATCHDOG_ALWAYS_ACTIVE seems to be confusing.

> You still have trouble with your line length. Makes it hard for
> me (and everyone else) to read your text.
Clear. Now I split lines manually.

>>> Given that, there are two use states to consider: WDT is always 
>>> running,
>>> and WDT can not be stopped after it was started once. We should cover
>>> both cases.
>> and third: ability to stop watchdog (if possible) for suspend
>
> Today that is handled by individual drivers. I have no idea though how
> that would or could be handled if the watchdog can not be stopped at all.
> Seems to be a contradiction to me.
>
> Anyway, you'll probably need some code which suspends pinging the
> watchdog in suspend. But that assumes that the watchdog can be stopped
> after all, at least during suspend.
If watchdog can't be stopped it is rather impossible to suspend machine 
without a reset.
Maybe long timeout value has a sense then but it depends on hardware, is 
complex,
and requires RTC wake up event or watchdog pre-timeout interrupt support.

>>> The feature should have DT support from the beginning if possible,
>>> though it should be added as a separate patch in case there is
>>> a hiccup with the DT folks.
>> Can you give more details?
>>
> We'll have to determine bindings which are acceptable for DT.
separate patch - next step

>> +/* 'keep on' feature */
>> +static void watchdog_keepon_timer_cb(unsigned long data)
>
> No problem calling this 'ping'. That describes what the function
> is doing. 'k' in 'kping' is redundant, though - presumably all
> kernel code runs in the kernel ;-).
right :)

>> +    /* call next ping half the timeout value */
>> +    mod_timer(wdd->keepon_timer,
>> +            jiffies + wdd->timeout * (HZ/2));
>
> Watch out for coding style (spaces befor and after operators).
> Better use something like
>         jiffies + msecs_to_jiffies(wdd->timeout * 1000)
fixed

>> +static void watchdog_keepon_start(struct watchdog_device *wdd)
>>   {
>>       watchdog_start(wdd);
>> +    /* watchdog_keepon_timer_cb((unsigned long)wdd); or the code 
>> below: */
>>       watchdog_ping(wdd);
>> +    mod_timer(wdd->keepon_timer, jiffies + HZ/2);
> Why only 500ms timeout here ?
fixed by calling timer callback function

>>   struct watchdog_ops;
>> @@ -96,9 +96,9 @@ struct watchdog_device {
>>   #define WDOG_ALLOW_RELEASE    2    /* Did we receive the magic char 
>> ? */
>>   #define WDOG_NO_WAY_OUT        3    /* Is 'nowayout' feature set ? */
>>   #define WDOG_UNREGISTERED    4    /* Has the device been 
>> unregistered */
>> -#define WDOG_KERNEL_PING    5    /* Ping is done by kernel if device 
>> not opened by userland */
>> -    struct timer_list *kping_timer;    /* kernel ping timer */
>> -#define WATCHDOG_KERNEL_PING    (1 << WDOG_KERNEL_PING)
>> +#define WDOG_KEEP_ON        5    /* Is 'keep on' feature set? */
>> +    struct timer_list *keepon_timer;/* 'keep on' timer */
>> +#define WATCHDOG_KEEP_ON    (1 << WDOG_KEEP_ON)
>
> Move this define out of the struct, please.
done

>> +/* 'keep on' feature */
>> +static void watchdog_keepon_timer_cb(unsigned long data)
>> +{
>> +    struct watchdog_device *wdd = (struct watchdog_device *)data;
>> +    watchdog_ping(wdd);
>
> I don't think this works. It bails out if the watchdog is not
> active, and active means opened from user space. Correct me
> if I am wrong.
It works (tested) because watchdog is activated in watchdog_keepon_start()

>> +    if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
>> +        if (!try_module_get(watchdog->ops->owner))
>> +            return -ENODEV;
>> +        watchdog->keepon_timer =
>> +            kzalloc(sizeof(*watchdog->keepon_timer), GFP_KERNEL);
>> +        if (!watchdog->keepon_timer)
>> +            return -ENOMEM;
> This really suggests it should be static, to avoid such complexity
> and potential errors. Also, you leak at least the module reference
> on errors (here and later).
changed above

>> + setup_timer(watchdog->keepon_timer, watchdog_keepon_timer_cb,
>> +                (unsigned long)watchdog);
>> +        watchdog_keepon_start(watchdog);
>
> By setting the timer here prior to completing registration you risk 
> leaking
> the timer on error. Also, there is strictly speaking no guarantee that 
> the
> timer doesn't fire before registration is complete, so this results
> in a race condition.
Is there race condition really issue?
I wanted to start the timer before userspace access is possible.
I rather see not handled error path for the ping timer.
I fixed it but I guess it requires more common code.

Below the fixed patch.
Janusz

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

diff --git a/linux-3.14.17/drivers/watchdog/stmp3xxx_rtc_wdt.c 
b/linux-3.14.17/drivers/watchdog/stmp3xxx_rtc_wdt.c
index b4d6b34..3546f03 100644
--- a/linux-3.14.17/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/linux-3.14.17/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -67,7 +67,7 @@ static struct watchdog_device stmp3xxx_wdd = {
      .ops = &stmp3xxx_wdt_ops,
      .min_timeout = 1,
      .max_timeout = STMP3XXX_MAX_TIMEOUT,
-    .status = WATCHDOG_NOWAYOUT_INIT_STATUS,
+    .status = WATCHDOG_NOWAYOUT_INIT_STATUS | WATCHDOG_KEEP_ON,
  };

  static int stmp3xxx_wdt_probe(struct platform_device *pdev)
diff --git a/linux-3.14.17/drivers/watchdog/watchdog_dev.c 
b/linux-3.14.17/drivers/watchdog/watchdog_dev.c
index 6aaefba..51a65f6 100644
--- a/linux-3.14.17/drivers/watchdog/watchdog_dev.c
+++ b/linux-3.14.17/drivers/watchdog/watchdog_dev.c
@@ -41,6 +41,7 @@
  #include <linux/miscdevice.h>    /* For handling misc devices */
  #include <linux/init.h>        /* For __init/__exit/... */
  #include <linux/uaccess.h>    /* For copy_to_user/put_user/... */
+#include <linux/jiffies.h>    /* for ping timer */

  #include "watchdog_core.h"

@@ -277,6 +278,27 @@ out_ioctl:
      return err;
  }

+/* 'keep on' feature */
+static void watchdog_ping_timer_cb(unsigned long data)
+{
+    struct watchdog_device *wdd = (struct watchdog_device *)data;
+    watchdog_ping(wdd);
+    /* call next ping half the timeout value */
+    mod_timer(&wdd->ping_timer,
+            jiffies + msecs_to_jiffies(wdd->timeout * 500));
+}
+
+static void watchdog_keepon_start(struct watchdog_device *wdd)
+{
+    watchdog_start(wdd);
+    watchdog_ping_timer_cb((unsigned long)wdd);
+}
+
+static void watchdog_keepon_stop(struct watchdog_device *wdd)
+{
+    del_timer_sync(&wdd->ping_timer);
+}
+
  /*
   *    watchdog_write: writes to the watchdog.
   *    @file: file from VFS
@@ -430,6 +452,9 @@ static int watchdog_open(struct inode *inode, struct 
file *file)
      if (!try_module_get(wdd->ops->owner))
          goto out;

+    if (test_bit(WDOG_KEEP_ON, &wdd->status))
+        watchdog_keepon_stop(wdd);
+
      err = watchdog_start(wdd);
      if (err < 0)
          goto out_mod;
@@ -472,8 +497,13 @@ static int watchdog_release(struct inode *inode, 
struct file *file)
      if (!test_bit(WDOG_ACTIVE, &wdd->status))
          err = 0;
      else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
-         !(wdd->info->options & WDIOF_MAGICCLOSE))
-        err = watchdog_stop(wdd);
+         !(wdd->info->options & WDIOF_MAGICCLOSE)) {
+        if (test_bit(WDOG_KEEP_ON, &wdd->status)) {
+            watchdog_keepon_start(wdd);
+            err = 0;
+        } else
+            err = watchdog_stop(wdd);
+    }

      /* If the watchdog was not stopped, send a keepalive ping */
      if (err < 0) {
@@ -524,6 +554,14 @@ int watchdog_dev_register(struct watchdog_device 
*watchdog)
  {
      int err, devno;

+    if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
+        if (!try_module_get(watchdog->ops->owner))
+            return -ENODEV;
+        setup_timer(&watchdog->ping_timer, watchdog_ping_timer_cb,
+                (unsigned long)watchdog);
+        watchdog_keepon_start(watchdog);
+    }
+
      if (watchdog->id == 0) {
          old_wdd = watchdog;
          watchdog_miscdev.parent = watchdog->parent;
@@ -535,6 +573,11 @@ int watchdog_dev_register(struct watchdog_device 
*watchdog)
                  pr_err("%s: a legacy watchdog module is probably 
present.\n",
                      watchdog->info->identity);
              old_wdd = NULL;
+            if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
+                watchdog_keepon_stop(watchdog);
+                watchdog_stop(watchdog);
+                module_put(watchdog->ops->owner);
+            }
              return err;
          }
      }
@@ -553,6 +596,11 @@ int watchdog_dev_register(struct watchdog_device 
*watchdog)
              misc_deregister(&watchdog_miscdev);
              old_wdd = NULL;
          }
+        if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
+            watchdog_keepon_stop(watchdog);
+            watchdog_stop(watchdog);
+            module_put(watchdog->ops->owner);
+        }
      }
      return err;
  }
@@ -575,6 +623,12 @@ int watchdog_dev_unregister(struct watchdog_device 
*watchdog)
          misc_deregister(&watchdog_miscdev);
          old_wdd = NULL;
      }
+
+    if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
+        watchdog_keepon_stop(watchdog);
+        watchdog_stop(watchdog);
+        module_put(watchdog->ops->owner);
+    }
      return 0;
  }

diff --git a/linux-3.14.17/include/linux/watchdog.h 
b/linux-3.14.17/include/linux/watchdog.h
index 2a3038e..650e0d5 100644
--- a/linux-3.14.17/include/linux/watchdog.h
+++ b/linux-3.14.17/include/linux/watchdog.h
@@ -12,6 +12,7 @@
  #include <linux/bitops.h>
  #include <linux/device.h>
  #include <linux/cdev.h>
+#include <linux/timer.h>        /* for ping timer */
  #include <uapi/linux/watchdog.h>

  struct watchdog_ops;
@@ -95,6 +96,8 @@ struct watchdog_device {
  #define WDOG_ALLOW_RELEASE    2    /* Did we receive the magic char ? */
  #define WDOG_NO_WAY_OUT        3    /* Is 'nowayout' feature set ? */
  #define WDOG_UNREGISTERED    4    /* Has the device been unregistered */
+#define WDOG_KEEP_ON        5    /* Is 'keep on' feature set? */
+    struct timer_list ping_timer;    /* timer to keep on hardware ping */
  };

  #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -104,6 +107,8 @@ struct watchdog_device {
  #define WATCHDOG_NOWAYOUT        0
  #define WATCHDOG_NOWAYOUT_INIT_STATUS    0
  #endif
+/* other proposal: WATCHDOG_ALWAYS_ACTIVE */
+#define WATCHDOG_KEEP_ON        (1 << WDOG_KEEP_ON)

  /* Use the following function to check whether or not the watchdog is 
active */
  static inline bool watchdog_active(struct watchdog_device *wdd)


--------------000907000909070102010203
Content-Type: text/plain; charset=windows-1250;
 name="watchdog_dev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="watchdog_dev.patch"

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

diff --git a/linux-3.14.17/drivers/watchdog/stmp3xxx_rtc_wdt.c b/linux-3.14.17/drivers/watchdog/stmp3xxx_rtc_wdt.c
index b4d6b34..3546f03 100644
--- a/linux-3.14.17/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/linux-3.14.17/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -67,7 +67,7 @@ static struct watchdog_device stmp3xxx_wdd = {
 	.ops = &stmp3xxx_wdt_ops,
 	.min_timeout = 1,
 	.max_timeout = STMP3XXX_MAX_TIMEOUT,
-	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
+	.status = WATCHDOG_NOWAYOUT_INIT_STATUS | WATCHDOG_KEEP_ON,
 };
 
 static int stmp3xxx_wdt_probe(struct platform_device *pdev)
diff --git a/linux-3.14.17/drivers/watchdog/watchdog_dev.c b/linux-3.14.17/drivers/watchdog/watchdog_dev.c
index 6aaefba..51a65f6 100644
--- a/linux-3.14.17/drivers/watchdog/watchdog_dev.c
+++ b/linux-3.14.17/drivers/watchdog/watchdog_dev.c
@@ -41,6 +41,7 @@
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
+#include <linux/jiffies.h>	/* for ping timer */
 
 #include "watchdog_core.h"
 
@@ -277,6 +278,27 @@ out_ioctl:
 	return err;
 }
 
+/* 'keep on' feature */
+static void watchdog_ping_timer_cb(unsigned long data)
+{
+	struct watchdog_device *wdd = (struct watchdog_device *)data;
+	watchdog_ping(wdd);
+	/* call next ping half the timeout value */
+	mod_timer(&wdd->ping_timer,
+			jiffies + msecs_to_jiffies(wdd->timeout * 500));
+}
+
+static void watchdog_keepon_start(struct watchdog_device *wdd)
+{
+	watchdog_start(wdd);
+	watchdog_ping_timer_cb((unsigned long)wdd);
+}
+
+static void watchdog_keepon_stop(struct watchdog_device *wdd)
+{
+	del_timer_sync(&wdd->ping_timer);
+}
+
 /*
  *	watchdog_write: writes to the watchdog.
  *	@file: file from VFS
@@ -430,6 +452,9 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	if (!try_module_get(wdd->ops->owner))
 		goto out;
 
+	if (test_bit(WDOG_KEEP_ON, &wdd->status))
+		watchdog_keepon_stop(wdd);
+
 	err = watchdog_start(wdd);
 	if (err < 0)
 		goto out_mod;
@@ -472,8 +497,13 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	if (!test_bit(WDOG_ACTIVE, &wdd->status))
 		err = 0;
 	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
-		 !(wdd->info->options & WDIOF_MAGICCLOSE))
-		err = watchdog_stop(wdd);
+		 !(wdd->info->options & WDIOF_MAGICCLOSE)) {
+		if (test_bit(WDOG_KEEP_ON, &wdd->status)) {
+			watchdog_keepon_start(wdd);
+			err = 0;
+		} else
+			err = watchdog_stop(wdd);
+	}
 
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
@@ -524,6 +554,14 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 {
 	int err, devno;
 
+	if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
+		if (!try_module_get(watchdog->ops->owner))
+			return -ENODEV;
+		setup_timer(&watchdog->ping_timer, watchdog_ping_timer_cb,
+				(unsigned long)watchdog);
+		watchdog_keepon_start(watchdog);
+	}
+
 	if (watchdog->id == 0) {
 		old_wdd = watchdog;
 		watchdog_miscdev.parent = watchdog->parent;
@@ -535,6 +573,11 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 				pr_err("%s: a legacy watchdog module is probably present.\n",
 					watchdog->info->identity);
 			old_wdd = NULL;
+			if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
+				watchdog_keepon_stop(watchdog);
+				watchdog_stop(watchdog);
+				module_put(watchdog->ops->owner);
+			}
 			return err;
 		}
 	}
@@ -553,6 +596,11 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 			misc_deregister(&watchdog_miscdev);
 			old_wdd = NULL;
 		}
+		if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
+			watchdog_keepon_stop(watchdog);
+			watchdog_stop(watchdog);
+			module_put(watchdog->ops->owner);
+		}
 	}
 	return err;
 }
@@ -575,6 +623,12 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
 		misc_deregister(&watchdog_miscdev);
 		old_wdd = NULL;
 	}
+
+	if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
+		watchdog_keepon_stop(watchdog);
+		watchdog_stop(watchdog);
+		module_put(watchdog->ops->owner);
+	}
 	return 0;
 }
 
diff --git a/linux-3.14.17/include/linux/watchdog.h b/linux-3.14.17/include/linux/watchdog.h
index 2a3038e..650e0d5 100644
--- a/linux-3.14.17/include/linux/watchdog.h
+++ b/linux-3.14.17/include/linux/watchdog.h
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/timer.h>		/* for ping timer */
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
@@ -95,6 +96,8 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+#define WDOG_KEEP_ON		5	/* Is 'keep on' feature set? */
+	struct timer_list ping_timer;	/* timer to keep on hardware ping */
 };
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -104,6 +107,8 @@ struct watchdog_device {
 #define WATCHDOG_NOWAYOUT		0
 #define WATCHDOG_NOWAYOUT_INIT_STATUS	0
 #endif
+/* other proposal: WATCHDOG_ALWAYS_ACTIVE */
+#define WATCHDOG_KEEP_ON		(1 << WDOG_KEEP_ON)
 
 /* Use the following function to check whether or not the watchdog is active */
 static inline bool watchdog_active(struct watchdog_device *wdd)

--------------000907000909070102010203--
