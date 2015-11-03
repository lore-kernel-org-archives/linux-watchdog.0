Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33745 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbbKCIA2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 03:00:28 -0500
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Wim Van Sebroeck <wim@iguana.be>,
	linux-sh@vger.kernel.org
Subject: [PATCH 2/2] watchdog: include: add units for timeout values in kerneldoc
Date: Tue,  3 Nov 2015 09:00:16 +0100
Message-Id: <1446537616-3452-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446537616-3452-1-git-send-email-wsa@the-dreams.de>
References: <1446537616-3452-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/watchdog.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index fbd752de3a24d5..4e99a267878d21 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -24,8 +24,8 @@ struct watchdog_device;
  * @stop:	The routine for stopping the watchdog device.
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
- * @set_timeout:The routine for setting the watchdog devices timeout value.
- * @get_timeleft:The routine that gets the time left before a reset.
+ * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
+ * @get_timeleft:The routine that gets the time left before a reset (in seconds).
  * @ref:	The ref operation for dyn. allocated watchdog_device structs
  * @unref:	The unref operation for dyn. allocated watchdog_device structs
  * @ioctl:	The routines that handles extra ioctl calls.
@@ -59,9 +59,9 @@ struct watchdog_ops {
  * @info:	Pointer to a watchdog_info structure.
  * @ops:	Pointer to the list of watchdog operations.
  * @bootstatus:	Status of the watchdog device at boot.
- * @timeout:	The watchdog devices timeout value.
- * @min_timeout:The watchdog devices minimum timeout value.
- * @max_timeout:The watchdog devices maximum timeout value.
+ * @timeout:	The watchdog devices timeout value (in seconds).
+ * @min_timeout:The watchdog devices minimum timeout value (in seconds).
+ * @max_timeout:The watchdog devices maximum timeout value (in seconds).
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
-- 
2.6.1

