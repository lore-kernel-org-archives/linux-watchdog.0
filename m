Return-Path: <SRS0=AWpR=34=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010A4C3F68F
	for <linux-watchdog@archiver.kernel.org>; Sat,  8 Feb 2020 13:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7032F22464
	for <linux-watchdog@archiver.kernel.org>; Sat,  8 Feb 2020 13:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfX2zA/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBHNI2 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 8 Feb 2020 08:08:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35801 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBHNI2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Feb 2020 08:08:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id y73so1237074pfg.2;
        Sat, 08 Feb 2020 05:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=EDMYNu7hdVH2rxKB7E9yljxLvOyJt5lGEkzKSb7vqfc=;
        b=mfX2zA/gMAdzAPuK3D2sULpz7nafoCuB2na5QQRjVvXQlC60OMyEifeWuGA6OYAh2r
         QTQecoxV171rsup9QW660Oln04pPEGtOjJhkjIDyzxXo2Kz47RUzzUDBY9dKMz5x6nSL
         mwUD8igbO6I46WIPunawXgOQ0AbDwjLRmclBHRelABvEU9yT1vTxZQPFkM8XTy3uW7Z6
         Ipgo/k/sx+rEwbnimj3g2N2/61toBU6Dd3+DR52OOPqBYIX0syaVE8eHNRE3cfGrr5p3
         fIuHS41NTD7F1kFQC9nFQ1ZA1uyrc6mQpfqGxmyQs9veoDr3IU0vpI21kxQA2kTTr26k
         exQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=EDMYNu7hdVH2rxKB7E9yljxLvOyJt5lGEkzKSb7vqfc=;
        b=bT2UZHvyRx2wJSzUT+RYOrtNGqZQ9N1sD9fiwFSoH0Ji5g/EAfMvAErdFU4SjaNdN3
         u4SVMGh3zjVyzDKx5sAcRA2bO3bo/RR+90g0IZEwXmOzjvjEG3G4fybrny6NOgCpiKjX
         DOiyF5LNjfHgIwa/r55q09A3eFBLtWEQWQrXiDmdJb2q/5cKoHWftt8BxyI8UMxqpf+Z
         Zvr1gyBCqseYwnr/AOdMr0AqI1ncjuMj9j6qnH67/cnW6Hs7FD27gmLSySi0/7U90++J
         r0qd/cEkRquhpl6f36j6XMkjyay9zGT8gaJfRmr7EyZpdUq6dAad/jj76vEQNsZuLhSt
         A0QA==
X-Gm-Message-State: APjAAAVuxQWjXtFGgFJV15q55Som/uluFCrVOs/LUgv2i0/nfa3h86X3
        nRhw5sgHJv1VIC7RpHBxfVPDLpvT
X-Google-Smtp-Source: APXvYqzRvHz921D29+apebtFGd1Xh/ZFmKZfekse5UsDjGgNaOxsYV8py8MTC1C1rhXd7UHPFUc9Fg==
X-Received: by 2002:a63:744f:: with SMTP id e15mr4892790pgn.344.1581167308111;
        Sat, 08 Feb 2020 05:08:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i27sm6349627pgn.76.2020.02.08.05.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Feb 2020 05:08:27 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>
Subject: [PATCH] watchdog: da9062: Add dependency on I2C
Date:   Sat,  8 Feb 2020 05:08:03 -0800
Message-Id: <20200208130803.23387-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Since commit 057b52b4b3d58 ("watchdog: da9062: make restart handler atomic
safe"), the driver calls i2c functions directly. It now therefore depends
on I2C. This is a hard dependency which overrides COMPILE_TEST.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 057b52b4b3d58 ("watchdog: da9062: make restart handler atomic safe")
Cc: Marco Felsch <m.felsch@pengutronix.de>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Stefan Lengfeld <contact@stefanchrist.eu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c3c8e0786a99..9ea2b43d4b01 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -207,6 +207,7 @@ config DA9063_WATCHDOG
 config DA9062_WATCHDOG
 	tristate "Dialog DA9062/61 Watchdog"
 	depends on MFD_DA9062 || COMPILE_TEST
+	depends on I2C
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the DA9062 and DA9061 PMICs.
-- 
2.17.1

