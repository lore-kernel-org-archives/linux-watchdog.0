Return-path: <tomas.winkler@intel.com>
From: Tomas Winkler <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [watchdog] watchdog: mei_wdt: request stop on reboot to prevent false positive event
Date: Tue,  8 Nov 2016 17:55:52 +0200
Message-Id: <1478620552-30409-1-git-send-email-tomas.winkler@intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Alexander Usyskin <alexander.usyskin@intel.com>

Systemd on reboot enables shutdown watchdog that leaves the watchdog
device open to ensure that even if power down process get stuck the
platform reboots nonetheless.
The iamt_wdt is an alarm-only watchdog and can't reboot system, but the
FW will generate an alarm event reboot was completed in time, as the
watchdog is not automatically disabled during power cycle.
So we should request stop watchdog on reboot to eliminate wrong alarm
from the FW.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/watchdog/mei_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index e0af52265511..40953fe4db86 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -389,6 +389,8 @@ static int mei_wdt_register(struct mei_wdt *wdt)
 	wdt->wdd.max_timeout = MEI_WDT_MAX_TIMEOUT;
 
 	watchdog_set_drvdata(&wdt->wdd, wdt);
+	watchdog_stop_on_reboot(&wdt->wdd);
+
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret) {
 		dev_err(dev, "unable to register watchdog device = %d.\n", ret);
-- 
2.7.4
