Return-Path: <SRS0=2fBV=UA=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE378C28CC5
	for <linux-watchdog@archiver.kernel.org>; Sat,  1 Jun 2019 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36E2272B4
	for <linux-watchdog@archiver.kernel.org>; Sat,  1 Jun 2019 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395164;
	bh=wZ6tuDrRkPrM+Vcz63gxvzc04Ec8yGwcjLpW6W+50Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tjm0Gvq8OuxZ1FQrwRuWz/TXDoD5iJtVDpz+LlwxhUuR4n0dS3BiuqMJ06X79bSRD
	 0UK+VjGsLkzCHccHwC8N/H8+zwQm55zgPy0SLKklnO3mCwtj0nxqTh/dtQTsz/KNNn
	 c/hzDjUgwabYsH28cn4vqtiYkxpRNp9AK/Z+io14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfFANTX (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbfFANTX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Jun 2019 09:19:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317BD2725F;
        Sat,  1 Jun 2019 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395161;
        bh=wZ6tuDrRkPrM+Vcz63gxvzc04Ec8yGwcjLpW6W+50Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1mwd+EeP+X+tG7D4B6+WjcldxfGcVhvGG4YcM/z3j42JdAjldTEecBYHu2n3yh2w
         vQnT9pB3j5tlpEXa+MoF34knNwvZcrqMiiGJ6QPgHFcqaWZ3vh3sGGrm9CqwfDoIXc
         vonTblkVtcLhvdsIasD9Ml0ybFJwTevWwhxMV8W4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 073/186] watchdog: Use depends instead of select for pretimeout governors
Date:   Sat,  1 Jun 2019 09:14:49 -0400
Message-Id: <20190601131653.24205-73-sashal@kernel.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit f627ac0e12cd2736e60b9f5782ecec1d97251f77 ]

Watchdog pretimeout governors were enabled from the default governor
selection using "select". As a result, the default governor was always
built into the kernel, even if no watchdog driver was loaded. By using
"depends on" instead of "select", we are in better control, and the
governors can all be built as modules. At the same time, set the default
configuration option for pretimeout governors to match WATCHDOG_CORE
(meaning all pretimeout governors are by default enabled if pretimeout
support is enabled).

The practical impact of this change is minimal. Previously, selecting
a default governor automatically enabled that governor. Now, a default
governor can only be selected if that governor has been enabled.
Consequently, the order of governor selection is now reversed: The
governor selection is now first, followed by default governor selection.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/Kconfig | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 242eea8596373..1d3b4bfbbc4d8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2033,6 +2033,20 @@ config WATCHDOG_PRETIMEOUT_GOV
 
 if WATCHDOG_PRETIMEOUT_GOV
 
+config WATCHDOG_PRETIMEOUT_GOV_NOOP
+	tristate "Noop watchdog pretimeout governor"
+	default WATCHDOG_CORE
+	help
+	  Noop watchdog pretimeout governor, only an informational
+	  message is added to kernel log buffer.
+
+config WATCHDOG_PRETIMEOUT_GOV_PANIC
+	tristate "Panic watchdog pretimeout governor"
+	default WATCHDOG_CORE
+	help
+	  Panic watchdog pretimeout governor, on watchdog pretimeout
+	  event put the kernel into panic.
+
 choice
 	prompt "Default Watchdog Pretimeout Governor"
 	default WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
@@ -2043,7 +2057,7 @@ choice
 
 config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
 	bool "noop"
-	select WATCHDOG_PRETIMEOUT_GOV_NOOP
+	depends on WATCHDOG_PRETIMEOUT_GOV_NOOP
 	help
 	  Use noop watchdog pretimeout governor by default. If noop
 	  governor is selected by a user, write a short message to
@@ -2051,7 +2065,7 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
 
 config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
 	bool "panic"
-	select WATCHDOG_PRETIMEOUT_GOV_PANIC
+	depends on WATCHDOG_PRETIMEOUT_GOV_PANIC
 	help
 	  Use panic watchdog pretimeout governor by default, if
 	  a watchdog pretimeout event happens, consider that
@@ -2059,18 +2073,6 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
 
 endchoice
 
-config WATCHDOG_PRETIMEOUT_GOV_NOOP
-	tristate "Noop watchdog pretimeout governor"
-	help
-	  Noop watchdog pretimeout governor, only an informational
-	  message is added to kernel log buffer.
-
-config WATCHDOG_PRETIMEOUT_GOV_PANIC
-	tristate "Panic watchdog pretimeout governor"
-	help
-	  Panic watchdog pretimeout governor, on watchdog pretimeout
-	  event put the kernel into panic.
-
 endif # WATCHDOG_PRETIMEOUT_GOV
 
 endif # WATCHDOG
-- 
2.20.1

