Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1337CC282CE
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AC4218FE
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDNK0f (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:26:35 -0400
Received: from sauhun.de ([88.99.104.3]:32890 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfDNK0f (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 06:26:35 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id 7EF894A1351;
        Sun, 14 Apr 2019 12:26:33 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 02/16] watchdog: add error messages when initializing timeout fails
Date:   Sun, 14 Apr 2019 12:26:13 +0200
Message-Id: <20190414102627.5564-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

This not only removes boilerplate code from watchdog drivers, it can
also be more specific which of the supplied value actually fails. Also,
the loglevel becomes now consistent across drivers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/watchdog_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 85c136acc0e9..407a5ca121d7 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -124,6 +124,8 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 			wdd->timeout = timeout_parm;
 			return 0;
 		}
+		dev_err(dev, "driver supplied timeout (%u) out of range\n",
+			timeout_parm);
 		ret = -EINVAL;
 	}
 
@@ -134,9 +136,13 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 			wdd->timeout = t;
 			return 0;
 		}
+		dev_err(dev, "DT supplied timeout (%u) out of range\n", t);
 		ret = -EINVAL;
 	}
 
+	if (ret < 0 && wdd->timeout)
+		dev_warn(dev, "falling back to default timeout (%u)\n", wdd->timeout);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
-- 
2.11.0

