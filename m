Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43843 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbeE1SCP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 28 May 2018 14:02:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id f13-v6so15734619qtp.10
        for <linux-watchdog@vger.kernel.org>; Mon, 28 May 2018 11:02:15 -0700 (PDT)
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 6/6] arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG
Date: Mon, 28 May 2018 11:01:37 -0700
Message-Id: <1527530497-10392-7-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Enable the SP805 watchdog timer

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..3fe5eb5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -351,6 +351,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
-- 
2.1.4

