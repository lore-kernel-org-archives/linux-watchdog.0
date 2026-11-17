Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906590;
	b=amjaPHdPaoUCWoiBI/2E9vyCp1+8wHdxy1pqmFzBX9Gwq6sOnDb+309yEY8v2ViDN/Ty
	 6BMFWOd7VtvgRBOP+CzbvZhk0UE+Ie6DZim+joT4+TIU+Hq2ka/7GtFFetpIOrkScJMwa
	 ZwOxNZ1M4R2p+C61Id/i1rzS152PAUAnyVsrFkodVNr/5MuP3D84L/Q2I69e0e1K9JKu+
	 T4jrV9g8GIIdP6Ypt8fOrAEas0BTWo13DDWa3+oPi934DGO6QMlNYlETg1tbB2YzOc/OW
	 ueAsgcYpgB7PN95j9VWegA3TOJVOZ0mv/Smkfh+MSEQELMthWuIOb5MyRQ5z+PssaYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906590;
	h=DMARC-Filter:DKIM-Signature:X-Mailer:Cc:References:Content-Type:
	 X-Lms-Return-Path:Message-Id:Mime-Version:Received:
	 Content-Transfer-Encoding:In-Reply-To:X-Original-From:To:From:Subject:
	 Date;
	bh=6Fr7Nif/RrgbPDD+oeDfm08C6n1g5Vog0G6eGmKtGjk=;
	b=y3SLGsLr9/CU8zUNrRCLHMMqRk0kGnz/Qgmlqy56wgIvrTM8YVUD0x5lxFvY6bETo9mR
	 +0N3m+cURHqw/5oewOXV+vJWVBqwkWJ8S7QimC+JRPFz+uJ2HCMFNHipuP1Lnz+PoTx6D
	 uqQap5kdJy6Fm97GcOQvqvPsV/WXMTqvGNMVXgcLeF589PzmrvEGbiNMMi7hrLzaHWHoX
	 QQFoVSU4Rlemp0/eLHO5fgCh6bHTD9OmEwsGPYxFMvjm5vl0ZrABJ7d45gbBGG7zkirXV
	 Cfx/ap6hN1pq/HtIazGvkzvaxqgZ5cpJqWAU2xCvcUZPxZuf2s/Jtv3r2KtCVT6TBKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=FQueUq4+;
	arc=none smtp.remote-ip=209.127.231.60
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E19606A32A
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 09:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3E19606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=FQueUq4+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794906583;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=6Fr7Nif/RrgbPDD+oeDfm08C6n1g5Vog0G6eGmKtGjk=;
 b=FQueUq4+LjRRX6piGp7CLZj0iheSgDjfUHfvx+Q66em2NrQKuJhMdI6k6PlFgtC4PHzE2k
 bhk9oeSW9muCGIE31gBs9sJ9Md15PbFjN3d5HtQPRS6o1ZSCPRIH5sVCvnP24J5QIUHfmR
 uM+0Uj5FvV87giEgxhymuM4lH4lEPR0pMuFTMGC6vcg8mEH0aFz8DxXTSC8kaTFYmv3pVS
 yqKbmyMsGseT2Sx5RPulJRdOahWcTyqzJANL9pKZDV/4mqheY4U7he1WISzohyXa6QH50f
 7UJ9VSSJSf1jQUQg7rjyNfoamq2ew+lTsqdDANeyTyx1AOGTm0fQhpw3m+lN9g==
X-Mailer: b4 0.17-dev-ce4c1
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
References: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26afc19d6+2a2a5b+vger.kernel.org+rongrong@oss.cipunited.com>
Message-Id: <20261117-mips-ls7a-wdt-v3-4-2e88f7e1d6c5@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Tue, 17 Nov 2026 17:09:40 +0800
Content-Transfer-Encoding: 7bit
In-Reply-To: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH v3 4/7] MIPS: Loongson64: dts: ls7a-pch: Add miscellaneous clock node
Date: Tue, 17 Nov 2026 17:06:46 +0800

The Loongson-7A has an internal clock source for miscellaneous
peripherals. The clock source is nonconfigurable and has a fixed 50MHz
clock frequency.

Add a 50MHz fixed-clock node with label "pch_misc_clk" to represent it.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 1a0484fa2a96..bd191336f14d 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -1,6 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 / {
+	pch_misc_clk: clock-50000000 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <50000000>;
+	};
+
 	pch: bus@10000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;

-- 
2.55.0
