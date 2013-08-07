Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:58862 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307Ab3HGLFh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Aug 2013 07:05:37 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so1270325pde.10
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Aug 2013 04:05:37 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, sachin.kamat@linaro.org
Subject: [PATCH 1/1] watchdog: ibmasr: Fix incorrect placement of __initdata
Date: Wed,  7 Aug 2013 16:18:51 +0530
Message-Id: <1375872531-24992-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/ibmasr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index bc3fb8f..e7e7720 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -360,7 +360,7 @@ struct ibmasr_id {
 	int type;
 };
 
-static struct ibmasr_id __initdata ibmasr_id_table[] = {
+static struct ibmasr_id ibmasr_id_table[] __initdata = {
 	{ "IBM Automatic Server Restart - eserver xSeries 220", ASMTYPE_TOPAZ },
 	{ "IBM Automatic Server Restart - Machine Type 8673", ASMTYPE_PEARL },
 	{ "IBM Automatic Server Restart - Machine Type 8480", ASMTYPE_JASPER },
-- 
1.7.9.5

