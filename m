Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757844Ab2EKKAg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 06:00:36 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/9] watchdog-kernel-api.txt: Document new watchdog_dev fields
Date: Fri, 11 May 2012 12:00:21 +0200
Message-Id: <1336730427-1664-4-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
References: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 227f6cd..03aa948 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -1,6 +1,6 @@
 The Linux WatchDog Timer Driver Core kernel API.
 ===============================================
-Last reviewed: 16-Mar-2012
+Last reviewed: 11-May-2012
 
 Wim Van Sebroeck <wim@iguana.be>
 
@@ -46,6 +46,10 @@ struct watchdog_device {
 	unsigned int min_timeout;
 	unsigned int max_timeout;
 	void *driver_data;
+	int id;
+	struct cdev cdev;
+	struct device *dev;
+	struct device *busdev;
 	unsigned long status;
 };
 
@@ -61,6 +65,11 @@ It contains following fields:
 * driver_data: a pointer to the drivers private data of a watchdog device.
   This data should only be accessed via the watchdog_set_drvadata and
   watchdog_get_drvdata routines.
+* id: set by watchdog_register_device, id 0 is special it has both a dynamic
+  major, minor 0 /dev/watchdog0 cdev as well as the old miscdev /dev/watchdog
+* cdev: cdev for the dynamic major /dev/watchdog<id> device nodes
+* dev: device under the watchdog class
+* busdev: set this to the parent device (or NULL) before calling register
 * status: this field contains a number of status bits that give extra
   information about the status of the device (Like: is the watchdog timer
   running/active, is the nowayout bit set, is the device opened via
-- 
1.7.10

