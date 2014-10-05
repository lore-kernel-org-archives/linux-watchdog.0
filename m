Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:65196 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaJEBWp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 4 Oct 2014 21:22:45 -0400
Message-ID: <54309EC1.6040801@gmail.com>
Date: Sun, 05 Oct 2014 09:28:33 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
To: wim@iguana.be, Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: Let XILINX_WATCHDOG and TEGRA_WATCHDOG depend
 on HAS_IOMEM
References: <542FC064.1030604@gmail.com>
In-Reply-To: <542FC064.1030604@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

They need HAS_IOMEM, so let them depend on it, the related error (with
allmodconfig under um):

    MODPOST 1205 modules
  ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] undefined!
  ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko] undefined!

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/watchdog/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a51ccf3..d0ddf90 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -132,6 +132,7 @@ config WM8350_WATCHDOG
 
 config XILINX_WATCHDOG
 	tristate "Xilinx Watchdog timer"
+	depends on HAS_IOMEM
 	select WATCHDOG_CORE
 	help
 	  Watchdog driver for the xps_timebase_wdt ip core.
@@ -472,7 +473,7 @@ config SIRFSOC_WATCHDOG
 
 config TEGRA_WATCHDOG
 	tristate "Tegra watchdog"
-	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on (ARCH_TEGRA || COMPILE_TEST) && HAS_IOMEM
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
-- 
1.9.3


