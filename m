Return-path: <Vladimir_Zapolskiy@mentor.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Robin Gong
	<b38343@freescale.com>, Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH v2 0/2] watchdog: add get/set peretimeout UAPI and internals
Date: Sun, 26 Jun 2016 04:01:03 +0300
Message-ID: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

The change from Wolfram based on Robin's work adds two new watchdog
ioctls WDIOC_GETPRETIMEOUT and WDIOC_SETPRETIMEOUT, both interfaces
are already described in Documentation/watchdog/watchdog-api.txt

Along with UAPI update a new internal interface for watchdog drivers
set_pretimeout() is introduced, it allows to update the state of a controller.

The handling of a pretimeout event is a task delegated to watchdog drivers.

My contribution to the change is negligible, apart of review and testing:
* added visibility of a pretimeout sysfs attribute based on
  set WDIOF_PRETIMEOUT watchdog option,

Wolfram's patch "watchdog: softdog: implement pretimeout support"
potentially can be added to the series with a minor modification:

-	static struct watchdog_device softdog_dev;
 	.....
-	watchdog_notify_pretimeout(&softdog_dev);
+	panic("watchdog pretimeout event");

but I'm hesitating to do it.

Changes from v1 to v2:
* removed my wrong generalization of wdd->pretimeout update
* added seconds unit of time to describe internal kernel API

The change adds all necessary bits to proceed with a watchdog pretimeout
framework devlopment.

Wolfram Sang (2):
  watchdog: add pretimeout support to the core
  fs: compat_ioctl: add pretimeout functions for watchdogs

 Documentation/watchdog/watchdog-kernel-api.txt | 20 +++++++++
 drivers/watchdog/watchdog_dev.c                | 56 +++++++++++++++++++++++++-
 fs/compat_ioctl.c                              |  2 +
 include/linux/watchdog.h                       | 11 +++++
 4 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.8.1
