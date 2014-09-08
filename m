Return-path: <j.uzycki@elproma.com.pl>
Message-ID: <540D02E1.90403@elproma.com.pl>
Date: Mon, 08 Sep 2014 03:14:09 +0200
From: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
References: <S1751381AbaIDOwq/20140904145246Z+988@vger.kernel.org> <54088996.4040500@elproma.com.pl> <540C9383.9050307@roeck-us.net>
In-Reply-To: <540C9383.9050307@roeck-us.net>
Content-Type: multipart/mixed;
 boundary="------------010101070307010602050108"
List-ID: <linux-watchdog@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010101070307010602050108
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 8bit

W dniu 2014-09-07 19:18, Guenter Roeck pisze:
> On 09/04/2014 08:47 AM, Janusz U¿ycki wrote:
>> Some applications require to start watchdog before userspace 
>> software. This patch enables such feature. Only WATCHDOG_KERNEL_PING 
>> flag is necessary to enable it (attached example for 
>> stmp3xxx_rtc_wdt.c). Moreover kernel's ping is re-enabled when 
>> userspace software closed watchdog using the magic character. The 
>> features improves kernel's reliable if hardware watchdog is available.
>> * Can you comment the proposed patch?
>> * Shoud dynamic or static timer_list be used (small structure...)?
dynamic or static timer?

>> * I also added wdd->ops->ref/unref calls but I'm afraid that even 
>> original code is buggy in watchdog_dev.c. Is any driver that uses the 
>> pointers? In my opinion watchdog_open() should call wdd->ops->ref() 
>> before watchdog_start() and watchdog_release() should call 
>> wdd->ops->unref() before module_put(). Otherwise fault is possible if 
>> watchdog module is unloaded.
>> * I noticed that current watchdog core does not support 
>> suspend/resume case. If you want to use suspend without the patch you 
>> need to close a watchdog in userspace using the magic character 
>> before suspend command. With the patch you must to use 
>> WDIOC_SETOPTIONS ioctl and WDIOS_DISABLECARD/WDIOS_ENABLECARD. Is 
>> there any other method to suspend with watchdog?
Can kernel suspend a started (stoppable) watchdog? It dissapeared in 
3.x. Now userland reaction seems to be required.

> I like the basic idea. Couple of comments.
Thanks. Below a fixed patch code.

> Please read and follow Documentation/SubmittingPatches.
> Long lines as above are discouraged, as is sending patches
> as attachment. As you can see, the patch disappears in the
> reply, making it very hard to comment on it.
fixed.
I also attached the patch file - I don't trust email client in text 
formatting (tabs)

> I would suggest to just modify the timer to half the timeout value,
> and then just ping the watchdog unconditionally whenever the callback
> runs. The timer should stop when the watchdog is opened, so there
> should not be a need to check its open status in the callback.
you are right, fixed

> I don't think there is a need to manipulate the driver reference
> count when the kernel timer starts and stops. You already run
> module_get and module_put during registration / unregistration.
removed

> I would not call this "kernel ping". We'll need to find a better
> name. Proposals welcome. Something indicating the status, ie something
> indicating that the wdt is always running and can not be stopped.
"keep on" proposed (I changed the subject also)

> You would not update the status in the affected driver(s) by
> setting the flag in the probe function. You can use the status
> flag initialization for that purpose.
fixed as example

> Also, we'll need to know if
> the driver you changed is always affected or only in your system.
> Either case, driver patches need to be submitted separately.
I used to add similar code to different wachdog drivers for embedded 
boards. This time I work under quite new kernel 3.14 and therefore I 
finally decided to submit a patch.
The feature should be generally used for all hardware watchdogs. 
Unfortunately some drivers uses own timers, eg. to increase timeout 
period. Another exception is softdog.

> We'll need to tie this functionality with parallel efforts
> to add similar code into individual drivers. There is one patch
> along that line pending right now [1],
I saw it and agree - they can cooperate

> and I think there is similar
> support in other drivers. dw_wdt is one example where the wdt can
> not be stopped after it was started, of_xilinx_wdt is another.
So it is similar to at91sam9g20 as I remember but Atmel's watchdog 
driver uses constant hardware timeout stretched by the driver.

> Given that, there are two use states to consider: WDT is always running,
> and WDT can not be stopped after it was started once. We should cover
> both cases.
and third: ability to stop watchdog (if possible) for suspend

> The feature should have DT support from the beginning if possible,
> though it should be added as a separate patch in case there is
> a hiccup with the DT folks.
Can you give more details?

> It might be worthwhile exploring if the same mechanism can be used
> to augment user space pinging with kernel ping if the maximum timeout
> is too short to be handled by user space alone. That should be a
> separate patch, but we need to keep this use case in mind.
I agree - unification is welcomed.

Janusz
>
> Guenter
>
> ---
> [1] http://patchwork.roeck-us.net/patch/1890/

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
index d4fae2c..f16955d 100644
--- a/linux-3.14.17/drivers/watchdog/watchdog_dev.c
+++ b/linux-3.14.17/drivers/watchdog/watchdog_dev.c
@@ -41,8 +41,8 @@
  #include <linux/miscdevice.h>    /* For handling misc devices */
  #include <linux/init.h>        /* For __init/__exit/... */
  #include <linux/uaccess.h>    /* For copy_to_user/put_user/... */
-#include <linux/slab.h>        /* for kernel ping timer (dynamic) */
-#include <linux/jiffies.h>    /* for kernel ping timer */
+#include <linux/slab.h>        /* for 'keep on' timer (dynamic) */
+#include <linux/jiffies.h>    /* for 'keep on' timer */

  #include "watchdog_core.h"

@@ -279,32 +279,27 @@ out_ioctl:
      return err;
  }

-/* kernel ping feature */
-static void watchdog_kping_timer_cb(unsigned long data)
+/* 'keep on' feature */
+static void watchdog_keepon_timer_cb(unsigned long data)
  {
      struct watchdog_device *wdd = (struct watchdog_device *)data;
-    if (test_bit(WDOG_KERNEL_PING, &wdd->status) && 
!test_bit(WDOG_DEV_OPEN, &wdd->status)) {
-        watchdog_ping(wdd);
-        /* call next ping a second or 0.5s before hardware timeout */
-        mod_timer(wdd->kping_timer, wdd->timeout > 1 ?
-                jiffies + (wdd->timeout - 1) * HZ : jiffies + HZ/2);
-    }
+    watchdog_ping(wdd);
+    /* call next ping half the timeout value */
+    mod_timer(wdd->keepon_timer,
+            jiffies + wdd->timeout * (HZ/2));
  }

-static void watchdog_kping_start(struct watchdog_device *wdd)
+static void watchdog_keepon_start(struct watchdog_device *wdd)
  {
-    if (wdd->ops->ref)
-        wdd->ops->ref(wdd);
      watchdog_start(wdd);
+    /* watchdog_keepon_timer_cb((unsigned long)wdd); or the code below: */
      watchdog_ping(wdd);
-    mod_timer(wdd->kping_timer, jiffies + HZ/2);
+    mod_timer(wdd->keepon_timer, jiffies + HZ/2);
  }

-static void watchdog_kping_stop(struct watchdog_device *wdd)
+static void watchdog_keepon_stop(struct watchdog_device *wdd)
  {
-    del_timer_sync(wdd->kping_timer);
-    if (wdd->ops->unref)
-        wdd->ops->unref(wdd);
+    del_timer_sync(wdd->keepon_timer);
  }

  /*
@@ -460,8 +455,8 @@ static int watchdog_open(struct inode *inode, struct 
file *file)
      if (!try_module_get(wdd->ops->owner))
          goto out;

-    if (test_bit(WDOG_KERNEL_PING, &wdd->status))
-        watchdog_kping_stop(wdd);
+    if (test_bit(WDOG_KEEP_ON, &wdd->status))
+        watchdog_keepon_stop(wdd);

      err = watchdog_start(wdd);
      if (err < 0)
@@ -506,8 +501,8 @@ static int watchdog_release(struct inode *inode, 
struct file *file)
          err = 0;
      else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
           !(wdd->info->options & WDIOF_MAGICCLOSE)) {
-        if (test_bit(WDOG_KERNEL_PING, &wdd->status)) {
-            watchdog_kping_start(wdd);
+        if (test_bit(WDOG_KEEP_ON, &wdd->status)) {
+            watchdog_keepon_start(wdd);
              err = 0;
          } else
              err = watchdog_stop(wdd);
@@ -562,14 +557,16 @@ int watchdog_dev_register(struct watchdog_device 
*watchdog)
  {
      int err, devno;

-    if (test_bit(WDOG_KERNEL_PING, &watchdog->status)) {
+    if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
          if (!try_module_get(watchdog->ops->owner))
              return -ENODEV;
-        watchdog->kping_timer = kzalloc(sizeof(*watchdog->kping_timer), 
GFP_KERNEL);
-        if (!watchdog->kping_timer)
+        watchdog->keepon_timer =
+            kzalloc(sizeof(*watchdog->keepon_timer), GFP_KERNEL);
+        if (!watchdog->keepon_timer)
              return -ENOMEM;
-        setup_timer(watchdog->kping_timer, watchdog_kping_timer_cb, 
(unsigned long)watchdog);
-        watchdog_kping_start(watchdog);
+        setup_timer(watchdog->keepon_timer, watchdog_keepon_timer_cb,
+                (unsigned long)watchdog);
+        watchdog_keepon_start(watchdog);
      }

      if (watchdog->id == 0) {
@@ -624,11 +621,11 @@ int watchdog_dev_unregister(struct watchdog_device 
*watchdog)
          old_wdd = NULL;
      }

-    if (test_bit(WDOG_KERNEL_PING, &watchdog->status) || 
watchdog->kping_timer) {
-        watchdog_kping_stop(watchdog);
-        watchdog_stop(watchdog);
-        kfree(watchdog->kping_timer);
-        watchdog->kping_timer = NULL;
+    if (test_bit(WDOG_KEEP_ON, &watchdog->status) ||
+            watchdog->keepon_timer) {
+        watchdog_keepon_stop(watchdog);
+        kfree(watchdog->keepon_timer);
+        watchdog->keepon_timer = NULL;
          watchdog_stop(watchdog);
          module_put(watchdog->ops->owner);
      }
diff --git a/linux-3.14.17/include/linux/watchdog.h 
b/linux-3.14.17/include/linux/watchdog.h
index 8cf9148..57b552a 100644
--- a/linux-3.14.17/include/linux/watchdog.h
+++ b/linux-3.14.17/include/linux/watchdog.h
@@ -12,7 +12,7 @@
  #include <linux/bitops.h>
  #include <linux/device.h>
  #include <linux/cdev.h>
-#include <linux/timer.h>        /* for kernel ping timer */
+#include <linux/timer.h>        /* for 'keep on' timer */
  #include <uapi/linux/watchdog.h>

  struct watchdog_ops;
@@ -96,9 +96,9 @@ struct watchdog_device {
  #define WDOG_ALLOW_RELEASE    2    /* Did we receive the magic char ? */
  #define WDOG_NO_WAY_OUT        3    /* Is 'nowayout' feature set ? */
  #define WDOG_UNREGISTERED    4    /* Has the device been unregistered */
-#define WDOG_KERNEL_PING    5    /* Ping is done by kernel if device 
not opened by userland */
-    struct timer_list *kping_timer;    /* kernel ping timer */
-#define WATCHDOG_KERNEL_PING    (1 << WDOG_KERNEL_PING)
+#define WDOG_KEEP_ON        5    /* Is 'keep on' feature set? */
+    struct timer_list *keepon_timer;/* 'keep on' timer */
+#define WATCHDOG_KEEP_ON    (1 << WDOG_KEEP_ON)
  };

  #ifdef CONFIG_WATCHDOG_NOWAYOUT


--------------010101070307010602050108
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
index d4fae2c..f16955d 100644
--- a/linux-3.14.17/drivers/watchdog/watchdog_dev.c
+++ b/linux-3.14.17/drivers/watchdog/watchdog_dev.c
@@ -41,8 +41,8 @@
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
-#include <linux/slab.h>		/* for kernel ping timer (dynamic) */
-#include <linux/jiffies.h>	/* for kernel ping timer */
+#include <linux/slab.h>		/* for 'keep on' timer (dynamic) */
+#include <linux/jiffies.h>	/* for 'keep on' timer */
 
 #include "watchdog_core.h"
 
@@ -279,32 +279,27 @@ out_ioctl:
 	return err;
 }
 
-/* kernel ping feature */
-static void watchdog_kping_timer_cb(unsigned long data)
+/* 'keep on' feature */
+static void watchdog_keepon_timer_cb(unsigned long data)
 {
 	struct watchdog_device *wdd = (struct watchdog_device *)data;
-	if (test_bit(WDOG_KERNEL_PING, &wdd->status) && !test_bit(WDOG_DEV_OPEN, &wdd->status)) {
-		watchdog_ping(wdd);
-		/* call next ping a second or 0.5s before hardware timeout */
-		mod_timer(wdd->kping_timer, wdd->timeout > 1 ?
-				jiffies + (wdd->timeout - 1) * HZ : jiffies + HZ/2);
-	}
+	watchdog_ping(wdd);
+	/* call next ping half the timeout value */
+	mod_timer(wdd->keepon_timer,
+			jiffies + wdd->timeout * (HZ/2));
 }
 
-static void watchdog_kping_start(struct watchdog_device *wdd)
+static void watchdog_keepon_start(struct watchdog_device *wdd)
 {
-	if (wdd->ops->ref)
-		wdd->ops->ref(wdd);
 	watchdog_start(wdd);
+	/* watchdog_keepon_timer_cb((unsigned long)wdd); or the code below: */
 	watchdog_ping(wdd);
-	mod_timer(wdd->kping_timer, jiffies + HZ/2);
+	mod_timer(wdd->keepon_timer, jiffies + HZ/2);
 }
 
-static void watchdog_kping_stop(struct watchdog_device *wdd)
+static void watchdog_keepon_stop(struct watchdog_device *wdd)
 {
-	del_timer_sync(wdd->kping_timer);
-	if (wdd->ops->unref)
-		wdd->ops->unref(wdd);
+	del_timer_sync(wdd->keepon_timer);
 }
 
 /*
@@ -460,8 +455,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	if (!try_module_get(wdd->ops->owner))
 		goto out;
 
-	if (test_bit(WDOG_KERNEL_PING, &wdd->status))
-		watchdog_kping_stop(wdd);
+	if (test_bit(WDOG_KEEP_ON, &wdd->status))
+		watchdog_keepon_stop(wdd);
 
 	err = watchdog_start(wdd);
 	if (err < 0)
@@ -506,8 +501,8 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		err = 0;
 	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
 		 !(wdd->info->options & WDIOF_MAGICCLOSE)) {
-		if (test_bit(WDOG_KERNEL_PING, &wdd->status)) {
-			watchdog_kping_start(wdd);
+		if (test_bit(WDOG_KEEP_ON, &wdd->status)) {
+			watchdog_keepon_start(wdd);
 			err = 0;
 		} else
 			err = watchdog_stop(wdd);
@@ -562,14 +557,16 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 {
 	int err, devno;
 
-	if (test_bit(WDOG_KERNEL_PING, &watchdog->status)) {
+	if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
 		if (!try_module_get(watchdog->ops->owner))
 			return -ENODEV;
-		watchdog->kping_timer = kzalloc(sizeof(*watchdog->kping_timer), GFP_KERNEL);
-		if (!watchdog->kping_timer)
+		watchdog->keepon_timer =
+			kzalloc(sizeof(*watchdog->keepon_timer), GFP_KERNEL);
+		if (!watchdog->keepon_timer)
 			return -ENOMEM;
-		setup_timer(watchdog->kping_timer, watchdog_kping_timer_cb, (unsigned long)watchdog);
-		watchdog_kping_start(watchdog);
+		setup_timer(watchdog->keepon_timer, watchdog_keepon_timer_cb,
+				(unsigned long)watchdog);
+		watchdog_keepon_start(watchdog);
 	}
 
 	if (watchdog->id == 0) {
@@ -624,11 +621,11 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
 		old_wdd = NULL;
 	}
 
-	if (test_bit(WDOG_KERNEL_PING, &watchdog->status) || watchdog->kping_timer) {
-		watchdog_kping_stop(watchdog);
-		watchdog_stop(watchdog);
-		kfree(watchdog->kping_timer);
-		watchdog->kping_timer = NULL;
+	if (test_bit(WDOG_KEEP_ON, &watchdog->status) ||
+			watchdog->keepon_timer) {
+		watchdog_keepon_stop(watchdog);
+		kfree(watchdog->keepon_timer);
+		watchdog->keepon_timer = NULL;
 		watchdog_stop(watchdog);
 		module_put(watchdog->ops->owner);
 	}
diff --git a/linux-3.14.17/include/linux/watchdog.h b/linux-3.14.17/include/linux/watchdog.h
index 8cf9148..57b552a 100644
--- a/linux-3.14.17/include/linux/watchdog.h
+++ b/linux-3.14.17/include/linux/watchdog.h
@@ -12,7 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
-#include <linux/timer.h>		/* for kernel ping timer */
+#include <linux/timer.h>		/* for 'keep on' timer */
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
@@ -96,9 +96,9 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
-#define WDOG_KERNEL_PING	5	/* Ping is done by kernel if device not opened by userland */
-	struct timer_list *kping_timer;	/* kernel ping timer */
-#define WATCHDOG_KERNEL_PING	(1 << WDOG_KERNEL_PING)
+#define WDOG_KEEP_ON		5	/* Is 'keep on' feature set? */
+	struct timer_list *keepon_timer;/* 'keep on' timer */
+#define WATCHDOG_KEEP_ON	(1 << WDOG_KEEP_ON)
 };
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT

--------------010101070307010602050108--
