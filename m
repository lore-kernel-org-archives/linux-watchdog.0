Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Wenyou Yang <wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, fabio.porcedda@gmail.com,
        JM.Lin@atmel.com, wenyou.yang@atmel.com, wim@iguana.be,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] watchdog: add the function watchdog_is_open
Date: Fri,  1 Feb 2013 15:06:19 +0800
Message-Id: <1359702386-21284-2-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Add the function watchdog_is_open to check whether or not
the /dev/watchdog? is opened

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/watchdog.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index e40cc2b..7ea4465 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -111,6 +111,14 @@ static inline bool watchdog_active(struct watchdog_device *wdd)
 	return test_bit(WDOG_ACTIVE, &wdd->status);
 }
 
+/* Use the following function to check whether or not
+ * the /dev/watchdog? is opened
+ */
+static inline bool watchdog_is_open(struct watchdog_device *wddev)
+{
+	return test_bit(WDOG_DEV_OPEN, &wddev->status);
+}
+
 /* Use the following function to set the nowayout feature */
 static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
 {
-- 
1.7.9.5
