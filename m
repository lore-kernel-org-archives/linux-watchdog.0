Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B523C4332F
	for <linux-watchdog@archiver.kernel.org>; Thu, 24 Feb 2022 07:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiBXHvr (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 24 Feb 2022 02:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiBXHvj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 Feb 2022 02:51:39 -0500
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7F5818A78F
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Feb 2022 23:50:59 -0800 (PST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26020:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Thu, 24 Feb 2022 15:42:25 +0800 (CST)
From:   Xiantao Hu <xt.hu@cqplus1.com>
To:     wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, qinjian@cqplus1.com,
        Xiantao Hu <xt.hu@cqplus1.com>
Subject: [PATCH v5 0/2] Add watchdog driver for Sunplus SP7021 SoC
Date:   Thu, 24 Feb 2022 15:42:40 +0800
Message-Id: <20220224074242.6944-1-xt.hu@cqplus1.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

This is a patch series for watchdog driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Xiantao Hu (2):
  watchdog: Add Sunplus SP7021 WDT devicetree bindings documentation
  watchdog: Add watchdog driver for Sunplus SP7021

 .../bindings/watchdog/sunplus,sp7021-wdt.yaml |  47 ++++
 MAINTAINERS                                   |   7 +
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/sunplus_wdt.c                | 218 ++++++++++++++++++
 5 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
 create mode 100644 drivers/watchdog/sunplus_wdt.c

-- 
2.33.1

