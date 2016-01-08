Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Oleksij Rempel <linux@rempel-privat.de>, Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: asm9260: remove __init and __exit annotations
Date: Fri, 08 Jan 2016 11:59:34 +0100
Message-ID: <24150770.U3pBDPnky8@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

The probe and release functions in this driver are marked
as __init and __exit, but this is wrong as indicated by this
Kbuild error message:

WARNING: vmlinux.o(.data+0x1d2308): Section mismatch in reference from the variable asm9260_wdt_driver to the function .init.text:asm9260_wdt_probe()

This removes the annotations, to make the sysfs unbind attribute
and deferred probing work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: aae03dc98177 ("watchdog: add Alphascale asm9260-wdt driver")

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 1c22ff4c523a..c9686b2fdafd 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -198,7 +198,7 @@ static struct watchdog_ops asm9260_wdt_ops = {
 	.set_timeout	= asm9260_wdt_settimeout,
 };
 
-static int __init asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
+static int asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
 {
 	int err;
 	unsigned long clk;
@@ -250,7 +250,7 @@ static int __init asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
 	return 0;
 }
 
-static void __init asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
+static void asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
 {
 	const char *tmp;
 	int ret;
@@ -274,7 +274,7 @@ static void __init asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
 			 tmp);
 }
 
-static int __init asm9260_wdt_probe(struct platform_device *pdev)
+static int asm9260_wdt_probe(struct platform_device *pdev)
 {
 	struct asm9260_wdt_priv *priv;
 	struct watchdog_device *wdd;
@@ -364,7 +364,7 @@ static void asm9260_wdt_shutdown(struct platform_device *pdev)
 	asm9260_wdt_disable(&priv->wdd);
 }
 
-static int __exit asm9260_wdt_remove(struct platform_device *pdev)
+static int asm9260_wdt_remove(struct platform_device *pdev)
 {
 	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
 
