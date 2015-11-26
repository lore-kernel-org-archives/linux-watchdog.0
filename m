Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:45743 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbbKZUfS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 15:35:18 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v3 2/2] watchdog: core: factorize register error paths
Date: Thu, 26 Nov 2015 15:35:07 -0500
Message-Id: <1448570107-3106-2-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1448570107-3106-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448570107-3106-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The commit adding the reboot notifier in the core introduced a new error
path in __watchdog_register_device, making error paths quite redundant.

This commit factorizes all error paths that do some cleanup.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 drivers/watchdog/watchdog_core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 13a7a58..c246f97 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -272,8 +272,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 
 		ret = __watchdog_create_register(wdd);
 		if (ret) {
-			ida_simple_remove(&watchdog_ida, id);
-			return ret;
+			goto remove_ida;
 		}
 	}
 
@@ -284,9 +283,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		if (ret) {
 			dev_err(wdd->dev, "Cannot register reboot notifier (%d)\n",
 				ret);
-			__watchdog_unregister_destroy(wdd);
-			ida_simple_remove(&watchdog_ida, wdd->id);
-			return ret;
+			goto unregister_destroy_device;
 		}
 	}
 
@@ -300,6 +297,13 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 	}
 
 	return 0;
+
+unregister_destroy_device:
+	__watchdog_unregister_destroy(wdd);
+remove_ida:
+	ida_simple_remove(&watchdog_ida, wdd->id);
+
+	return ret;
 }
 
 /**
-- 
2.5.0

