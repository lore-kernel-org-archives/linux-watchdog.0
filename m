Return-Path: <SRS0=lwmN=RV=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A7EC43381
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Mar 2019 01:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67B920857
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Mar 2019 01:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfCRBTT (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:19:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCRBTT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 17 Mar 2019 21:19:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id w2so15148245wrt.11
        for <linux-watchdog@vger.kernel.org>; Sun, 17 Mar 2019 18:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFB3nklnkEAjZS6lQcgtLaEE780jsrFLXfmLpwt1Lt8=;
        b=oQgTiHtmlcf0tNAEF8GHEuHGvBhEzbKBOo/n5NCmTUcA6UD1+Td2opndVKdNPoOveo
         2FMiOQrBMe0c4ZSvFHQRyzLTH9mAu1Bzw56eX19fo+1KeTb4RDxuiU1S2u5X6J/HhZUZ
         wuS5td8qxITI48YenxX0mK32JkkqbYzw9N7k7bUAgVqft6iAApSb36e7XNWAV04LokfN
         DbYdsMQffRXgcq7NH2aFkjsjIZHLtUuyvQK+voLfRTwYbDqt/fvdCsjtjKL6kJ7Jv72k
         ip/z39z+7vytRPHHG5+ytd633RWFCmUAwxPThirXQ5+k0J+OSYBMASJF8ZrYCAijRgzW
         4+Ag==
X-Gm-Message-State: APjAAAWGrYyzJseHRdN/z/znH7Prebstg66XHVlB+9mnQqoLgVjmb2j8
        1nCFgh0+1ZB3wKCrsJucDlsXoQMTSgk=
X-Google-Smtp-Source: APXvYqymcfao/Ls+UDdRV9TRfFIoMk15JeQwEzbkgL7tAGmT+GlNtM/eNqeRV9grS1G3ICDEHgN8DQ==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr9721709wrn.77.1552871957350;
        Sun, 17 Mar 2019 18:19:17 -0700 (PDT)
Received: from raver.teknoraver.net (net-188-216-58-50.cust.vodafonedsl.it. [188.216.58.50])
        by smtp.gmail.com with ESMTPSA id y1sm7277962wma.48.2019.03.17.18.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 18:19:16 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-watchdog@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH] watchdog: i6300esb: stop printing kernel addresses
Date:   Mon, 18 Mar 2019 02:19:15 +0100
Message-Id: <20190318011915.32442-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
i6300esb prints "____ptrval____" instead of actual addresses:

    i6300ESB timer 0000:00:03.0: initialized (0x(____ptrval____)). heartbeat=30 sec (nowayout=1)

Instead of changing the print to "%px", and leaking kernel addresses,
just remove the print completely, cfr. e.g. commit 071929dbdd865f77
("arm64: Stop printing the virtual memory layout").

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/watchdog/i6300esb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 950c71a8bb22..e312a2aeecad 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -328,8 +328,8 @@ static int esb_probe(struct pci_dev *pdev,
 		goto err_unmap;
 	}
 	dev_info(&pdev->dev,
-		"initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
-		edev->base, edev->wdd.timeout, nowayout);
+		"initialized. heartbeat=%d sec (nowayout=%d)\n",
+		edev->wdd.timeout, nowayout);
 	return 0;
 
 err_unmap:
-- 
2.20.1

