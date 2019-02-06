Return-Path: <SRS0=QDKL=QN=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81089C169C4
	for <linux-watchdog@archiver.kernel.org>; Wed,  6 Feb 2019 16:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1112186A
	for <linux-watchdog@archiver.kernel.org>; Wed,  6 Feb 2019 16:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfBFQmB (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:42:01 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46863 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730520AbfBFQmB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 6 Feb 2019 11:42:01 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from michaelsh@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Feb 2019 18:41:55 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x16GfnJd014415;
        Wed, 6 Feb 2019 18:41:54 +0200
From:   michaelsh@mellanox.com
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, vadimp@mellanox.com,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 3/3] Documentation/watchdog: Add documentation mlx-wdt driver
Date:   Wed,  6 Feb 2019 16:41:45 +0000
Message-Id: <20190206164145.4076-4-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190206164145.4076-1-michaelsh@mellanox.com>
References: <20190206164145.4076-1-michaelsh@mellanox.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

Add documentation with details of mellanox watchdog driver.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>
---
 Documentation/watchdog/mlx-wdt.txt | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/watchdog/mlx-wdt.txt

diff --git a/Documentation/watchdog/mlx-wdt.txt b/Documentation/watchdog/mlx-wdt.txt
new file mode 100644
index 000000000000..13123acc4195
--- /dev/null
+++ b/Documentation/watchdog/mlx-wdt.txt
@@ -0,0 +1,48 @@
+		Mellanox watchdog drivers
+		for x86 based system switches
+
+This driver provides watchdog functionality for various Mellanox
+Ethernet and Infiniband switch systems.
+
+Mellanox watchdog device is implemented in a programmable logic device.
+
+There are 2 types of HW watchdog implementations.
+
+Type 1:
+Actual HW timeout can be defined as a power of 2 msec.
+e.g. timeout 20 sec will be rounded up to 32768 msec.
+The maximum timeout period is 32 sec (32768 msec.),
+Get time-left isn't supported
+
+Type 2:
+Actual HW timeout is defined in sec. and it's the same as 
+a user-defined timeout.
+Maximum timeout is 255 sec.
+Get time-left is supported.
+
+Type 1 HW watchdog implementation exist in old systems and 
+all new systems have type 2 HW watchdog.
+Two types of HW implementation have also different register map.
+
+Mellanox system can have 2 watchdogs: main and auxiliary.
+Main and auxiliary watchdog devices can be enabled together 
+on the same system.
+There are several actions that can be defined in the watchdog:
+system reset, start fans on full speed and increase register counter.
+The last 2 actions are performed without a system reset.
+Actions without reset are provided for auxiliary watchdog device,
+which is optional.
+
+This mlx-wdt driver supports both HW watchdog implementations.
+
+Watchdog driver is probed from the common mlx_platform driver.
+Mlx_platform driver provides an appropriate set of registers for
+Mellanox watchdog device, identity name (mlx-wdt-main or mlx-wdt-aux),
+initial timeout, performed action in expiration and configuration flags.
+watchdog configuration flags: nostop_after_start i.e. nowayout and
+start_at_boot.
+The driver reports if watchdog set timeout is rounded in type1 HW watchdog.
+The driver checks during initialization if the previous system reset 
+was done by the watchdog. If yes, it makes a notification about this event.
+
+Access to HW registers is performed through a generic regmap interface.
-- 
2.11.0

