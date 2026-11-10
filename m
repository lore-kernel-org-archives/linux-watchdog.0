Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294178;
	b=eC6yiiDp/12Rx7ajwE0MIVPxQjybfOtq77t907+KotvZXckMvSOLrssBN85ptwqbaf2G
	 JyspALeyqwCoooLH+0bJOqM1ppjce34Q0RVK9i5dTplU/i6XMLMa3cQ4wmGKBtYAMGXW2
	 XfPg2iAcXZmPuKgR7e36dAQtkUROVcFQCNJUmQEsB755+zsTnntw2Ph0wpg/PeHHHmbmO
	 H7bR24fXgHQRLq09HF8bN3ABNbwp6TaIudY+r7RDzOggsFrerLm3FuVf8DjM94hH/sTy+
	 9kebrelMOn+AS/GKb4Z0lNoF1c9z+OUV3wd7jeHiFyeS4IxE/4cpELXI+iLsNfdU5uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294178;
	h=DMARC-Filter:DKIM-Signature:From:Mime-Version:
	 Content-Transfer-Encoding:X-Lms-Return-Path:X-Original-From:Cc:
	 X-Mailer:Content-Type:Received:References:Message-Id:In-Reply-To:To:
	 Date:Subject;
	bh=Jan7Tp683d84kVHecx+gnP5xVm5QZk5klZ/ivxPkH/8=;
	b=KYJBYfW1KEmIzvxOMgQxp20+RCiL7LK/Zi6FZhhSxIuA1lO64phkKKPUOTXeZYsqQQmZ
	 pdCkGAMMA+F6htZggDPwSGOWCL5dyDiL1D8z0trsNgmGbveKCjTvincYgg0CN6jittjGx
	 5uUlgqTDf5brySSZ/wncgkEvcCG+nO1AJ3l/iSEA0WtwFfq1aD2O5sHvaOP80u9Onae4K
	 Y6WuKOmYIVUAWYmx/EdWPLugUVu2pi7EUQG3aD6twkIJ/XatAmHt2WxuzyPC44i0OSNRF
	 kzeIUu8DS3bvzvJAeRO1aDbSsQCQb22nDV9BuGCxsbcEFABecUeyN6dvuZsSYuSD1Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=IGe4mVvf;
	arc=none smtp.remote-ip=209.127.231.47
Received: from va-2-47.ptr.blmpb.com (va-2-47.ptr.blmpb.com [209.127.231.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107FE606A331
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 07:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 107FE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=IGe4mVvf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794294172;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Jan7Tp683d84kVHecx+gnP5xVm5QZk5klZ/ivxPkH/8=;
 b=IGe4mVvf3plmoX3d+tq5smr5oVhXHjNT2VKBHi5c+snS09Vn+kH0wXZwiYERpr6Vt2N8Kz
 WNKLt/J8FPw7AuySfSv+xEVpoYFi2pSwpv8OgXlrY1hgUpP7R5GNQJZ/58cvX+lHbQ+XL2
 iGHEiUAFWs0YU7fbsltYn5W7DtXUfbJnpwfqUZnccn2L+kdQJ/OqbaU+UKJHTtCbtGMebu
 YNw9bNGo6xVt7gC5e17J5IC4Zazb3g57xmDlBqndwz5mKUOCFxr/hS/NWV5RrgSU2C3iJ3
 A/I0xJJSfyve+YVGPf0IjYdwMspKVpaywy5MoqciXzZZqeEX5AdrJNFvHDaDXA==
From: "Rong Zhang" <rongrong@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26af2c19a+47c59e+vger.kernel.org+rongrong@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
X-Mailer: b4 0.17-dev-ce4c1
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.1.1] ([1.192.71.23]) by smtp.feishu.cn with ESMTPS; Tue, 10 Nov 2026 15:02:49 +0800
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
Message-Id: <20261110-mips-ls7a-wdt-v1-1-968bb85122e6@oss.cipunited.com>
In-Reply-To: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Date: Tue, 10 Nov 2026 15:02:30 +0800
Subject: [PATCH 1/4] dt-bindings: watchdog: loongson,ls1x-wdt: Add ls7a-wdt compatible

The Loongson-7A has a watchdog, which is similar to Loongson 2K0300,
except that it has no clock controller.

Add "loongson,ls7a-wdt" compatible as well as a conditionally required
field clock-frequency.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 .../bindings/watchdog/loongson,ls1x-wdt.yaml       | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
index 50a9b468c4a3..cb93e9578f82 100644
--- a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
@@ -18,6 +18,7 @@ properties:
       - loongson,ls1b-wdt
       - loongson,ls1c-wdt
       - loongson,ls2k0300-wdt
+      - loongson,ls7a-wdt
 
   reg:
     maxItems: 1
@@ -25,13 +26,34 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-frequency:
+    description: Frequency of clock in Hz
+
 required:
   - compatible
   - reg
-  - clocks
 
 unevaluatedProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - loongson,ls7a-wdt
+
+then:
+  properties:
+    clocks: false
+  required:
+    - clock-frequency
+
+else:
+  properties:
+    clock-frequency: false
+  required:
+    - clocks
+
 examples:
   - |
     #include <dt-bindings/clock/loongson,ls1x-clk.h>
@@ -41,3 +63,10 @@ examples:
 
         clocks = <&clkc LS1X_CLKID_APB>;
     };
+
+  - |
+    watchdog@100d0030 {
+        compatible = "loongson,ls7a-wdt";
+        reg = <0x100d0030 0xc>;
+        clock-frequency = <50000000>;
+    };

-- 
2.55.0
