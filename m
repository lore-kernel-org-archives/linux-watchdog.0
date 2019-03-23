Return-Path: <SRS0=MUxE=R2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8EAC10F05
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9838321873
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZOXO69iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfCWVTW (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:19:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34495 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfCWVQ5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Mar 2019 17:16:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id o10so6721010wmc.1
        for <linux-watchdog@vger.kernel.org>; Sat, 23 Mar 2019 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AdHRYJryAaxYVOMT8m1MuQVCWPZpf0WJ2ig7I3MUpzE=;
        b=ZOXO69iyAEJoTueYZBYxaPeNXjucZ4yRr2588wavJL4dvF/TSIDm1HcsjMLdsP+U4s
         hOkCOo7dsVU/IbrCGomdjvPCRW1kH3O24p7Q+yhICWNOTuuP42POXw7mgYrBo812CiCX
         ljyaqqJ25StC4HDdn46+b0xRFo/pUKavgbBP/bl2f+DjdVhDOC8BazPCwilkWqT9q+wx
         MMVPD2oPkdykfnF+gns/CWGHm7irAYjvBevgbEgfnZBgoKPOGj8KdujIsU7imFRndQDB
         hzYWJ522OiDlUcOlbPyEjinyICam7ZD3lrRbyNH2w2W0tno++MG9NXV4s0t5SuvdLTRj
         vLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AdHRYJryAaxYVOMT8m1MuQVCWPZpf0WJ2ig7I3MUpzE=;
        b=nq5u6QsYl2SsgLoDvTAJUpokpzZGLmbyOxtUMy1ag/i9F3mWWZr4Gq2IxX5jxskntq
         4EZcVK8AzlAYJIZwcKdKKKYgChKoqcsU6SVbExq3WbKvCJu80aLi+KZDYc1FuvexIxAL
         EyQE+ADMD1816DWIXODjOCShpOcDcXl+nLy+uerOZnB78hNbXNCHOq6TtaDjKgxxTzwH
         bJSsX/2fEWg6rqzUJKxa4ya282suveANBC+mov+D3PGcRuywYIrWx2ELVtvT/33BEFKU
         KFzagLmt/h6+BZmMLxhwwak3fnYyCTgImauH5nkqDb00sT4vZNZKhx6r0izEecGv7K7R
         au4g==
X-Gm-Message-State: APjAAAU43JuGHLJCD5gk1mQ8ciPl8mq3+s9UQ7rY0vIp+yX3t0rpILH+
        PdIxsA9Ayh2Gz1a6KmcnTwzwAA==
X-Google-Smtp-Source: APXvYqxYPaJhFRUHv8HBUyZW5omCRwDkkzMwHJ14T3fFjhXXI4tFr09qr7yHSwkWltyTVfz+3nuGqw==
X-Received: by 2002:a1c:4cf:: with SMTP id 198mr831787wme.125.1553375815235;
        Sat, 23 Mar 2019 14:16:55 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:16:54 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 07/24] arm64: dts: mt6392: Add PMIC mt6392 dtsi
Date:   Sat, 23 Mar 2019 22:15:55 +0100
Message-Id: <20190323211612.860-8-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add the regulator nodes for the MT6392 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi | 208 +++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..e33a45fd52af
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+&pwrap {
+	pmic: mt6392 {
+		compatible = "mediatek,mt6392", "mediatek,mt6323";
+		mediatek,system-power-controller;
+
+		mt6392_regulator: mt6392_regulator {
+			compatible = "mediatek,mt6392-regulator";
+
+			mt6392_vproc_reg: buck_vproc {
+				regulator-name = "buck_vproc";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <12500>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vsys_reg: buck_vsys {
+				regulator-name = "buck_vsys";
+				regulator-min-microvolt = <1400000>;
+				regulator-max-microvolt = <2987500>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vcore_reg: buck_vcore {
+				regulator-name = "buck_vcore";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <12500>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vxo22_reg: ldo_vxo22 {
+				regulator-name = "ldo_vxo22";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <110>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vaud22_reg: ldo_vaud22 {
+				regulator-name = "ldo_vaud22";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vcama_reg: ldo_vcama {
+				regulator-name = "ldo_vcama";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vaud28_reg: ldo_vaud28 {
+				regulator-name = "ldo_vaud28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vadc18_reg: ldo_vadc18 {
+				regulator-name = "ldo_vadc18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vcn35_reg: ldo_vcn35 {
+				regulator-name = "ldo_vcn35";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vio28_reg: ldo_vio28 {
+				regulator-name = "ldo_vio28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vusb_reg: ldo_vusb {
+				regulator-name = "ldo_vusb";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vmc_reg: ldo_vmc {
+				regulator-name = "ldo_vmc";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-boot-on;
+			};
+
+			mt6392_vmch_reg: ldo_vmch {
+				regulator-name = "ldo_vmch";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-boot-on;
+			};
+
+			mt6392_vemc3v3_reg: ldo_vemc3v3 {
+				regulator-name = "ldo_vemc3v3";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-boot-on;
+			};
+
+			mt6392_vgp1_reg: ldo_vgp1 {
+				regulator-name = "ldo_vgp1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vgp2_reg: ldo_vgp2 {
+				regulator-name = "ldo_vgp2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vcn18_reg: ldo_vcn18 {
+				regulator-name = "ldo_vcn18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vcamaf_reg: ldo_vcamaf {
+				regulator-name = "ldo_vcamaf";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vm_reg: ldo_vm {
+				regulator-name = "ldo_vm";
+				regulator-min-microvolt = <1240000>;
+				regulator-max-microvolt = <1390000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vio18_reg: ldo_vio18 {
+				regulator-name = "ldo_vio18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vcamd_reg: ldo_vcamd {
+				regulator-name = "ldo_vcamd";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vcamio_reg: ldo_vcamio {
+				regulator-name = "ldo_vcamio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vm25_reg: ldo_vm25 {
+				regulator-name = "ldo_vm25";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vefuse_reg: ldo_vefuse {
+				regulator-name = "ldo_vefuse";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+		};
+	};
+};
-- 
2.20.1

