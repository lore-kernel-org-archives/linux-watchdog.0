Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42071 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbaA0HEm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 02:04:42 -0500
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s0R74ffq005706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-watchdog@vger.kernel.org>; Mon, 27 Jan 2014 07:04:42 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s0R74eU0006623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-watchdog@vger.kernel.org>; Mon, 27 Jan 2014 07:04:41 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s0R74e7r016744
	for <linux-watchdog@vger.kernel.org>; Mon, 27 Jan 2014 07:04:40 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
To: linux-watchdog@vger.kernel.org
Cc: vasily.isaenko@oracle.com
Subject: [PATCH] watchdog: w83697hf_wdt: return ENODEV if no device was found
Date: Mon, 27 Jan 2014 11:04:33 +0400
Message-Id: <1390806273-8848-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Most WDT driver modules return ENODEV during modprobe if
no valid device was found, but w83697hf_wdt returns EIO.

Let w83697hf_wdt return ENODEV.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 drivers/watchdog/w83697hf_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/w83697hf_wdt.c b/drivers/watchdog/w83697hf_wdt.c
index aaf2995..68b45fc 100644
--- a/drivers/watchdog/w83697hf_wdt.c
+++ b/drivers/watchdog/w83697hf_wdt.c
@@ -402,7 +402,7 @@ static int __init wdt_init(void)
 
 	if (!found) {
 		pr_err("No W83697HF/HG could be found\n");
-		ret = -EIO;
+		ret = -ENODEV;
 		goto out;
 	}
 
-- 
1.7.1

