Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51388 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab3BNIOy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Feb 2013 03:14:54 -0500
Received: by mail-ee0-f46.google.com with SMTP id e49so1006753eek.33
        for <linux-watchdog@vger.kernel.org>; Thu, 14 Feb 2013 00:14:53 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v9 8/8] watchdog: code: fix the alignement of some function declarations
Date: Thu, 14 Feb 2013 09:14:30 +0100
Message-Id: <1360829670-10418-9-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/watchdog_core.c |  2 +-
 drivers/watchdog/watchdog_dev.c  | 17 ++++++-----------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 05d18b4..5cdd7b6 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -70,7 +70,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
  * A zero is returned on success and -EINVAL for failure.
  */
 int watchdog_init_timeout(struct watchdog_device *wdd,
-				unsigned int timeout_parm, struct device *dev)
+			  unsigned int timeout_parm, struct device *dev)
 {
 	unsigned int t = 0;
 	int ret = 0;
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 08b48bb..776341b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -162,8 +162,7 @@ out_stop:
  *	Get the watchdog's status flags.
  */
 
-static int watchdog_get_status(struct watchdog_device *wddev,
-							unsigned int *status)
+static int watchdog_get_status(struct watchdog_device *wddev, uint *status)
 {
 	int err = 0;
 
@@ -191,8 +190,7 @@ out_status:
  *	@timeout: timeout to set in seconds
  */
 
-static int watchdog_set_timeout(struct watchdog_device *wddev,
-							unsigned int timeout)
+static int watchdog_set_timeout(struct watchdog_device *wddev, uint timeout)
 {
 	int err;
 
@@ -225,8 +223,7 @@ out_timeout:
  *	Get the time before a watchdog will reboot (if not pinged).
  */
 
-static int watchdog_get_timeleft(struct watchdog_device *wddev,
-							unsigned int *timeleft)
+static int watchdog_get_timeleft(struct watchdog_device *wddev, uint *timeleft)
 {
 	int err = 0;
 
@@ -255,8 +252,7 @@ out_timeleft:
  *	@arg: argument pointer
  */
 
-static int watchdog_ioctl_op(struct watchdog_device *wddev, unsigned int cmd,
-							unsigned long arg)
+static int watchdog_ioctl_op(struct watchdog_device *wddev, uint cmd, ulong arg)
 {
 	int err;
 
@@ -290,7 +286,7 @@ out_ioctl:
  */
 
 static ssize_t watchdog_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
+			      size_t len, loff_t *ppos)
 {
 	struct watchdog_device *wdd = file->private_data;
 	size_t i;
@@ -329,8 +325,7 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
  *	according to their available features.
  */
 
-static long watchdog_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
+static long watchdog_ioctl(struct file *file, unsigned int cmd, ulong arg)
 {
 	struct watchdog_device *wdd = file->private_data;
 	void __user *argp = (void __user *)arg;
-- 
1.8.1.1

