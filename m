Return-Path: <SRS0=3B2h=3F=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEEDC33CB3
	for <linux-watchdog@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D0020728
	for <linux-watchdog@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194978;
	bh=912VyeyXGgAbeCx4tEz5pHFeizG+cjTvFyy0Pv9bch0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xiH18FvAHAStHMlQOSpBphTQ+DsRabT1RfatJ9MF4n7JMxnm8ArJ1PAJXFtll09Y0
	 y5doUoxuWgc+IZN07ty53F9ei5hFylt7prVjGs5fJEXquOJyJ93auGDxwTB4+qIZkP
	 CMyruDdLCYK2F+qJryXXcqjsv3kxBk1nou6JUjSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbgAPRQQ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:16:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:32954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390013AbgAPROQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 16 Jan 2020 12:14:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF96246A7;
        Thu, 16 Jan 2020 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194855;
        bh=912VyeyXGgAbeCx4tEz5pHFeizG+cjTvFyy0Pv9bch0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIABhtMCloQLHIe7fZJ1ZbsXR3tu0zEOBYdqlqmlXoas2kSVN+enblA8Nn8KvwZDO
         9/UVNA99lkOMrMN/YVu12iTFSDYPxs1PkNBVBW3Zm7jq+vT/LDpFM2oJrje+jaes5u
         SxM7fUaslQrZvXrZqDsAw7glbIvfm3t+kZ117l3Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuiqing Li <shuiqing.li@unisoc.com>,
        Dongwei Wang <dongwei.wang@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 651/671] watchdog: sprd: Fix the incorrect pointer getting from driver data
Date:   Thu, 16 Jan 2020 12:04:49 -0500
Message-Id: <20200116170509.12787-388-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
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
index ff9397d9638a..b6c65afd3677 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -342,10 +342,9 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 
 static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
 {
-	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct sprd_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(wdd))
+	if (watchdog_active(&wdt->wdd))
 		sprd_wdt_stop(&wdt->wdd);
 	sprd_wdt_disable(wdt);
 
@@ -354,7 +353,6 @@ static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
 
 static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
 {
-	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct sprd_wdt *wdt = dev_get_drvdata(dev);
 	int ret;
 
@@ -362,7 +360,7 @@ static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (watchdog_active(wdd)) {
+	if (watchdog_active(&wdt->wdd)) {
 		ret = sprd_wdt_start(&wdt->wdd);
 		if (ret) {
 			sprd_wdt_disable(wdt);
-- 
2.20.1

