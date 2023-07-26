Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DB2C001B0
	for <linux-watchdog@archiver.kernel.org>; Wed, 26 Jul 2023 11:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGZLWb (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 26 Jul 2023 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGZLWa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Jul 2023 07:22:30 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C710D4;
        Wed, 26 Jul 2023 04:22:28 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 26 Jul 2023
 19:22:07 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH 0/4] Add watchdog support for Amlogic-T7 SoCs
Date:   Wed, 26 Jul 2023 19:21:42 +0800
Message-ID: <20230726112146.1127145-1-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Based on the original Amlogic-GXBB watchdog driver, support
for Amlogic-T7 watchdog is added.

Huqiang Qin (4):
  dt-bindings: watchdog: Add support for Amlogic-T7 SoCs
  watchdog: Add a new struct for Amlogic-GXBB driver
  watchdog: Add support for Amlogic-T7 SoCs
  arm64: dts: Add watchdog node for Amlogic-T7 SoCs

 .../watchdog/amlogic,meson-gxbb-wdt.yaml      |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |  6 ++++++
 drivers/watchdog/meson_gxbb_wdt.c             | 21 ++++++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.37.1

