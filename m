Return-Path: <SRS0=4Gyp=YW=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D8CA9EAE
	for <linux-watchdog@archiver.kernel.org>; Tue, 29 Oct 2019 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E780820679
	for <linux-watchdog@archiver.kernel.org>; Tue, 29 Oct 2019 17:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbAl5aoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfJ2Rkm (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:40:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36991 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJ2Rkm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Oct 2019 13:40:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so13090629qkd.4
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Oct 2019 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CWPhtFj/OQa1LCw2CayuNIf9ZsZ9HP4t2jYM12d1Obo=;
        b=QbAl5aooHO9Mc4qJlaF3s3a5D7daWbnGV2q9T0uzZ63ZkE1Np0KLW4L93VXs0v+1iV
         9tg7vPVcS2nrIStasfXspO/ggETMvrBTVkjpfprBxOannMjS0J0SP/kWjnxH2kJQNTZ4
         7ZwJNyXURex2LbLjO7sMSn29A7rbj53xSsC2bW1Hk7cjDY6GN2vaf0V+eyEmVAbfFQws
         yHxK/WxVpNM0TXffRDpyWOFpeKNfSBcLWKvkwKJKjy/1MI3CeMcyIySAdLoKpG+QiVAF
         FtOffacXeAZl7fallx8fqEQfKr0cJbAP9ABn3Yx3ZwKTrRv956DLyhcnzZA/XVdL/6mo
         oERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CWPhtFj/OQa1LCw2CayuNIf9ZsZ9HP4t2jYM12d1Obo=;
        b=JyDIVL1ZAb4ye1Grsk5+IY6IKCpuKpYaJrsBOGC8W5b8Ow/dOsvEayf/l/PbdV3pZy
         iwUZwvZtwoddhlfIHQ04lxoC/aW2SdddI6PFyjk84iJIrAdNcxsidfbaz4HYPILDVbfL
         iTLK1UoAbe/xpKUQfOi/84leSQmM+To+szwvQM5WPkF/SPZRgyCRRI3ylLjtXG8v1cBq
         6RNS0qXlkn8Jf9klWBOFhDBblXriptDm1KyVDJUlsJ/8vsX0pmWTRTXbdjdjvpma0LNA
         BbBSbyi7ODgkN8U4/h9o+RMw/8uQE6HKxItr69RNCeXsWnrZcp9iuXbdsLC2Kfh4coaf
         wizA==
X-Gm-Message-State: APjAAAXxDJyak52YA/EByGDfuLs8L5t521TI++KCGIhZfI2D+aMCLUB1
        j+8O9jYuyklhgVL0xFxPqjc=
X-Google-Smtp-Source: APXvYqz2R9cdoPltTPvFAWNKpZk743df189OT80KeVxDHf5VbdjH9w13PBoJFYximAHVCTGYZYYGwg==
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr23200599qke.62.1572370841027;
        Tue, 29 Oct 2019 10:40:41 -0700 (PDT)
Received: from fabio-Latitude-E5450.nxp.com ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id c21sm7417725qtg.61.2019.10.29.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:40:40 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        Anson.Huang@nxp.com, shawnguo@kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/5] watchdog: imx7ulp: Fix reboot hang
Date:   Tue, 29 Oct 2019 14:40:33 -0300
Message-Id: <20191029174037.25381-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The following hang is observed when a 'reboot' command is issued:

# reboot
# Stopping network: OK
Stopping klogd: OK
Stopping syslogd: OK
umount: devtmpfs busy - remounted read-only
[    8.612079] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[   10.694753] reboot: Restarting system
[   11.699008] Reboot failed -- System halted

Fix this problem by adding a .restart ops member.

Fixes: 41b630f41bf7 ("watchdog: Add i.MX7ULP watchdog support")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 5ce51026989a..ba5d535a6db2 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -106,12 +106,28 @@ static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
 	return 0;
 }
 
+static int imx7ulp_wdt_restart(struct watchdog_device *wdog,
+			       unsigned long action, void *data)
+{
+	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
+
+	imx7ulp_wdt_enable(wdt->base, true);
+	imx7ulp_wdt_set_timeout(&wdt->wdd, 1);
+
+	/* wait for wdog to fire */
+	while (true)
+		;
+
+	return NOTIFY_DONE;
+}
+
 static const struct watchdog_ops imx7ulp_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = imx7ulp_wdt_start,
 	.stop  = imx7ulp_wdt_stop,
 	.ping  = imx7ulp_wdt_ping,
 	.set_timeout = imx7ulp_wdt_set_timeout,
+	.restart = imx7ulp_wdt_restart,
 };
 
 static const struct watchdog_info imx7ulp_wdt_info = {
-- 
2.17.1

