Return-Path: <SRS0=2fBV=UA=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02EDC28CC1
	for <linux-watchdog@archiver.kernel.org>; Sat,  1 Jun 2019 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C34C272C5
	for <linux-watchdog@archiver.kernel.org>; Sat,  1 Jun 2019 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395172;
	bh=6bKgTT5gnfcJKsWHUTECbQrducSnrKEOJSsgdtKBWCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2hA++ZuoRCUsY8Bb4SVlFpTtuHK8+n3aeRtcdw6SAhr7Cb1M0S826pzvKSj9ksaA5
	 e5egmINj5oRfu+nHG6TeHaeR5Ru53JMqSGWYcAnPsmDsG2+uYIrUXoKCp+wsiL20Qa
	 9nc4QU6RRAEw8EHou4Nw1YCfCRMYoN8oiddmoeoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfFANTc (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfFANTX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Jun 2019 09:19:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3F6272AC;
        Sat,  1 Jun 2019 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395163;
        bh=6bKgTT5gnfcJKsWHUTECbQrducSnrKEOJSsgdtKBWCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEK97Hk4roJhvSPyrBIjEV5QLR5hVXQx3fDDFd6IJHJH9/5A4NcDhxSlvEJgeibOl
         kBZSPtIsDYxH5PFxBXmwyZvTpB0jAvfAknd18uL7RvnI3hkkF2GU21F63HKoURLUKh
         RQGGGYaiTPcnrZR55PSkfGucUNam+QNIZZxrpMAo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Georg Hofmann <georg@hofmannsweb.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 074/186] watchdog: imx2_wdt: Fix set_timeout for big timeout values
Date:   Sat,  1 Jun 2019 09:14:50 -0400
Message-Id: <20190601131653.24205-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Georg Hofmann <georg@hofmannsweb.com>

[ Upstream commit b07e228eee69601addba98b47b1a3850569e5013 ]

The documentated behavior is: if max_hw_heartbeat_ms is implemented, the
minimum of the set_timeout argument and max_hw_heartbeat_ms should be used.
This patch implements this behavior.
Previously only the first 7bits were used and the input argument was
returned.

Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/imx2_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 2b52514eaa86a..7e7bdcbbc741b 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -178,8 +178,10 @@ static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
 static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int new_timeout)
 {
-	__imx2_wdt_set_timeout(wdog, new_timeout);
+	unsigned int actual;
 
+	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
+	__imx2_wdt_set_timeout(wdog, actual);
 	wdog->timeout = new_timeout;
 	return 0;
 }
-- 
2.20.1

