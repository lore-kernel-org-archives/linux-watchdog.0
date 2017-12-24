Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33460 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbdLXVEd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Dec 2017 16:04:33 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 10/12] watchdog: sp5100_tco: Use bit operations
Date: Sun, 24 Dec 2017 13:04:15 -0800
Message-Id: <1514149457-20273-11-git-send-email-linux@roeck-us.net>
In-Reply-To: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Using bit operations makes it easier to improve the driver.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.h | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
index cc00f1157220..ca0721c8d879 100644
--- a/drivers/watchdog/sp5100_tco.h
+++ b/drivers/watchdog/sp5100_tco.h
@@ -7,6 +7,8 @@
  *	TCO timer driver for sp5100 chipsets
  */
 
+#include <linux/bitops.h>
+
 /*
  * Some address definitions for the Watchdog
  */
@@ -14,10 +16,10 @@
 #define SP5100_WDT_CONTROL(base)	((base) + 0x00) /* Watchdog Control */
 #define SP5100_WDT_COUNT(base)		((base) + 0x04) /* Watchdog Count */
 
-#define SP5100_WDT_START_STOP_BIT	(1 << 0)
-#define SP5100_WDT_FIRED		(1 << 1)
-#define SP5100_WDT_ACTION_RESET		(1 << 2)
-#define SP5100_WDT_TRIGGER_BIT		(1 << 7)
+#define SP5100_WDT_START_STOP_BIT	BIT(0)
+#define SP5100_WDT_FIRED		BIT(1)
+#define SP5100_WDT_ACTION_RESET		BIT(2)
+#define SP5100_WDT_TRIGGER_BIT		BIT(7)
 
 #define SP5100_PM_IOPORTS_SIZE		0x02
 
@@ -37,10 +39,10 @@
 #define SP5100_PM_WATCHDOG_BASE		0x6C
 
 #define SP5100_PCI_WATCHDOG_MISC_REG	0x41
-#define SP5100_PCI_WATCHDOG_DECODE_EN	(1 << 3)
+#define SP5100_PCI_WATCHDOG_DECODE_EN	BIT(3)
 
-#define SP5100_PM_WATCHDOG_DISABLE	(1 << 0)
-#define SP5100_PM_WATCHDOG_SECOND_RES	(3 << 1)
+#define SP5100_PM_WATCHDOG_DISABLE	((u8)BIT(0))
+#define SP5100_PM_WATCHDOG_SECOND_RES	GENMASK(2, 1)
 
 #define SP5100_DEVNAME			"SP5100 TCO"
 
@@ -50,12 +52,11 @@
 #define SB800_PM_WATCHDOG_BASE		0x48
 #define SB800_PM_WATCHDOG_CONFIG	0x4C
 
-#define SB800_PCI_WATCHDOG_DECODE_EN	(1 << 0)
-#define SB800_PM_WATCHDOG_DISABLE	(1 << 1)
-#define SB800_PM_WATCHDOG_SECOND_RES	(3 << 0)
-#define SB800_ACPI_MMIO_DECODE_EN	(1 << 0)
-#define SB800_ACPI_MMIO_SEL		(1 << 1)
-
+#define SB800_PCI_WATCHDOG_DECODE_EN	BIT(0)
+#define SB800_PM_WATCHDOG_DISABLE	((u8)BIT(1))
+#define SB800_PM_WATCHDOG_SECOND_RES	GENMASK(1, 0)
+#define SB800_ACPI_MMIO_DECODE_EN	BIT(0)
+#define SB800_ACPI_MMIO_SEL		BIT(1)
 
 #define SB800_PM_WDT_MMIO_OFFSET	0xB00
 
-- 
2.7.4

