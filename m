Return-path: <tomas.winkler@intel.com>
From: Tomas Winkler <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [watchdog-next] watchdog: kill unref/ref ops
Date: Sun,  3 Jan 2016 13:32:37 +0200
Message-Id: <1451820757-8840-1-git-send-email-tomas.winkler@intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

ref/unref ops are not called at all so even marked them as deprecated
is misleading, we need to just drop the API.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 include/linux/watchdog.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 850af04fe0c7..aaabd4703b46 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -47,8 +47,6 @@ struct watchdog_ops {
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *);
-	void (*ref)(struct watchdog_device *) __deprecated;
-	void (*unref)(struct watchdog_device *) __deprecated;
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
-- 
2.4.3
