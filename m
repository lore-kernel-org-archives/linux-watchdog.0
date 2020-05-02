Return-Path: <SRS0=ptbp=6Q=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60440C3A5A9
	for <linux-watchdog@archiver.kernel.org>; Sat,  2 May 2020 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFDB2496A
	for <linux-watchdog@archiver.kernel.org>; Sat,  2 May 2020 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588429617;
	bh=CB2qIt0YCg9YgJ9w+bsz7dbW1Jd2EWMmQ+Y4nnyAh2Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=odMo9v6drs3GYUK7EbFJvDEtUXbaDI1et/brconqMQj1wLVxcun0bL6bOJTvK2u8S
	 fenfE3JX4n39eiqWeZknwWhNBBoz+0eVGPdh65t56bfmhEQzf/q05ddkScey58mTOX
	 aejKGlgMzLzKXaL0w+6dvnW5PBFqMyzfL2afBX9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgEBO04 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 2 May 2020 10:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBO04 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 2 May 2020 10:26:56 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC2724957;
        Sat,  2 May 2020 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588429616;
        bh=CB2qIt0YCg9YgJ9w+bsz7dbW1Jd2EWMmQ+Y4nnyAh2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=LUbyz7VZinr56lxLh69WLjCpZJL3uX7m/udTre8cgjcLU5NU9vvAgTkjzIoNAZcPd
         hwrOzm9whdu4cfAW4a8h2c2vDmwYg0a81ZuXzhNmLECwedwZZoUjAEXUj5EF23UUQt
         Tk0TzZJslz46Oufr4azQvVG+hK7aYkjK8ADHxSWo=
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] watchdog: imx2_wdt: update contact email
Date:   Sat,  2 May 2020 16:26:53 +0200
Message-Id: <20200502142653.19144-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The 'pengutronix' address is defunct for years. Use the proper contact
address.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 drivers/watchdog/imx2_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 1fe472f56cb3..b84f80f7d342 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -2,7 +2,7 @@
 /*
  * Watchdog driver for IMX2 and later processors
  *
- *  Copyright (C) 2010 Wolfram Sang, Pengutronix e.K. <w.sang@pengutronix.de>
+ *  Copyright (C) 2010 Wolfram Sang, Pengutronix e.K. <kernel@pengutronix.de>
  *  Copyright (C) 2014 Freescale Semiconductor, Inc.
  *
  * some parts adapted by similar drivers from Darius Augulis and Vladimir
-- 
2.20.1

