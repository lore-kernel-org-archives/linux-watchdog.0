Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44695 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbdGKPXh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 11 Jul 2017 11:23:37 -0400
From: Colin King <colin.king@canonical.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: w83627hf: make const array chip_name static
Date: Tue, 11 Jul 2017 16:23:34 +0100
Message-Id: <20170711152334.18385-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate array chip_name on the stack but instead make it static.
Makes the object code smaller by 40 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   5641	   2840	    384	   8865	   22a1	drivers/watchdog/w83627hf_wdt.o

After:
   text	   data	    bss	    dec	    hex	filename
   5545	   2896	    384	   8825	   2279	drivers/watchdog/w83627hf_wdt.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/watchdog/w83627hf_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index d9ba0496713c..7817836bff55 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -429,7 +429,7 @@ static int __init wdt_init(void)
 {
 	int ret;
 	int chip;
-	const char * const chip_name[] = {
+	static const char * const chip_name[] = {
 		"W83627HF",
 		"W83627S",
 		"W83697HF",
-- 
2.11.0

