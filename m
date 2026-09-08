Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1285592F9;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904774; cv=none; b=Ncq9La/h9rKmMIki26ORHMzkVnR+cE968RmjeMwPqt0r1n2/IEMQ2Ydmm/JE6ekzG2DxwzBlloUyIq/TmFfVqPv+hf81cnljW981d9gSfolUeUhqfOpQhEQKbt/o2H4wXAU2y+0lI4xA6tIbUxisZWtxKEFgcPlCpAALZhK7xcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904774; c=relaxed/simple;
	bh=TnJuU/G+pPzR1r6gAw4rnxQjGidY1l8CEBue/kWOZNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpXAR5n/4y7cPdAT1F9UaspK/6JY8tFybtyIUD7pEQGAPEGzPBQkPmZnp0C9OFTkhStxaRdejSlAdIEqL3ybOSZWuvlC4bOweXtorV+MSPfEurQkw8XlFpv5Kro81E6eVTIbYNG1bhWtIZNTSUaHPxD5MP0v6t+PZGP1QifgGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTWRJzcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTWRJzcn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F7EAC2BD04;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788904774;
	bh=TnJuU/G+pPzR1r6gAw4rnxQjGidY1l8CEBue/kWOZNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DTWRJzcnx6uPKo+E71jgsUIR5lrRghyEji9vSEdxDseaeVth6JMM891YCLaBWb8w7
	 tdv2a1tG7IbCjoFU8IbIw5rLgQdO6Gt6cEriN1P80dGwa9JETqTk4Qqbpham0HTRM9
	 nd9DQh55rUh/35YoK+CRgui1OPPEe2Vt2mVte5Y5HwbS6EmRq8kxhbs3nsJmWI95lA
	 bnjQ5iJ3vYByHJmwbG2wCNY4WwPGar1f8eRsZbgA98Zn4BNuODmcpjtgOTkqyYy0cX
	 gbwMrS+bZ7qdKMC0B9fIkwkUpJ7i/JfMY9Rcku0SKPMsTs4KAx34+rQt8/FkaDwGs+
	 Qa9QEnR1DqXhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB4AC79F82;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Tue, 08 Sep 2026 23:59:17 +0200
Subject: [PATCH v3 4/4] ARM: dts: mediatek: Add basic support for Amazon
 ford board
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-mt8127-amazon-ford-basic-v3-4-fc46bf1b6cb2@mailbox.org>
References: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
In-Reply-To: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, zkh1@proton.me, 
 Zakariya Hadrami <zkh@mailbox.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788904772; l=1964;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=mH+RVCbNQiXc4pzHa+I2w0AccDFDili0JE4n4Bjs7WE=;
 b=0Xm4ZYbH5j5aBs3EKq81URUK3ypNPuT7zJEo1ytzmWoXQtj4T7A51a/DR/CLrF7USbJ1CDY08
 IdE3fos09sPADyIAzY5P45tdgp+J0gWTP4uTqkxuzRVOekyHNTNKKQo
X-Developer-Key: i=zkh@mailbox.org; a=ed25519;
 pk=up24Xn4ScFKugfT4EJru/UQAS7JOIN+DSQqro+a05T4=
X-Endpoint-Received: by B4 Relay for zkh@mailbox.org/20260908 with
 auth_id=1015
X-Original-From: Zakariya Hadrami <zkh@mailbox.org>
Reply-To: zkh@mailbox.org

From: Zakariya Hadrami <zkh@mailbox.org>

This tablet uses a MediaTek MT8127 system-on-chip with 1GB of RAM.
It can currently boot into initramfs with a working UART and
Simple Framebuffer using already initialized panel by the bootloader.

Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>
---
 arch/arm/boot/dts/mediatek/Makefile               |  1 +
 arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts | 46 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/Makefile b/arch/arm/boot/dts/mediatek/Makefile
index 37c4cded0eae..a610bc75c7d9 100644
--- a/arch/arm/boot/dts/mediatek/Makefile
+++ b/arch/arm/boot/dts/mediatek/Makefile
@@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7623n-rfb-emmc.dtb \
 	mt7623n-bananapi-bpi-r2.dtb \
 	mt7629-rfb.dtb \
+	mt8127-amazon-ford.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
diff --git a/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
new file mode 100644
index 000000000000..21bdab0e43f8
--- /dev/null
+++ b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+#include "mt8127.dtsi"
+
+/ {
+	model = "MediaTek MT8127 Amazon Ford";
+	compatible = "amazon,ford", "mediatek,mt8127";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+
+		framebuffer0: framebuffer@b7a00000 {
+			compatible = "simple-framebuffer";
+			memory-region = <&framebuffer_reserved>;
+			width = <1024>;
+			height = <600>;
+			stride = <(1024 * 2)>;
+			format = "r5g6b5";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+
+	reserved-memory {
+		framebuffer_reserved: framebuffer@b7a00000 {
+			reg = <0 0xb7a00000 0 0x1000000>;
+			no-map;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};

-- 
2.54.0


