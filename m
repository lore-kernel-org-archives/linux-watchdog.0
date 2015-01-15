Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47697 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbbAOPdr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Jan 2015 10:33:47 -0500
From: Athira Lekshmi <andnlnbn18@gmail.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Athira Lekshmi <andnlnbn18@gmail.com>
Subject: [PATCH v2 8/8] watchdog: eurotechwdt: Fixed missing blank line warning
Date: Thu, 15 Jan 2015 21:02:06 +0530
Message-Id: <1421335926-3321-8-git-send-email-andnlnbn18@gmail.com>
In-Reply-To: <1421335926-3321-1-git-send-email-andnlnbn18@gmail.com>
References: <1421335926-3321-1-git-send-email-andnlnbn18@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add a blank line after declarations to remove the checkpatch warning:
'Missing blank line after declarations'

Signed-off-by: Athira Lekshmi <andnlnbn18@gmail.com>
---
Changes in v2:
  - Make the commit message more clearer.

 drivers/watchdog/eurotechwdt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index 23ee532..86b19ee 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -210,6 +210,7 @@ size_t count, loff_t *ppos)
 
 			for (i = 0; i != count; i++) {
 				char c;
+
 				if (get_user(c, buf + i))
 					return -EFAULT;
 				if (c == 'V')
-- 
1.7.9.5

