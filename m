Return-Path: <SRS0=TBvV=Q2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF348C43381
	for <linux-watchdog@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4C821848
	for <linux-watchdog@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfBSRCp (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:02:45 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35657 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728086AbfBSRCo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 19 Feb 2019 12:02:44 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from michaelsh@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Feb 2019 19:02:39 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x1JH2dYE000551;
        Tue, 19 Feb 2019 19:02:39 +0200
From:   michaelsh@mellanox.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v3 0/3] introduce watchdog driver for Mellanox systems.
Date:   Tue, 19 Feb 2019 17:02:32 +0000
Message-Id: <20190219170235.8385-1-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

This patchset introduces watchdog driver for a various range of Mellanox
Ethernet and Infiniband switch systems.
Mellanox watchdog device is implemented in programmable logic device.
There are 2 types of HW watchdog implementations with different capabilities.
This mlx-wdt driver supports both HW watchdog implementations.
Mellanox system can have 2 watchdogs: main and auxiliary.
Main and auxiliary watchdog devices can be enabled together on the same system.
There are several actions that can be defined in the watchdog:
system reset, start fans on full speed and increase register counter.

Michael Shych (3):
  platform_data/mlxreg:	additions for Mellanox watchdog driver.
  watchdog: mlx-wdt: introduce a watchdog driver for Mellanox systems.
  Documentation/watchdog: Add documentation mlx-wdt driver

 Documentation/watchdog/mlx-wdt.txt   |  48 ++++++
 drivers/watchdog/Kconfig             |  16 ++
 drivers/watchdog/Makefile            |   1 +
 drivers/watchdog/mlx_wdt.c           | 290 +++++++++++++++++++++++++++++++++++
 include/linux/platform_data/mlxreg.h |  19 +++
 5 files changed, 374 insertions(+)
 create mode 100644 Documentation/watchdog/mlx-wdt.txt
 create mode 100644 drivers/watchdog/mlx_wdt.c

-- 
2.11.0

