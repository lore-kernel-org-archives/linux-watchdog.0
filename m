Return-Path: <SRS0=UTCC=6C=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B2C3A5A9
	for <linux-watchdog@archiver.kernel.org>; Sat, 18 Apr 2020 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4506221BE5
	for <linux-watchdog@archiver.kernel.org>; Sat, 18 Apr 2020 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587218018;
	bh=ddR3lY7X7Py94OEnLYZZsrm3gr2MaNXEqKJZwflfaEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cTVng6UZj05MmVn8zw9OCs08pe7HpgSSM/nk917w8/WuQ8ANDepuiBcYbVzvKLTIi
	 1Kh2hKl7O/R4c2WcgHrWA0+09zZgIDdcPbWsV0PUsmxM+2p8nP6d/sWv3AYOt8ewmK
	 KXc/NbS5q2sYpGYs3tM7fXBvLRV6qZ1wgxYSXUmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDRNsV (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgDRNsT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 18 Apr 2020 09:48:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D365021D6C;
        Sat, 18 Apr 2020 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217699;
        bh=ddR3lY7X7Py94OEnLYZZsrm3gr2MaNXEqKJZwflfaEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xM5udgLwdggiVYUcFZeGMYsFH70VPp5ISyb6Sx+X/jMj9poWNQwnTxq3yHgsH1KqR
         ABiGAw+uPjqpoYvuqcNO13G+hVOLx9QnmeJmX98XiIO6QqSw5n1cQ/rXdyEv/SHBcH
         f16rIy+9a3OGMSr8C6pNK5/Du6N9nCLunsrf8WfE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 03/73] watchdog: reset last_hw_keepalive time at start
Date:   Sat, 18 Apr 2020 09:47:05 -0400
Message-Id: <20200418134815.6519-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit 982bb70517aef2225bad1d802887b733db492cc0 ]

Currently the watchdog core does not initialize the last_hw_keepalive
time during watchdog startup. This will cause the watchdog to be pinged
immediately if enough time has passed from the system boot-up time, and
some types of watchdogs like K3 RTI does not like this.

To avoid the issue, setup the last_hw_keepalive time during watchdog
startup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200302200426.6492-3-t-kristo@ti.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/watchdog_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 8b5c742f24e81..7e4cd34a8c20e 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -282,6 +282,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
 		wd_data->last_keepalive = started_at;
+		wd_data->last_hw_keepalive = started_at;
 		watchdog_update_worker(wdd);
 	}
 
-- 
2.20.1

