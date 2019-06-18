Return-Path: <SRS0=Ud7C=UR=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A22C31E5B
	for <linux-watchdog@archiver.kernel.org>; Tue, 18 Jun 2019 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509D8213F2
	for <linux-watchdog@archiver.kernel.org>; Tue, 18 Jun 2019 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560873493;
	bh=hkGr9x/xv7m0mGQQGoEQAw82L2pKAq5xfGQ5XkmJLHs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PPMEP1WVjTbD3XpEwxxaWUItrwppN1mF3Q12Xxipy3JeMMXwXqrPgswYNd3Ta8UCc
	 lyOoDiXbaWNTVy/xL110Vu/+NXGngjMVI+/HsOc2DQd+RHPFUlHXGoOI5YzC33yFbP
	 +72iZB2hcS4r9nX9hlRmrhb2fyM3wPYZvr/DgU24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfFRP6N (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfFRP6N (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 18 Jun 2019 11:58:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA50A20873;
        Tue, 18 Jun 2019 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560873492;
        bh=hkGr9x/xv7m0mGQQGoEQAw82L2pKAq5xfGQ5XkmJLHs=;
        h=Date:From:To:Cc:Subject:From;
        b=sUMDQuJh+i4sFxEVaKhzylDvDptswpL6pzy0uRYO3V5U0TWjKr9AcT/PypyuHWtLx
         GrEkAq3eI2a4ykS8gr2IYjCt/44rXc/v0Du/x5xhXAKmbGiS+pBp1CZR1NTG3U8G8I
         VqmgGnasrVcKKSzmKdKBHXlGkAJSLaseZf83HDYY=
Date:   Tue, 18 Jun 2019 17:58:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: bcm_kona_wdt: no need to check return value of
 debugfs_create functions
Message-ID: <20190618155809.GA21825@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/bcm_kona_wdt.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index e2ad44816359..921291025680 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -143,24 +143,18 @@ static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
 	wdt->debugfs = NULL;
 
 	dir = debugfs_create_dir(BCM_KONA_WDT_NAME, NULL);
-	if (IS_ERR_OR_NULL(dir))
-		return;
 
-	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
-				&bcm_kona_fops))
-		wdt->debugfs = dir;
-	else
-		debugfs_remove_recursive(dir);
+	debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
+			    &bcm_kona_fops);
+	wdt->debugfs = dir;
 }
 
 static void bcm_kona_wdt_debug_exit(struct platform_device *pdev)
 {
 	struct bcm_kona_wdt *wdt = platform_get_drvdata(pdev);
 
-	if (wdt && wdt->debugfs) {
+	if (wdt)
 		debugfs_remove_recursive(wdt->debugfs);
-		wdt->debugfs = NULL;
-	}
 }
 
 #else
-- 
2.22.0

