Return-Path: <SRS0=3B2h=3F=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3DDC33CB6
	for <linux-watchdog@archiver.kernel.org>; Thu, 16 Jan 2020 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6A32077C
	for <linux-watchdog@archiver.kernel.org>; Thu, 16 Jan 2020 19:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202513;
	bh=zv0uIQnbRuBqCuzGClHLpmzrWhj9qCdptkqR74SgYfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LIirgJiq1/9abgDyzvh9xOQENH1DoZ07BRJQgP7lIriT7Q/MDe9Scsxo92lG3CFv5
	 mcZF8ax00/2UYAnGHkxewb9kKpaUU/ThKSL7pTQ12Jv/Say474NgLLYZNjBK6gpzxX
	 EridO+SY9ogvUFsbCrcO8FE0o4iSfJP29ZxCWi5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392760AbgAPTVw (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731066AbgAPQxh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72337214AF;
        Thu, 16 Jan 2020 16:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193617;
        bh=zv0uIQnbRuBqCuzGClHLpmzrWhj9qCdptkqR74SgYfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwSR9O2zM3e5dZKi4kPruSALAsifbTuvCBq/fjHzflyT4l/gL+6bIlbvM5A1vuSsH
         nS1HdQAx7UxRlvkvtOCSjJ2MoQ9X7lSh5MeHzXz4lW4JfH9XoMUSq3hCBN2I6xEnU3
         4geXSS6R9vV68Cs+5u0BM2NXzMWG2DsiPRKKgWC0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuiqing Li <shuiqing.li@unisoc.com>,
        Dongwei Wang <dongwei.wang@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 153/205] watchdog: sprd: Fix the incorrect pointer getting from driver data
Date:   Thu, 16 Jan 2020 11:42:08 -0500
Message-Id: <20200116164300.6705-153-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Shuiqing Li <shuiqing.li@unisoc.com>

[ Upstream commit 39e68d9e7ab276880980ee5386301fb218202192 ]

The device driver data saved the 'struct sprd_wdt' object, it is
incorrect to get 'struct watchdog_device' object from the driver
data, thus fix it.

Fixes: 477603467009 ("watchdog: Add Spreadtrum watchdog driver")
Reported-by: Dongwei Wang <dongwei.wang@unisoc.com>
Signed-off-by: Shuiqing Li <shuiqing.li@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/76d4687189ec940baa90cb8d679a8d4c8f02ee80.1573210405.git.baolin.wang@linaro.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/sprd_wdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index 0bb17b046140..65cb55f3916f 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -327,10 +327,9 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 
 static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
 {
-	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct sprd_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(wdd))
+	if (watchdog_active(&wdt->wdd))
 		sprd_wdt_stop(&wdt->wdd);
 	sprd_wdt_disable(wdt);
 
@@ -339,7 +338,6 @@ static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
 
 static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
 {
-	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct sprd_wdt *wdt = dev_get_drvdata(dev);
 	int ret;
 
@@ -347,7 +345,7 @@ static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (watchdog_active(wdd)) {
+	if (watchdog_active(&wdt->wdd)) {
 		ret = sprd_wdt_start(&wdt->wdd);
 		if (ret) {
 			sprd_wdt_disable(wdt);
-- 
2.20.1

