Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:39252 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbcFGRi6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 13:38:58 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: Wolfram Sang <wsa@the-dreams.de>,
	Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/6] watchdog: add WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT
Date: Tue, 7 Jun 2016 20:38:43 +0300
Message-ID: <1465321127-19522-3-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Robin Gong <b38343@freescale.com>

Since the watchdog common framework centrialize the IOCTL interfaces
of device driver now, the SETPRETIMEOUT and GETPRETIMEOUT need to be
added in common code.

Signed-off-by: Robin Gong <b38343@freescale.com>
[vzapolskiy: rebased, cleanups]
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v2 to v3:
* none, new change

Changes from v1 to v2:
* none, new change

 drivers/watchdog/watchdog_dev.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 3595cff..42ab86d 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -318,6 +318,27 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 }
 
 /*
+ *	watchdog_set_pretimeout: set the watchdog timer pretimeout
+ *	@wdd: the watchdog device to set the timeout for
+ *	@timeout: pretimeout to set in seconds
+ *
+ *	The caller must hold wd_data->lock.
+ */
+
+static int watchdog_set_pretimeout(struct watchdog_device *wdd,
+				   unsigned int pretimeout)
+{
+	if (!wdd->ops->set_pretimeout ||
+	    !(wdd->info->options & WDIOF_PRETIMEOUT))
+		return -EOPNOTSUPP;
+
+	if (watchdog_pretimeout_invalid(wdd, pretimeout))
+		return -EINVAL;
+
+	return wdd->ops->set_pretimeout(wdd, pretimeout);
+}
+
+/*
  *	watchdog_get_timeleft: wrapper to get the time left before a reboot
  *	@wdd: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
@@ -620,6 +641,16 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 			break;
 		err = put_user(val, p);
 		break;
+	case WDIOC_SETPRETIMEOUT:
+		if (get_user(val, p)) {
+			err = -EFAULT;
+			break;
+		}
+		err = watchdog_set_pretimeout(wdd, val);
+		break;
+	case WDIOC_GETPRETIMEOUT:
+		err = put_user(wdd->pretimeout, p);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
-- 
2.5.0

