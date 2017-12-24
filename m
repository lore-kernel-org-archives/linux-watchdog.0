Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38844 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdLXVEO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Dec 2017 16:04:14 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/12] watchdog: sp5100_tco: Fix watchdog disable bit
Date: Sun, 24 Dec 2017 13:03:58 -0800
Message-Id: <1514149448-20214-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1514149448-20214-1-git-send-email-linux@roeck-us.net>
References: <1514149448-20214-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

According to all published information, the watchdog disable bit for SB800
compatible controllers is bit 1 of PM register 0x48, not bit 2. For the
most part that doesn't matter in practice, since the bit has to be cleared
to enable watchdog address decoding, which is the default setting, but it
still needs to be fixed.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
index f495fe03887a..2622cfe23dc1 100644
--- a/drivers/watchdog/sp5100_tco.h
+++ b/drivers/watchdog/sp5100_tco.h
@@ -52,7 +52,7 @@
 #define SB800_PM_WATCHDOG_CONFIG	0x4C
 
 #define SB800_PCI_WATCHDOG_DECODE_EN	(1 << 0)
-#define SB800_PM_WATCHDOG_DISABLE	(1 << 2)
+#define SB800_PM_WATCHDOG_DISABLE	(1 << 1)
 #define SB800_PM_WATCHDOG_SECOND_RES	(3 << 0)
 #define SB800_ACPI_MMIO_DECODE_EN	(1 << 0)
 #define SB800_ACPI_MMIO_SEL		(1 << 1)
-- 
2.7.4

