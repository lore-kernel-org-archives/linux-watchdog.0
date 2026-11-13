Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567100;
	b=pBCFPOhbhch1SSDEYacYnJzsu+TyIJZqT431wCJyIzAuoVjen3XpVrARjmiSg4enCvqn
	 Wzi7NGU4XmfXTmJKW4COSLMa3AcENv5EXmRSMfxzvq1+M7yC9YTLCOIhmSIlIF2MZchLz
	 jgtXVh1uDhCcZf3370Jae/OWjqZXq6HRCOYfXt3mInummS5faTrkBlwhjf7f0Ji3G3Rw/
	 UwoiI7Gj/Ho0sXZoMRy104p7kkew3HhSI7r1DOR3HrpSPRe63GSANhhfij3UPGXkhv56S
	 P+nOp0ClCX2LwqcOzUpJj7ockDmsS23XLgPdnQg8FVtg0qlTNDd2cNxudkMpE37sgcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567100;
	h=DMARC-Filter:DKIM-Signature:X-Original-From:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding:References:To:Subject:Date:
	 Message-Id:In-Reply-To:Received:Cc:From:X-Lms-Return-Path;
	bh=Q08JydL98fy47nVJqLqGFTrZaaBqSEW743Jy2fzuf48=;
	b=5XStrnqJS6KHOasiQ+Nni+0NKWNUt1q/HMw+hOGfvWMbq9w69JeOOKKn75bu0MmUzHyy
	 Vid8t12bJG1n8cORNPLtoWpQc5IpODt7JX85bPCyr7z9CfIv1kQMGsaVhtLPQYv7grepg
	 YB8E2r0xvoQ/K7HKhX3LMuebcTBzLEre8BSht+axQ9Di9BVlS5IDDtUeFN/gq4CYnCM6/
	 Vurd/99HsDxiYpO0doYsUFbtEmEvPKG5TzHd75plp3sOQPFbgV3EEmOdnR5/Df1qDVMhW
	 ORaR7l9OrlIYB9vu8F4t6tvZGnHH0Ta7rF7AlFPH6xm5u+nPorx6Y6rrM2ceRW8ri6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=NBvXPIJe;
	arc=none smtp.remote-ip=209.127.231.19
Received: from va-2-19.ptr.blmpb.com (va-2-19.ptr.blmpb.com [209.127.231.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1B606B241
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 10:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B1B606B241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=NBvXPIJe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794567096;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Q08JydL98fy47nVJqLqGFTrZaaBqSEW743Jy2fzuf48=;
 b=NBvXPIJeAwsGVemlL+AyS/y5rVYY/U/aRagK6dtGNGt02kxhPff+0Lpp79J/g1Z/zB9HYn
 oVHYzkSNTnOHX6iYyx/lE9kmJOELjxh8SGTkTmZXICpaQ+weqPgNypaXFS3lxwbfYY1cq8
 2Yvcld6xaeeGDKubOif1zGpiLCXEan0xgIKTwSfbNOeIMWFGloV32Ahz4qe+AlsVRdzCA1
 v+hjZG9oyaI6XfLdd1whVW0DT16TuSelWz2yq/nEyMJPOzgYLNVNiisBaveqdvMkccKii9
 /AOtpTrzOlQr4E9guMiQbfnXTTAWWdKZEZgP10EJBx7pW+s/Ub6HDg36lg8xmA==
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: b4 0.17-dev-ce4c1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH v2 7/8] MIPS: Loongson64: dts: ls7a-pch: Add watchdog node
Date: Fri, 13 Nov 2026 18:51:14 +0800
Message-Id: <20261113-mips-ls7a-wdt-v2-7-e8abd6b2f77c@oss.cipunited.com>
In-Reply-To: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Fri, 13 Nov 2026 18:51:33 +0800
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
X-Lms-Return-Path: <lba+26af6ebb6+66998e+vger.kernel.org+rongrong@oss.cipunited.com>

The Loongson-7A has a watchdog compatible with the one on Loongson
2K0300.

Add a watchdog node with appropriate compatible strings to wire it up.

Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 7ba7bbb9c013..498abf1f9a85 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -75,6 +75,12 @@ ls7a_uart3: serial@10080300 {
 			no-loopback-test;
 		};
 
+		watchdog: watchdog@100d0030 {
+			compatible = "loongson,ls7a-wdt", "loongson,ls2k0300-wdt";
+			reg = <0x0 0x100d0030 0x0 0xc>;
+			clocks = <&pch_misc_clk>;
+		};
+
 		rtc0: rtc@100d0100 {
 			compatible = "loongson,ls7a-rtc";
 			reg = <0x0 0x100d0100 0x0 0x78>;

-- 
2.55.0
