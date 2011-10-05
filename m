Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54187 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934499Ab1JEQGD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Oct 2011 12:06:03 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so2790863wwf.1
        for <linux-watchdog@vger.kernel.org>; Wed, 05 Oct 2011 09:06:03 -0700 (PDT)
From: Dave Martin <dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org,
	=?UTF-8?q?Pawe=C5=82=20Moll?= <Pawel.Moll@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 15/16] watchdog: sp805: Enable module alias autogeneration for AMBA drivers
Date: Wed,  5 Oct 2011 17:05:06 +0100
Message-Id: <1317830707-17517-16-git-send-email-dave.martin@linaro.org>
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/watchdog/sp805_wdt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index cc2cfbe..c0a0ece 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -359,6 +359,8 @@ static struct amba_id sp805_wdt_ids[] __initdata = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, sp805_wdt_ids);
+
 static struct amba_driver sp805_wdt_driver = {
 	.drv = {
 		.name	= MODULE_NAME,
-- 
1.7.4.1

