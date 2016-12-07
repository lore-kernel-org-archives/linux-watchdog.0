Return-path: <slemieux.tyco@gmail.com>
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: gpio: Add "keep-armed-on-close" feature
Date: Wed,  7 Dec 2016 14:46:20 -0500
Message-Id: <1481139980-13429-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

There is a need to allow a grace period after the watchdog software
client has closed. It could be used for syncing the filesystem or
allow graceful termination while still providing a hardware reset
in case the system has hung.

The "always-running" configuration from device-tree does not provide
this since it will automatically keep the hardware watchdog alive as
soon as the software client closes (i.e. keep toggling the GPIO line
regardless of the state of the soft part of the watchdog).

The "keep-armed-on-close" member in the GPIO watchdog implementation
indicates if an expired timeout should cause a reset.

This patch add a new "keep-armed-on-close" device-tree configuration
that will keep the watchdog "armed" until the next timeout period after
a close. During this period, the hardware watchdog is kept alive.

A software watchdog client that wants to provide a grace period,
before a hard reset, can set the timeout before properly closing.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt | 3 +++
 drivers/watchdog/gpio_wdt.c                             | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
index 83d2814..2669735 100644
--- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
@@ -17,6 +17,9 @@ Optional Properties:
 - always-running: If the watchdog timer cannot be disabled, add this flag to
   have the driver keep toggling the signal without a client. It will only cease
   to toggle the signal when the device is open and the timeout elapsed.
+- keep-armed-on-close: if the watchdog timer need to keep toggling the signal
+  when close, until the timeout elapsed, add this flag to have the driver
+  keep toggling the signal, until the timeout elapsed.
 - timeout-sec: Contains the watchdog timeout in seconds.
 - start-at-init: Start kicking watchdog as soon as driver is loaded.
 
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index ef9ab91..ba9091a 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -32,6 +32,7 @@ struct gpio_wdt_priv {
 	bool			active_low;
 	bool			state;
 	bool			always_running;
+	bool			keep_armed_on_close;
 	bool			armed;
 	unsigned int		hw_algo;
 	unsigned int		hw_margin;
@@ -72,6 +73,9 @@ static int gpio_wdt_stop(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
+	if(priv->keep_armed_on_close)
+		return 0;
+
 	priv->armed = false;
 	if (!priv->always_running) {
 		mod_timer(&priv->timer, 0);
@@ -210,6 +214,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 
 	priv->always_running = of_property_read_bool(pdev->dev.of_node,
 						     "always-running");
+	priv->keep_armed_on_close = of_property_read_bool(pdev->dev.of_node,
+						 "keep-armed-on-close");
 
 	watchdog_set_drvdata(&priv->wdd, priv);
 
-- 
1.8.3.1
