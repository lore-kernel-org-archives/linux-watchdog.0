Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40418 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733264AbeLQTOU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Dec 2018 14:14:20 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] watchdog: docs: kernel-api: don't reference removed functions
Date: Mon, 17 Dec 2018 20:14:11 +0100
Message-Id: <20181217191411.3254-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Those functions are not only deprecated, but gone for good.

Fixes: 62cd1c40ce1c ("watchdog: kill unref/ref ops")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 9b93953f69cf..3a91ef5af044 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -128,8 +128,6 @@ struct watchdog_ops {
 	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *);
-	void (*ref)(struct watchdog_device *) __deprecated;
-	void (*unref)(struct watchdog_device *) __deprecated;
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
@@ -218,8 +216,6 @@ they are supported. These optional routines/operations are:
   if a command is not supported. The parameters that are passed to the ioctl
   call are: watchdog_device, cmd and arg.
 
-The 'ref' and 'unref' operations are no longer used and deprecated.
-
 The status bits should (preferably) be set with the set_bit and clear_bit alike
 bit-operations. The status bits that are defined are:
 * WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
-- 
2.19.1
