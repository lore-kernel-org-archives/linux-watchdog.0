Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906591;
	b=QOaGsyOTiEnrFP9/KH3tsJUGhAtya+lWDU+pjyj5OIFmNz4kCgIDwbOKSGgAqOhX86pN
	 XPk9DQv1pCLyaaH5tFEgk3ubL0pZCfsvVFjyTlqKsJmD3vqoPOPi80bEltBXUnC1m3fC8
	 MMX9FTeN/hXmlZ6xnD+9FFzdJA4PQUOaRFLKtskxp/YGdTBOsZF9GiZLthS4NB+jLc1hq
	 viqieQsUHnJPUXKPUPGzkLw4ITW9FUswOzQR3hGE6lgW/0GdGrYzA9qvxd8eLw6t7aeWT
	 JMJ6aybaaa7WmeUdmcZtQEOOmqP4dmoOoY4/f5bmbKp8tI4Ks0IpWUvnMgLjAMXi3gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906591;
	h=DMARC-Filter:DKIM-Signature:X-Lms-Return-Path:Content-Type:X-Mailer:
	 Cc:Message-Id:Mime-Version:Received:From:X-Original-From:In-Reply-To:
	 References:Subject:Date:Content-Transfer-Encoding:To;
	bh=haS4pNMIbV0FeZB0f+udav1mKC4zCxBB23/t2ZQ+5w0=;
	b=U4mgmXAIcr/QkvykufghtnufviTN8Yh2mkcZUYW65iedvpIaROddUlhh43wf2KqhRvEK
	 iDs3aUmHuim+MIhBWVPTZWxe2IL9rCH1P3RoJ81Dt1sH5t9MnOEaN5mm1LAUjL49Uzm+i
	 nNUreHlpFsTyo2CIu/mkqT+xrhLSqU31crqeQwZi3BgKql9YGNV2ngGb0N6dzOfddHWNS
	 kcUFSJJYPne/zD41lkXWsL1iGq6uzcXBVV7Ri/K5ypKS9pqDe9sW0s2EODYTRC8xo4C+x
	 oY8i7SdAoyHSIJJS4bf+7quVuOYLg7FULwB9hVf7LDJg/r9RD0O8EGPT1taZhCxhVLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=FX0OETr3;
	arc=none smtp.remote-ip=209.127.231.51
Received: from va-2-51.ptr.blmpb.com (va-2-51.ptr.blmpb.com [209.127.231.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF565606A335
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 09:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF565606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=FX0OETr3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794906579;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=haS4pNMIbV0FeZB0f+udav1mKC4zCxBB23/t2ZQ+5w0=;
 b=FX0OETr3XLsEdqYoXgAz1p68lcgCG0UwUeruNWv66FhPtY1QuQMGodg4D3iaxyrCVRivwL
 TKCrAjMx4C4s+fgaqGlnBW+GfXAY3P8uYY+2OHkHJGKS03gM38isGQCogqJXWV+jw8TFqz
 2Irab8Y0rC0r703QZSXZrTEUw6mN+U8feIFbWXDIHYqf3a2j+fA8Dej3SwSP7BgwQwxIto
 IByIHC9+/agJ5+uZyJ3oIqjPuajYaILSxsXO964rLmhtz0Z0rBzwNhltRk4P2I+WbZuEqw
 kHK9NKMLOBt+HuBm+31me5YiuExtVqr0fhvox6a/8aJwnGSrB568v6pdmOJEGA==
X-Lms-Return-Path: <lba+26afc19d1+0dceee+vger.kernel.org+rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: b4 0.17-dev-ce4c1
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
Message-Id: <20261117-mips-ls7a-wdt-v3-2-2e88f7e1d6c5@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Tue, 17 Nov 2026 17:09:36 +0800
From: "Rong Zhang" <rongrong@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
In-Reply-To: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
References: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
Subject: [PATCH v3 2/7] MIPS: Loongson64: dts: ls7a-pch: Add missing #address-cells to pic node
Date: Tue, 17 Nov 2026 17:06:44 +0800
Content-Transfer-Encoding: 7bit
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>

The pic node of Loongson-7A lacks an #address-cells property, causing a
lot of dtc warnings about them falling back to 0.

Add the missing #address-cells = <0> property.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
This series will modify ls7a-pch.dtsi here and there, so I fix the
pre-existing warnings to make me more comfortable.
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index f304f99946f1..71d4c882d3f6 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -17,6 +17,7 @@ pic: interrupt-controller@10000000 {
 			interrupt-parent = <&htvec>;
 			loongson,pic-base-vec = <0>;
 			#interrupt-cells = <2>;
+			#address-cells = <0>;
 		};
 
 		lpc: interrupt-controller@10002000 {

-- 
2.55.0
