Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38804 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab2ENJDp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 05:03:45 -0400
From: Devendra Naga <devendra.aaru@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Rob Landley <rob@landley.net>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH] Documentation/watchdog: Fix a small typo
Date: Mon, 14 May 2012 14:33:37 +0530
Message-Id: <1336986218-28301-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 227f6cd..25fe430 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -59,7 +59,7 @@ It contains following fields:
 * bootstatus: status of the device after booting (reported with watchdog
   WDIOF_* status bits).
 * driver_data: a pointer to the drivers private data of a watchdog device.
-  This data should only be accessed via the watchdog_set_drvadata and
+  This data should only be accessed via the watchdog_set_drvdata and
   watchdog_get_drvdata routines.
 * status: this field contains a number of status bits that give extra
   information about the status of the device (Like: is the watchdog timer
-- 
1.7.9.5

