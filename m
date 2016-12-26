Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33491 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754261AbcLZRGQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Dec 2016 12:06:16 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, wim@iguana.be, linux@roeck-us.net,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        support.opensource@diasemi.com, baruch@tkos.co.il,
        manabian@gmail.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH v2] watchdog: constify watchdog_info structures
Date: Mon, 26 Dec 2016 22:35:11 +0530
Message-Id: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Declare watchdog_info structures as const as they are only stored in the
info field of watchdog_device structures. This field is of type const
struct watchdog_info *, so watchdog_info structures having this property
can be declared const too.
Done using Coccinelle:

@r1 disable optional_qualifier@
identifier i;
position p;
@@
static struct watchdog_info i@p={...};

@ok@
identifier r1.i;
position p;
struct watchdog_device obj;
@@
obj.info=&i@p;

@bad@
position p!={r1.p,ok.p};
identifier r1.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct watchdog_info i;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Changes in v2:
  * Drop "drivers:" from the subject line.
  * Remove the file size details.

 drivers/watchdog/bcm7038_wdt.c   | 2 +-
 drivers/watchdog/bcm_kona_wdt.c  | 2 +-
 drivers/watchdog/cadence_wdt.c   | 2 +-
 drivers/watchdog/da9052_wdt.c    | 2 +-
 drivers/watchdog/da9055_wdt.c    | 2 +-
 drivers/watchdog/digicolor_wdt.c | 2 +-
 drivers/watchdog/imgpdc_wdt.c    | 2 +-
 drivers/watchdog/kempld_wdt.c    | 2 +-
 drivers/watchdog/lpc18xx_wdt.c   | 2 +-
 drivers/watchdog/rn5t618_wdt.c   | 2 +-
 drivers/watchdog/sbsa_gwdt.c     | 2 +-
 drivers/watchdog/w83627hf_wdt.c  | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index e238df4..37c6a49 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -101,7 +101,7 @@ static unsigned int bcm7038_wdt_get_timeleft(struct watchdog_device *wdog)
 	return time_left / wdt->rate;
 }
 
-static struct watchdog_info bcm7038_wdt_info = {
+static const struct watchdog_info bcm7038_wdt_info = {
 	.identity	= "Broadcom BCM7038 Watchdog Timer",
 	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
 				WDIOF_MAGICCLOSE
diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index e0c9842..76b0080 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -274,7 +274,7 @@ static int bcm_kona_wdt_stop(struct watchdog_device *wdog)
 	.get_timeleft =	bcm_kona_wdt_get_timeleft,
 };
 
-static struct watchdog_info bcm_kona_wdt_info = {
+static const struct watchdog_info bcm_kona_wdt_info = {
 	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
 			WDIOF_KEEPALIVEPING,
 	.identity =	"Broadcom Kona Watchdog Timer",
diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 98acef7..8d61e8b 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -262,7 +262,7 @@ static irqreturn_t cdns_wdt_irq_handler(int irq, void *dev_id)
  * Info structure used to indicate the features supported by the device
  * to the upper layers. This is defined in watchdog.h header file.
  */
-static struct watchdog_info cdns_wdt_info = {
+static const struct watchdog_info cdns_wdt_info = {
 	.identity	= "cdns_wdt watchdog",
 	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
 			  WDIOF_MAGICCLOSE,
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 2fc19a3..d86a57e 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -140,7 +140,7 @@ static int da9052_wdt_ping(struct watchdog_device *wdt_dev)
 	return ret;
 }
 
-static struct watchdog_info da9052_wdt_info = {
+static const struct watchdog_info da9052_wdt_info = {
 	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 	.identity	= "DA9052 Watchdog",
 };
diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 8377c43..4f30818 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -108,7 +108,7 @@ static int da9055_wdt_stop(struct watchdog_device *wdt_dev)
 	return da9055_wdt_set_timeout(wdt_dev, 0);
 }
 
-static struct watchdog_info da9055_wdt_info = {
+static const struct watchdog_info da9055_wdt_info = {
 	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 	.identity	= "DA9055 Watchdog",
 };
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 77df772..dfe7294 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -105,7 +105,7 @@ static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
 	.restart        = dc_wdt_restart,
 };
 
-static struct watchdog_info dc_wdt_info = {
+static const struct watchdog_info dc_wdt_info = {
 	.options	= WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE
 			| WDIOF_KEEPALIVEPING,
 	.identity	= "Conexant Digicolor Watchdog",
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 516fbef..6ed39de 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -161,7 +161,7 @@ static int pdc_wdt_restart(struct watchdog_device *wdt_dev,
 	return 0;
 }
 
-static struct watchdog_info pdc_wdt_info = {
+static const struct watchdog_info pdc_wdt_info = {
 	.identity	= "IMG PDC Watchdog",
 	.options	= WDIOF_SETTIMEOUT |
 			  WDIOF_KEEPALIVEPING |
diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 8e302d0..73c46b3 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -422,7 +422,7 @@ static int kempld_wdt_probe_stages(struct watchdog_device *wdd)
 	return 0;
 }
 
-static struct watchdog_info kempld_wdt_info = {
+static const struct watchdog_info kempld_wdt_info = {
 	.identity	= "KEMPLD Watchdog",
 	.options	= WDIOF_SETTIMEOUT |
 			WDIOF_KEEPALIVEPING |
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index fd171e6..3b8bb59 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -181,7 +181,7 @@ static int lpc18xx_wdt_restart(struct watchdog_device *wdt_dev,
 	return 0;
 }
 
-static struct watchdog_info lpc18xx_wdt_info = {
+static const struct watchdog_info lpc18xx_wdt_info = {
 	.identity	= "NXP LPC18xx Watchdog",
 	.options	= WDIOF_SETTIMEOUT |
 			  WDIOF_KEEPALIVEPING |
diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
index 0805ee2..e60f557 100644
--- a/drivers/watchdog/rn5t618_wdt.c
+++ b/drivers/watchdog/rn5t618_wdt.c
@@ -130,7 +130,7 @@ static int rn5t618_wdt_ping(struct watchdog_device *wdt_dev)
 				  RN5T618_PWRIRQ_IR_WDOG, 0);
 }
 
-static struct watchdog_info rn5t618_wdt_info = {
+static const struct watchdog_info rn5t618_wdt_info = {
 	.options	= WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
 			  WDIOF_KEEPALIVEPING,
 	.identity	= DRIVER_NAME,
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index ce0c38b..e9966bc 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -207,7 +207,7 @@ static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct watchdog_info sbsa_gwdt_info = {
+static const struct watchdog_info sbsa_gwdt_info = {
 	.identity	= WATCHDOG_NAME,
 	.options	= WDIOF_SETTIMEOUT |
 			  WDIOF_KEEPALIVEPING |
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index ef2ecaf..98fd186 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -297,7 +297,7 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
  *	Kernel Interfaces
  */
 
-static struct watchdog_info wdt_info = {
+static const struct watchdog_info wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 	.identity = "W83627HF Watchdog",
 };
-- 
1.9.1

