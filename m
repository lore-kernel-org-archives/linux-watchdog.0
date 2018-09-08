Return-Path: <rpjday@crashcourse.ca>
Return-path: <rpjday@crashcourse.ca>
Date: Sat, 8 Sep 2018 06:20:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
cc: wim@linux-watchdog.org, linux@roeck-us.net
Subject: [PATCH] watchdog: fix a small number of "watchog" typos in
 comments
Message-ID: <alpine.LFD.2.21.1809071400230.14610@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-watchdog@vger.kernel.org>


All typos in comments, should not affect functionality.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 3ad1e44bef44..6e78a34c2370 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -25,7 +25,7 @@
 /* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
  * Also, the wdt_period sets the watchdog timer period timeout.
  * For E500 cpus the wdt_period sets which bit changing from 0->1 will
- * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
+ * trigger a watchdog timeout. This watchdog timeout will occur 3 times, the
  * first time nothing will happen, the second time a watchdog exception will
  * occur, and the final time the board will reset.
  */
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index b085ef1084ec..d56d0a927a1e 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -30,7 +30,7 @@
 #define VIA_WDT_CONF_MMIO	0x02	/* 1: enable watchdog MMIO */

 /*
- * The MMIO region contains the watchog control register and the
+ * The MMIO region contains the watchdog control register and the
  * hardware timer counter.
  */
 #define VIA_WDT_MMIO_LEN	8	/* MMIO region length in bytes */
@@ -82,7 +82,7 @@ static inline void wdt_reset(void)
 /*
  * Timer tick: the timer will make sure that the watchdog timer hardware
  * is being reset in time. The conditions to do this are:
- *  1) the watchog timer has been started and /dev/watchdog is open
+ *  1) the watchdog timer has been started and /dev/watchdog is open
  *     and there is still time left before userspace should send the
  *     next heartbeat/ping. (note: the internal heartbeat is much smaller
  *     then the external/userspace heartbeat).

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
