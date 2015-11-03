Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33743 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbbKCIA0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 03:00:26 -0500
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Wim Van Sebroeck <wim@iguana.be>,
	linux-sh@vger.kernel.org
Subject: [PATCH 1/2] watchdog: include: fix some typos
Date: Tue,  3 Nov 2015 09:00:15 +0100
Message-Id: <1446537616-3452-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/watchdog.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index d74a0e907b9e76..fbd752de3a24d5 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -25,7 +25,7 @@ struct watchdog_device;
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value.
- * @get_timeleft:The routine that get's the time that's left before a reset.
+ * @get_timeleft:The routine that gets the time left before a reset.
  * @ref:	The ref operation for dyn. allocated watchdog_device structs
  * @unref:	The unref operation for dyn. allocated watchdog_device structs
  * @ioctl:	The routines that handles extra ioctl calls.
@@ -33,7 +33,7 @@ struct watchdog_device;
  * The watchdog_ops structure contains a list of low-level operations
  * that control a watchdog device. It also contains the module that owns
  * these operations. The start and stop function are mandatory, all other
- * functions are optonal.
+ * functions are optional.
  */
 struct watchdog_ops {
 	struct module *owner;
-- 
2.6.1

