Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:39253 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbcFGRjC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 13:39:02 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: Wolfram Sang <wsa@the-dreams.de>,
	Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/6] watchdog: add set_pretimeout interface
Date: Tue, 7 Jun 2016 20:38:42 +0300
Message-ID: <1465321127-19522-2-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Robin Gong <b38343@freescale.com>

Add set_pretimeout since our watchdog driver has those interfaces and
obviously, the new common watchdog framework didn't implement this
interface.

Signed-off-by: Robin Gong <b38343@freescale.com>
[vzapolskiy: rebased, added an inline comment to describe new interface]
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v2 to v3:
* none, new change

Changes from v1 to v2:
* none, new change

 include/linux/watchdog.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 51732d6..e3d23d3 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -28,6 +28,7 @@ struct watchdog_core_data;
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
+ * @set_pretimeout:The routine for setting the watchdog devices pretimeout (in seconds).
  * @get_timeleft:The routine that gets the time left before a reset (in seconds).
  * @restart:	The routine for restarting the machine.
  * @ioctl:	The routines that handles extra ioctl calls.
@@ -46,6 +47,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *, unsigned long, void *);
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
@@ -95,6 +97,7 @@ struct watchdog_device {
 	const struct watchdog_ops *ops;
 	unsigned int bootstatus;
 	unsigned int timeout;
+	unsigned int pretimeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
 	unsigned int min_hw_heartbeat_ms;
@@ -162,6 +165,13 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 		 t > wdd->max_timeout);
 }
 
+/* Use the following function to check if a pretimeout value is invalid */
+static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
+					       unsigned int t)
+{
+	return wdd->timeout && t >= wdd->timeout;
+}
+
 /* Use the following functions to manipulate watchdog driver specific data */
 static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
 {
-- 
2.5.0

