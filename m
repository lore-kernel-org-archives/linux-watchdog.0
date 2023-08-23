Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E064DEE4993
	for <linux-watchdog@archiver.kernel.org>; Wed, 23 Aug 2023 15:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjHWPLS (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 23 Aug 2023 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjHWPLR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 Aug 2023 11:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C1FCC;
        Wed, 23 Aug 2023 08:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF1964429;
        Wed, 23 Aug 2023 15:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25581C433C9;
        Wed, 23 Aug 2023 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803475;
        bh=PafhZcJT5SQLA6QnjYq4kDAbgIm4cBuEG5/om2ECzEM=;
        h=From:To:Cc:Subject:Date:From;
        b=CTg0dxn2ottiJGvb2EFmf9W3p6crkzpOyJ8nPYWGbQqUgiFIlHILV+QeINMIbs2db
         wJ4rTwnm2Nw4MGbO2f/RacNnAWl09a28H0f+J0lgCb5IQ9b94UowanZtP8BbnIF/1A
         3w/8BcesIFouUcwW2l1hGyHabhiXsUcZ4XxTrFaO0zQIbBUieZQyqRcK4HogyQnJor
         j2pMmLnd5ZQWFp68/7qoIUc3/NfBYMqT6jrS3MII+gL4ZPxcRclABAYEqq9Rf3Jppv
         GeKCf+1aE3zxPAZSGc4oxdXDujDeDKS8AdoeR4QNw6pUaR/BQjyPeyro2iPvrwdG6B
         I2fq+5sesLO/w==
Received: (nullmailer pid 2357148 invoked by uid 1000);
        Wed, 23 Aug 2023 15:11:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel test robot <lkp@intel.com>, linux-watchdog@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: stm32: Drop unnecessary of_match_ptr()
Date:   Wed, 23 Aug 2023 10:10:59 -0500
Message-Id: <20230823151059.2356881-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

With COMPILE_TEST recently enabled, 0-day reports a warning:

drivers/watchdog/stm32_iwdg.c:215:34: warning: 'stm32_iwdg_of_match' defined but not used [-Wunused-const-variable=]

As STM32 platforms are always used with DT, drop the of_match_ptr().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308211837.4VBSUAtZ-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/watchdog/stm32_iwdg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 570a71509d2a..9a554a3db4e2 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -288,7 +288,7 @@ static struct platform_driver stm32_iwdg_driver = {
 	.probe		= stm32_iwdg_probe,
 	.driver = {
 		.name	= "iwdg",
-		.of_match_table = of_match_ptr(stm32_iwdg_of_match),
+		.of_match_table = stm32_iwdg_of_match,
 	},
 };
 module_platform_driver(stm32_iwdg_driver);
-- 
2.40.1

