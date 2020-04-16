Return-Path: <SRS0=1I5r=6A=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB790C2BB55
	for <linux-watchdog@archiver.kernel.org>; Thu, 16 Apr 2020 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A052222D
	for <linux-watchdog@archiver.kernel.org>; Thu, 16 Apr 2020 16:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgDPQfX (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:35:23 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:36795 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727976AbgDPQfW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 16 Apr 2020 12:35:22 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from michaelsh@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 16 Apr 2020 19:35:19 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 03GGZIjD013255;
        Thu, 16 Apr 2020 19:35:18 +0300
From:   michaelsh@mellanox.com
To:     linux@roeck-us.net, wim@linux-watchdog.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 0/4] support watchdog with longer timeout period
Date:   Thu, 16 Apr 2020 19:35:10 +0300
Message-Id: <20200416163514.7334-1-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

This patchset adds support of extended new watchdog type 3 of Mellanox
Ethernet and Infiniband switch systems.
This type of watchdog can have a timeout period longer than 255 or 32 sec.
as it was before.

Michael Shych (4):
  platform_data/mlxreg: support new watchdog type with longer timeout
    period
  platform/x86: mlx-platform: support new watchdog type with longer
    timeout
  watchdog: mlx-wdt: support new watchdog type with longer timeout
    period
  Documentation/watchdog: Add description of new watchdog type 3

 Documentation/watchdog/mlx-wdt.rst   |   9 +++
 drivers/platform/x86/mlx-platform.c  | 106 +++++++++++++++++++++++++++++++
 drivers/watchdog/mlx_wdt.c           |  75 +++++++++++++++++++++----
 include/linux/platform_data/mlxreg.h |   5 +-
 4 files changed, 183 insertions(+), 12 deletions(-)

-- 
2.11.0

