Return-path: <j.uzycki@elproma.com.pl>
Message-ID: <54117DC1.5030307@elproma.com.pl>
Date: Thu, 11 Sep 2014 12:47:29 +0200
From: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
References: <S1751381AbaIDOwq/20140904145246Z+988@vger.kernel.org> <54088996.4040500@elproma.com.pl> <540C9383.9050307@roeck-us.net> <540D02E1.90403@elproma.com.pl> <540D1F8F.2080802@roeck-us.net> <540D9DBD.5050105@elproma.com.pl> <54108934.8050102@elproma.com.pl>
In-Reply-To: <54108934.8050102@elproma.com.pl>
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>


W dniu 2014-09-10 19:24, Janusz U¿ycki pisze:
> To store relation to the thread:
> http://www.spinics.net/lists/linux-watchdog/msg05013.html
>
> I propose to add to the patch rootfs's boot time parameter.
> If this time is not zero after the time timer stops pinging.
> The parameter is a time when userland is ready to maintain
> a watchdog alone if it supports wachdog at all.
> The parameter seems to be common for all watchdog drivers
> and could be defined by kernel's cmdline
> because the time concerns a specific machine, board/kernel
> and rootfs.
> Some userlands open /dev/watchdog only in critical moments
> and after they use magic close. Therefore the patch continues
> watchdog's pinging in kernel's space. For the case boot time
> parameters should be zero.
> It is just idea.
Below is implementation proposal for the idea.

best regards
Janusz

Subject: [PATCH] watchdog: boottime protection feature (requires 'keep on')


Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
  linux-3.14.17/drivers/watchdog/watchdog_core.c |  4 ++++
  linux-3.14.17/drivers/watchdog/watchdog_dev.c  | 11 +++++++++++
  2 files changed, 15 insertions(+)

diff --git a/linux-3.14.17/drivers/watchdog/watchdog_core.c 
b/linux-3.14.17/drivers/watchdog/watchdog_core.c
index cec9b55..13f3d3a 100644
--- a/linux-3.14.17/drivers/watchdog/watchdog_core.c
+++ b/linux-3.14.17/drivers/watchdog/watchdog_core.c
@@ -43,6 +43,10 @@
  static DEFINE_IDA(watchdog_ida);
  static struct class *watchdog_class;

+unsigned int boottime = 0;
+module_param(boottime, uint, 0);
+MODULE_PARM_DESC(boottime, "After the boot time active watchdog(s) have 
to be maintained by userland. 0 disables the protection.");
+
  static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
  {
         /*
diff --git a/linux-3.14.17/drivers/watchdog/watchdog_dev.c 
b/linux-3.14.17/drivers/watchdog/watchdog_dev.c
index 51a65f6..4b975da 100644
--- a/linux-3.14.17/drivers/watchdog/watchdog_dev.c
+++ b/linux-3.14.17/drivers/watchdog/watchdog_dev.c
@@ -42,6 +42,7 @@
  #include <linux/init.h>                /* For __init/__exit/... */
  #include <linux/uaccess.h>     /* For copy_to_user/put_user/... */
  #include <linux/jiffies.h>     /* for ping timer */
+#include <linux/time.h>                /* for uptime */

  #include "watchdog_core.h"

@@ -282,6 +283,16 @@ out_ioctl:
  static void watchdog_ping_timer_cb(unsigned long data)
  {
         struct watchdog_device *wdd = (struct watchdog_device *)data;
+       /* After the boot time active watchdog(s) have to be maintained 
by userland.
+        * The protection works only if boot time is non-zero
+        * and keep on feature is enabled */
+       extern unsigned int boottime;
+       if (boottime) {
+               struct timespec uptime;
+               get_monotonic_boottime(&uptime);
+               if (uptime.tv_sec > boottime)
+                       return;
+       }
         watchdog_ping(wdd);
         /* call next ping half the timeout value */
         mod_timer(&wdd->ping_timer,
--
1.7.11.3
