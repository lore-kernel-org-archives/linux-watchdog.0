Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D15C43217
	for <linux-watchdog@archiver.kernel.org>; Tue, 26 Apr 2022 10:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348105AbiDZKGZ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348452AbiDZKFt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Apr 2022 06:05:49 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E773D4C49;
        Tue, 26 Apr 2022 02:27:16 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:52296.987177822
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 6B92E2800CD;
        Tue, 26 Apr 2022 17:27:13 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id cf2af3da9a8c4f84a470fdcf3d4c4e28 for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 17:27:15 CST
X-Transaction-ID: cf2af3da9a8c4f84a470fdcf3d4c4e28
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v6 0/3] Some impovements about acpi hardware watchdog
Date:   Tue, 26 Apr 2022 17:26:58 +0800
Message-Id: <1650965221-2533-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Changelog:
v1->v6 - Update the commit messages
       - Rename WDAT_TIMEOUT_MIN to WDAT_MIN_TIMEOUT

Liu Xinpeng (3):
  watchdog: wdat_wdg: Using the existing function to check parameter
    timeout
  watchdog: wdat_wdg: Stop watchdog when rebooting the system
  watchdog: wdat_wdg: Stop watchdog when uninstalling module

 drivers/watchdog/wdat_wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.23.0

