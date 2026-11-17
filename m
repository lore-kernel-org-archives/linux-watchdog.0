Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906581;
	b=xuSPz/SnL6KFO3c19qd0WtWr9q6hJFPKAgfXEoZfQYA4DJM5No9JWeyiSaOgJmGK87id
	 AHUGU47AmZVPc0YjPb5DFS4lU3nHaCrM7IOrsCjZjbAPxOdjikxxzHNLK/2gFXP4Es+vD
	 nfOZLwgaL6o7xhC3h4Ks2zIbtdHlgSCVe7ogQn9pULTB/QHStbc+dodNWYL6o2OgcE3no
	 5AY6An6gg1YS7HfUCik5s5ESgt3DRY4lXVPAVr1p4hsC3Lsi3nziAvsLcaD7xMvmxzS5j
	 k9JBwHWwh1GERkaOSFkl8RQu3XHzOIFnZUVeDoBOIaHpnteJ/GHBtBh4HU/vo8CPkjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906581;
	h=DMARC-Filter:DKIM-Signature:Subject:Message-Id:In-Reply-To:X-Mailer:
	 X-Lms-Return-Path:From:Date:Mime-Version:Received:References:
	 Content-Type:To:X-Original-From:Cc:Content-Transfer-Encoding;
	bh=VMdenQr9IZWAxshzwA9HVckJqtXVvhwVQuGES233IgU=;
	b=dR9hQm/iZFvklWsFaCDe9FbtJxtheFqndNCHDpLECxX7HIHm9LQ2hBu4KLS6VRQGCGNb
	 DdFydAC9NOKfyWr9ciW0eq7QEwVCY+nWfg5734vJ52Hd07gVc2UeXLMYHresEByrtkszb
	 3cSue1GmCVnwPeR51TgIh1Ft2NdSlHWFsu0INM2C1TG4qxAckX3fJkm3Bla0jdXvcuYd+
	 46t5X30/67SyStTTKjypezqpzKrcxwhls3WjcTD34Iwy0R+NmjkaCYu7evpZm9OQllCdk
	 uGtjc4GDoaxjlUXRFZ3vjTfQnAlblSgjUG2qJnfseIObt9rIRcUc8GdhF1DHN23bfAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=HwNwBAJI;
	arc=none smtp.remote-ip=209.127.231.46
Received: from va-2-46.ptr.blmpb.com (va-2-46.ptr.blmpb.com [209.127.231.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26A606A338
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 09:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F26A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=HwNwBAJI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794906576;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=VMdenQr9IZWAxshzwA9HVckJqtXVvhwVQuGES233IgU=;
 b=HwNwBAJIjyjZ/QvXabymwxuFho8rZAyFHxfvQvoSIzrINpyQLU0BJqbATsvty02sMDnJIt
 05lxT8L8GGNmT/VDxrNwaMNRYfY4XslkVhhdIvdwho940D08yzctxlGGu/hXyplF4Xy1+t
 YrTIXzdcn0++WC0hWCeW/qlObAC8gwl2OAc9YtgutA4S1hgV0JhkVBP/5zIZQIkJV/kifB
 ocwiVUsZuDvu2SQY1GclbWj67fKzYAuDwHxPmVB3ZM6yeV3f3a2Vk5Wo54Iteamg3fKYOI
 OcTxwYPRthGV85zrF8l6ZoeYHBWdrI7V+D1vtpFM49VkG7M+CH2b88lT56slrA==
Subject: [PATCH v3 1/7] MIPS: Loongson64: env: Don't warn if UART has clocks node when fixing up FDT
Message-Id: <20261117-mips-ls7a-wdt-v3-1-2e88f7e1d6c5@oss.cipunited.com>
In-Reply-To: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
X-Mailer: b4 0.17-dev-ce4c1
X-Lms-Return-Path: <lba+26afc19ce+401032+vger.kernel.org+rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Date: Tue, 17 Nov 2026 17:06:43 +0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Tue, 17 Nov 2026 17:09:33 +0800
References: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
Content-Transfer-Encoding: 7bit

A UART with clocks node cannot (and doesn't need to) be fixed up.

The fixup is solely for the case in which the UART use a dedicated clock
source on board (say, a crystal oscillator). IOW, when a UART has a
valid clocks node, it should use an internal clock source that is either
nonconfigurable by the board manufacturer, or retrievable by software.

When fixing up FDT using UART information from LEFI, don't warn if a
UART has a valid clocks node.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
Currently no Loongson64 platform has such UART nodes, so this is not a
fix. Later changes will convert some nodes and depends on this.
---
 arch/mips/loongson64/env.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
index 7abcca7ab4ed..8135d50c777e 100644
--- a/arch/mips/loongson64/env.c
+++ b/arch/mips/loongson64/env.c
@@ -73,6 +73,12 @@ static int __init lefi_fixup_fdt_serial(void *fdt, u64 uart_addr, u32 uart_clk)
 		if (!reg || len <= 8 || fdt64_ld(reg) != uart_addr)
 			continue;
 
+		if (fdt_getprop(fdt, node, "clocks", &len) && len >= 4) {
+			/* The UART cannot (and doesn't need to) be fixed up. */
+			pr_devel("UART 0x%llx has clocks property\n", uart_addr);
+			return 0;
+		}
+
 		clk = fdt_getprop_w(fdt, node, "clock-frequency", &len);
 		if (!clk) {
 			pr_warn("UART 0x%llx misses clock-frequency property\n",

-- 
2.55.0
