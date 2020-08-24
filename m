Return-Path: <SRS0=918n=CC=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9496C433E1
	for <linux-watchdog@archiver.kernel.org>; Mon, 24 Aug 2020 08:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1082075B
	for <linux-watchdog@archiver.kernel.org>; Mon, 24 Aug 2020 08:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHXIZj (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:25:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40238 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHXIZe (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Aug 2020 04:25:34 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2350A1A1169;
        Mon, 24 Aug 2020 10:25:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C678D1A0331;
        Mon, 24 Aug 2020 10:25:30 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D9EE4031B;
        Mon, 24 Aug 2020 10:25:27 +0200 (CEST)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH] watchdog: sbsa_gwdt: add shutdown hook to driver
Date:   Mon, 24 Aug 2020 16:18:04 +0800
Message-Id: <20200824081804.23206-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

Kexec maybe need more time than timeout of wdt(sbsa)
which will reset the system.
So it is necessary to add shutdown hook to disable the
wdt when run kexec.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/watchdog/sbsa_gwdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index f0f1e3b..bbcd04d 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -313,6 +313,14 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void sbsa_gwdt_shutdown(struct platform_device *pdev)
+{
+	struct sbsa_gwdt *gwdt;
+
+	gwdt = platform_get_drvdata(pdev);
+	sbsa_gwdt_stop(&gwdt->wdd);
+}
+
 /* Disable watchdog if it is active during suspend */
 static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
 {
@@ -357,6 +365,7 @@ static struct platform_driver sbsa_gwdt_driver = {
 		.pm = &sbsa_gwdt_pm_ops,
 		.of_match_table = sbsa_gwdt_of_match,
 	},
+	.shutdown = sbsa_gwdt_shutdown,
 	.probe = sbsa_gwdt_probe,
 	.id_table = sbsa_gwdt_pdev_match,
 };
-- 
2.7.4

