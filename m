Return-Path: <SRS0=UTCC=6C=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5579C38A29
	for <linux-watchdog@archiver.kernel.org>; Sat, 18 Apr 2020 14:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C39E21BE5
	for <linux-watchdog@archiver.kernel.org>; Sat, 18 Apr 2020 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219278;
	bh=ddR3lY7X7Py94OEnLYZZsrm3gr2MaNXEqKJZwflfaEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aqdjm/r6gXSoseUsqpse1lDTppxiPCv2p4oHMRD/YnWoh7L5BI7K51xdKRrUUjG+7
	 e1jeLYaEFhTJ6lyKVZher3VATN733x+o6p5v+oBAeCWc54+oZwwbxgiVtb2jqXlL7a
	 HRO/JoCVPfYXOpdQ80w4Y4cS2y5lanAJwIDVOlJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDROJP (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgDROJO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C07EA21D6C;
        Sat, 18 Apr 2020 14:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218954;
        bh=ddR3lY7X7Py94OEnLYZZsrm3gr2MaNXEqKJZwflfaEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9NJTnNYBSAOZR2vCSdgGYf7vlYvrp8G0ZbrzCw5S+AlL0xzUQv/vGErGBZ21VmE1
         gphoihsO/uj4cAbJx6c+8LU09lHqE/oD2qGKox7fAvwNIdpT1MwPNlXRowR6Zw4sey
         75bGAR0DEsv4gQICiCnvUrjwQdaZ9xf2La/mXchw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 03/75] watchdog: reset last_hw_keepalive time at start
Date:   Sat, 18 Apr 2020 10:07:58 -0400
Message-Id: <20200418140910.8280-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
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

