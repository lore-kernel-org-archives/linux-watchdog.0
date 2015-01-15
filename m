Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39489 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbbAOPcG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Jan 2015 10:32:06 -0500
From: Athira Lekshmi <andnlnbn18@gmail.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Athira Lekshmi <andnlnbn18@gmail.com>
Subject: [PATCH v2 2/8] watchdog: sch311x_wdt: Fixed missing blank line warning
Date: Thu, 15 Jan 2015 21:02:00 +0530
Message-Id: <1421335926-3321-2-git-send-email-andnlnbn18@gmail.com>
In-Reply-To: <1421335926-3321-1-git-send-email-andnlnbn18@gmail.com>
References: <1421335926-3321-1-git-send-email-andnlnbn18@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add a new line after declarations to remove the checkpatch warning:
'Missing blank line after declarations'

Signed-off-by: Athira Lekshmi <andnlnbn18@gmail.com>
---
Changes in v2:
  -  Make the commit message more clearer.

 drivers/watchdog/sch311x_wdt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index b96127e..b550c83 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -233,6 +233,7 @@ static ssize_t sch311x_wdt_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
+
 				if (get_user(c, buf + i))
 					return -EFAULT;
 				if (c == 'V')
-- 
1.7.9.5

