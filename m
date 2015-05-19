Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51226 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754522AbbESI0o (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:26:44 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv8 03/10] watchdog: core: Introduce default watchdog policy
Date: Tue, 19 May 2015 11:26:02 +0300
Message-Id: <1432023969-20736-4-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Traditionally there have been no such thing as a policy for
watchdogs. The watchdog timer was simply explicitly stopped at driver
probe time and there was nothing else to do. Now that we have ability
to work around HW disabilities in the watchdog core, it is time to
introduce more policy options.

The default option is to shut down the watchdog driver, as
before. This ensures backward compatibility with current kernels and
hardware that might have a watchdog, but user has not set up a
watchdog daemon at all.

A new option is introduced to keep the watchdog running or start it up
at boot up. This is useful on many production systems that rely on the
watchdog to reboot the device in case a crash. With this option even
early kernel crashes or early user space crashes will lead to a reboot
even though watchdog daemon has not opened and started the watchdog
device yet.

The third introduced option is to not touch the hardware at all in
case bootloader have made an intelligent decision about the watchdog
state and does not know how to tell kernel about it. The watchdog
state is not touched until userspace takes over it.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/Kconfig         | 51 ++++++++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_core.c | 23 +++++++++++++++---
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e5e7c55..0066d6d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -45,6 +45,57 @@ config WATCHDOG_NOWAYOUT
 	  get killed. If you say Y here, the watchdog cannot be stopped once
 	  it has been started.
 
+choice
+	prompt "Watchdog default policy"
+	default WATCHDOG_BOOT_STOPPED
+	depends on WATCHDOG_CORE
+	help
+	  Choose the default policy for watchdog device during boot up
+	  time. The default is to stop the watchdog until a watchdog
+	  daemon opens the device. This is also the traditional way
+	  watchdogs have been behaving. Some production systems might
+	  require the watchdog hardware never stops, but this requires
+	  the system has watchdog daemon starting up early in the boot
+	  process.
+
+	  This config option selects the default built in policy in
+	  case no other policy is defined.
+
+	  If unsure, select 'Stop at boot'
+
+config WATCHDOG_BOOT_STOPPED
+	bool "Stop at boot up"
+	help
+	  Stop the watchdog when driver loads. This is good for
+	  distribution kernels that don't know whether there is a
+	  watchdog daemon at all or user might start the watchdog
+	  manually.
+
+config WATCHDOG_BOOT_RUNNING
+	bool "Start at boot up"
+	help
+	  Start the watchdog timer as soon as the driver loads. This
+	  is suitable on production systems that always have a
+	  watchdog daemon running and it is mandatory for the system
+	  to reset on any crash. If watchdog hardware was already
+	  running before kernel starts up, this option guarantees the
+	  watchdog timer is running continuously until userspace opens
+	  the device. Combine this with WATCHDOG_NOWAYOUT and it is
+	  guaranteed that watchdog can not be stopped from userspace
+	  at all.
+
+config WATCHDOG_BOOT_NOTOUCH
+	bool "Do not change watchdog state"
+	help
+	  Do not change the watchdog state at all. If the watchdog is
+	  running when driver loads, it is not stopped. If the
+	  watchdog is stopped, it is not started. This is useful in
+	  case bootloader has already made a rational policy choice
+	  with the watchdog and user space knows how to handle that
+	  properly. Kernel does not interfere in the between any way.
+
+endchoice
+
 #
 # General Watchdog drivers
 #
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 16e10e0..9ae5b8e 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -193,16 +193,33 @@ static void watchdog_worker(struct work_struct *work)
 
 static int prepare_watchdog(struct watchdog_device *wdd)
 {
+	bool watchdog_policy_start = false;
+	bool watchdog_policy_stop = false;
+
 	if (watchdog_needs_legacy_handling(wdd)) {
 		pr_info("Incomplete watchdog driver implementation, please report or fix\n");
 		return 0;
 	}
 
-	if (!watchdog_hw_active(wdd))
+	/* Figure out proper watchdog boot up state */
+
+	watchdog_policy_start = IS_ENABLED(CONFIG_WATCHDOG_BOOT_RUNNING);
+	watchdog_policy_stop = IS_ENABLED(CONFIG_WATCHDOG_BOOT_STOPPED);
+
+	if (!watchdog_hw_active(wdd) && watchdog_policy_stop)
 		return 0;
 
-	/* Stop the watchdog now until user space opens the device */
-	return watchdog_stop(wdd);
+	if (watchdog_policy_start && !watchdog_hw_active(wdd))
+		return watchdog_start(wdd);
+
+	if (watchdog_policy_stop && watchdog_hw_active(wdd))
+		return watchdog_stop(wdd);
+
+	/*
+	 * WATCHDOG_BOOT_NOTOUCH gets us here, don't touch the
+	 * watchdog at all.
+	 */
+	return 0;
 }
 
 /**
-- 
2.1.0

