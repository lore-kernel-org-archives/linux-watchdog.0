Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9120EECAAD3
	for <linux-watchdog@archiver.kernel.org>; Wed, 31 Aug 2022 16:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiHaQEJ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiHaQDo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Aug 2022 12:03:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3598D8E12
        for <linux-watchdog@vger.kernel.org>; Wed, 31 Aug 2022 09:03:40 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661961815tvynxjub
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 00:03:30 +0800 (CST)
X-QQ-SSF: 01000000000000B0C000000A0000000
X-QQ-FEAT: An8j/rhzjdFxuOWO3HxIiU2s838Ojo+XHQhkynQPsBcgmA/FTKEF4ys/fP8Td
        MeiigkrzNLMF3RaF2uTYQ7Ew3dceNOvEiayKdmiDsxyccWvJb2KJTlkKFnton6lrFjzjYEo
        iH2hSLgomUAFkhhOK0wf35+HQ7pqpdrBlv+gYnxcg5wEWjU+G5ZZi90ezZ6qUHejzTvTj7L
        MPqLjdK+DRZqfHl8Zhdh/YYQHybc2rm0xsWR2pIE7cZsemxg1fFT+Xz5JFiRwPNbB5CLkHg
        GNd9jzJY12R7KkKx11XHs90XQtoqK8mjzmzksIHPCKSjHISaDM6vBHqy7TJnj/zzAA2kFXA
        kNVK//7Ypg4XtBy7pw=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] watchdog: Fix comments typo
Date:   Wed, 31 Aug 2022 12:03:29 -0400
Message-Id: <20220831160329.6066-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Delete the repeated word "we" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/watchdog/w83977f_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index fd64ae77780a..31bf21ceaf48 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -321,7 +321,7 @@ static int wdt_release(struct inode *inode, struct file *file)
  *      @ppos: pointer to the position to write. No seeks allowed
  *
  *      A write to a watchdog device is defined as a keepalive signal. Any
- *      write of data will do, as we we don't define content meaning.
+ *      write of data will do, as we don't define content meaning.
  */
 
 static ssize_t wdt_write(struct file *file, const char __user *buf,
-- 
2.35.1

