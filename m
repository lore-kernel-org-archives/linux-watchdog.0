Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40514 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeLQTdV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Dec 2018 14:33:21 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] watchdog: add documentation for PM usage
Date: Mon, 17 Dec 2018 20:33:14 +0100
Message-Id: <20181217193314.3487-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add the first rule we recently agreed on.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/watchdog/watchdog-pm.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/watchdog/watchdog-pm.txt

diff --git a/Documentation/watchdog/watchdog-pm.txt b/Documentation/watchdog/watchdog-pm.txt
new file mode 100644
index 000000000000..7a4dd46e0d24
--- /dev/null
+++ b/Documentation/watchdog/watchdog-pm.txt
@@ -0,0 +1,19 @@
+The Linux WatchDog Timer Power Management Guide
+===============================================
+Last reviewed: 17-Dec-2018
+
+Wolfram Sang <wsa+renesas@sang-engineering.com>
+
+Introduction
+------------
+This document states rules about watchdog devices and their power management
+handling to ensure a uniform behaviour for Linux systems.
+
+
+Ping on resume
+--------------
+On resume, a watchdog timer shall be reset to its selected value to give
+userspace enough time to resume. [1] [2]
+
+[1] https://patchwork.kernel.org/patch/10252209/
+[2] https://patchwork.kernel.org/patch/10711625/
-- 
2.19.1
