Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46093 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeLIKtl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Dec 2018 05:49:41 -0500
From: Hardik Singh Rathore <hardiksingh.k@gmail.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>
Subject: [PATCH] Watchdog: remove outdated comment
Date: Sun,  9 Dec 2018 16:17:26 +0530
Message-Id: <20181209104726.15610-1-hardiksingh.k@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The lock field doesn't exist in watchdog_device structure.
It was added by commit f4e9c82f64b5 ("watchdog: Add Locking support")
and removed by commit b4ffb1909843
("watchdog: Separate and maintain variables based on variable lifetime")

Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
---
 include/linux/watchdog.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 44985c4a1e86..417d9f37077a 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -90,9 +90,6 @@ struct watchdog_ops {
  *
  * The driver-data field may not be accessed directly. It must be accessed
  * via the watchdog_set_drvdata and watchdog_get_drvdata helpers.
- *
- * The lock field is for watchdog core internal use only and should not be
- * touched.
  */
 struct watchdog_device {
 	int id;
-- 
2.17.1
