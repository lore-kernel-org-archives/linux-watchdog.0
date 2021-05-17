Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B6C433B4
	for <linux-watchdog@archiver.kernel.org>; Mon, 17 May 2021 17:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CD0610A1
	for <linux-watchdog@archiver.kernel.org>; Mon, 17 May 2021 17:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhEQRuL (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 17 May 2021 13:50:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:39399 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235250AbhEQRuL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 May 2021 13:50:11 -0400
IronPort-SDR: VE1uIgloMkvg5r/JiHXokcdt/KJHsom+6ghXeIGBVcz38NWrLEX/r0Ksc/TBv4Q1kFRXb/Tekm
 vMjE0Y2dD8ow==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187929921"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="187929921"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 10:48:54 -0700
IronPort-SDR: wEQZSJljAWnaZNKGdHmhbtk7Taf0Nysh5hkq1nA53VQhEypDjein5JPQ94FeLwLCylEVStXva+
 uKs2WK5jtZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="432739813"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2021 10:48:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2ED2E12F; Mon, 17 May 2021 20:49:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v1 1/1] watchdog: sp805: Fix kernel doc description
Date:   Mon, 17 May 2021 20:49:12 +0300
Message-Id: <20210517174912.26419-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Kernel doc validation script is not happy

  CHECK   .../sp805_wdt.c
  .../sp805_wdt.c:73: warning: Function parameter or member 'rate' not described in 'sp805_wdt'

Fix this by describing rate parameter.

While at it, mark clk one optional.

Fixes: dc0e4a3bb7dc ("watchdog: sp805: Add clock-frequency property")
Cc: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/sp805_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 531551216c8c..dbeb2146c968 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -57,7 +57,8 @@
  * @wdd: instance of struct watchdog_device
  * @lock: spin lock protecting dev structure and io access
  * @base: base address of wdt
- * @clk: clock structure of wdt
+ * @clk: (optional) clock structure of wdt
+ * @rate: (optional) clock rate when provided via properties
  * @adev: amba device structure of wdt
  * @status: current status of wdt
  * @load_val: load value to be set for current timeout
-- 
2.30.2

