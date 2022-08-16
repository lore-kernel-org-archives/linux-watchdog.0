Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94720C25B0E
	for <linux-watchdog@archiver.kernel.org>; Tue, 16 Aug 2022 12:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiHPMpl (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiHPMom (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:42 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9C22ED67;
        Tue, 16 Aug 2022 05:43:58 -0700 (PDT)
X-QQ-mid: bizesmtp83t1660653833tkn0wenr
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:43:51 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: C2zsvWT0ctUUwBTBZPqlbH2YxAWGYKRGbcRcTe7+wjtMFZSHyaU4yD0a4qFSw
        flWEoH6V6knmm0lpzVmWKqOe/dJmBMb6h7NY0ZtK19vaveYPgCfPeiZ7EX/1X8pKV9A/L1C
        jwOyOehVyyR174jm2v5DI6r2rC0YoHzh4WlALHCFGFXuFdKj1Y72OyhguIHKFTg929Uiqa1
        hsoEOfR3wGCEwCFrZjojZvCvp2b+vgDalXrGmFgS/ZtMkZLdog/nKFRu6+V1r04QJfBJI2F
        Rk+Ac7rmGMcuZ3FDXzssET5pLnBYOlIp/M7fS/2cvGu6LNLio7JE3ec+3Nu8ffZAFmHkbWl
        Np7Q4jQqJo5S3j6XMWxYa0wYrtl417o22EtLNHBEyrjHJvcrzrzBL3QE446y4xU5+2GyuQm
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/watchdog: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:43:44 +0800
Message-Id: <20220816124344.16004-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

 Delete the redundant word 'we'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/watchdog/pc87413_wdt.c | 2 +-
 drivers/watchdog/w83977f_wdt.c | 2 +-
 drivers/watchdog/wdt977.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 9f9a340427fc..14f37b3b903f 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -333,7 +333,7 @@ static int pc87413_status(void)
  *	@ppos: pointer to the position to write. No seeks allowed
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
- *	write of data will do, as we we don't define content meaning.
+ *	write of data will do, as we don't define content meaning.
  */
 
 static ssize_t pc87413_write(struct file *file, const char __user *data,
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
diff --git a/drivers/watchdog/wdt977.c b/drivers/watchdog/wdt977.c
index c9b8e863f70f..cd623c6da1fa 100644
--- a/drivers/watchdog/wdt977.c
+++ b/drivers/watchdog/wdt977.c
@@ -298,7 +298,7 @@ static int wdt977_release(struct inode *inode, struct file *file)
  *      @ppos: pointer to the position to write. No seeks allowed
  *
  *      A write to a watchdog device is defined as a keepalive signal. Any
- *      write of data will do, as we we don't define content meaning.
+ *      write of data will do, as we don't define content meaning.
  */
 
 static ssize_t wdt977_write(struct file *file, const char __user *buf,
-- 
2.36.1

