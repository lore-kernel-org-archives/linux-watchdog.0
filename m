Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A074DC433DB
	for <linux-watchdog@archiver.kernel.org>; Thu, 14 Jan 2021 08:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568D02395A
	for <linux-watchdog@archiver.kernel.org>; Thu, 14 Jan 2021 08:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbhANISq (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:18:46 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40862 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbhANISq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 14 Jan 2021 03:18:46 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 23FD81A11DA;
        Thu, 14 Jan 2021 09:18:00 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C9A3F1A0841;
        Thu, 14 Jan 2021 09:17:57 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 729344029B;
        Thu, 14 Jan 2021 09:17:54 +0100 (CET)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH] watchdog: stop wdd when watchdog hw running in reboot_notifier
Date:   Thu, 14 Jan 2021 16:26:51 +0800
Message-Id: <20210114082651.17162-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

In watchdog_reboot_notifier, wdd should be stopped when the device
is in hw_running state

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 861daf4..ec670cc 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -154,7 +154,7 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
 
 	wdd = container_of(nb, struct watchdog_device, reboot_nb);
 	if (code == SYS_DOWN || code == SYS_HALT) {
-		if (watchdog_active(wdd)) {
+		if (watchdog_active(wdd) || watchdog_hw_running(wdd)) {
 			int ret;
 
 			ret = wdd->ops->stop(wdd);
-- 
2.7.4

