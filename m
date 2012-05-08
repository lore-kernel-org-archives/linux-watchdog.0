Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:42595 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751713Ab2EHGXM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 May 2012 02:23:12 -0400
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linux-watchdog@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC: Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: [PATCH 2/2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with CONFIG_FSL_SOC_BOOKE
Date: Tue, 8 May 2012 14:07:56 +0800
Message-ID: <1336457276-32611-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

CONFIG_FSL_BOOKE is only defined in 32-bit, CONFIG_FSL_SOC_BOOKE is
defined in both 32-bit and 64-bit, so use CONFIG_FSL_SOC_BOOKE to make
diver work in 32-bit & 64-bit.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 drivers/watchdog/Kconfig     |    8 ++++----
 drivers/watchdog/booke_wdt.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3709624..4373ca0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1094,10 +1094,10 @@ config BOOKE_WDT
 config BOOKE_WDT_DEFAULT_TIMEOUT
 	int "PowerPC Book-E Watchdog Timer Default Timeout"
 	depends on BOOKE_WDT
-	default 38 if FSL_BOOKE
-	range 0 63 if FSL_BOOKE
-	default 3 if !FSL_BOOKE
-	range 0 3 if !FSL_BOOKE
+	default 38 if FSL_SOC_BOOKE
+	range 0 63 if FSL_SOC_BOOKE
+	default 3 if !FSL_SOC_BOOKE
+	range 0 3 if !FSL_SOC_BOOKE
 	help
 	  Select the default watchdog timer period to be used by the PowerPC
 	  Book-E watchdog driver.  A watchdog "event" occurs when the bit
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index ce0ab44..338a437 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -37,7 +37,7 @@
 u32 booke_wdt_enabled;
 u32 booke_wdt_period = CONFIG_BOOKE_WDT_DEFAULT_TIMEOUT;
 
-#ifdef	CONFIG_FSL_BOOKE
+#ifdef	CONFIG_FSL_SOC_BOOKE
 #define WDTP(x)		((((x)&0x3)<<30)|(((x)&0x3c)<<15))
 #define WDTP_MASK	(WDTP(0x3f))
 #else
@@ -190,7 +190,7 @@ static long booke_wdt_ioctl(struct file *file,
 	case WDIOC_SETTIMEOUT:
 		if (get_user(tmp, p))
 			return -EFAULT;
-#ifdef	CONFIG_FSL_BOOKE
+#ifdef	CONFIG_FSL_SOC_BOOKE
 		/* period of 1 gives the largest possible timeout */
 		if (tmp > period_to_sec(1))
 			return -EINVAL;
-- 
1.6.4


