Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567095;
	b=l2DJ1h5L99b9m9ihh6D0yUgZtdsrIyobcU9hOjwZP4jGVYIqz9AiWR/uYfx9BstDhBH2
	 nu/jO6naJ9rkB6U5/QnpGBna+8H/pjHPJfRIJJ2lNYh0di/pLDFJldfkwp+zLhFhDzaHm
	 OMAynF/NZYe7lAzyzNAttVqij3Jgay4BlTV4nnRoCWzxwTXkmKfWdxLBjvWJ2P1PVyL0s
	 hnIoe+HRqKHC8aKymwtCigc9xV7Phtf5oYkuRLOnZPdD1cv3wo9kb7UBM5XFyabmAIOE2
	 r+65OQEd6X2gxvPjY9J6cQHaXB2idv1wHbodYzkr3PvyTHB0YCXst8y0XuJqQQEtq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567095;
	h=DMARC-Filter:DKIM-Signature:Cc:Content-Type:References:From:Subject:
	 Date:X-Mailer:Content-Transfer-Encoding:Received:To:Mime-Version:
	 Message-Id:X-Lms-Return-Path:In-Reply-To:X-Original-From;
	bh=UtQIaEnaYQpscdnv8kS89CFZoPvgwXTwxpgQLK+sMwE=;
	b=ldbYeB71RABvg2hP99Sq38K4u76ztwIeeIp5EqFlzCtV9/CbB6zo6f8LcIKMgJqLn8m+
	 He/mQS+essU5sItFZ2OVE0S6qs+k74DtRYP2aSHrvQ054Ns+rVk6pxpJ8eMMMZ7Y7hDLl
	 Yrz749RBdlvdwv64t6I4dVns44zXOjiNDMkkKzGOmc8Mc5nnw2pzPSSDFGys/otHW1Hr4
	 EQVkSu+nE/bWpWGL1OK/M/Ar40OQi0ZkpJFcGmAce6LZbU3Bl8yxTVZgh8saN3NRsPB2z
	 U/UkXECQWO2efMhsQOFEyA90ROeXQJPZO+dTaHG3IvfKm8RGnbnVg1HqzsnEixpnLIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=wq5o6kpp;
	arc=none smtp.remote-ip=209.127.231.54
Received: from va-2-54.ptr.blmpb.com (va-2-54.ptr.blmpb.com [209.127.231.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4460A6F73
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 10:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF4460A6F73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=wq5o6kpp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794567093;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=UtQIaEnaYQpscdnv8kS89CFZoPvgwXTwxpgQLK+sMwE=;
 b=wq5o6kppN/DEShGvLEG8ZkNvm2J2tcrycGxOV+6Zrof8tsPiMaK1JuJJiGeBsVuJp21PGE
 iW6yjoeU+CCrztZgNINJupzMuMhfCGDxHMUIHlggu0awwJGDoiYxrt0Oj+B+DWJeRhzoez
 SzuyJx/kYjMAbD1/7AnBFlwMuH9N4ApIbZ/p4gWtHnLvmIoOJQKJxgminIUuWqErgXEbiW
 1fmO/yC5CtnbJEh1Lp5ED92vOTDDkg3AhT6eOdWO5KQJEJe+KxLrZXic14e8XLV8Ot304b
 Hq8s4MmiOJ2qFNTcoHpSq3zv21qJ9ZeonBBYBZpNkvLbF0monwbaw5f/n3JtdQ==
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH v2 1/8] dt-bindings: watchdog: loongson,ls1x-wdt: Add compatible for Loongson-7A
Date: Fri, 13 Nov 2026 18:51:08 +0800
X-Mailer: b4 0.17-dev-ce4c1
Content-Transfer-Encoding: 7bit
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Fri, 13 Nov 2026 18:51:18 +0800
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Message-Id: <20261113-mips-ls7a-wdt-v2-1-e8abd6b2f77c@oss.cipunited.com>
X-Lms-Return-Path: <lba+26af6eba7+92ad88+vger.kernel.org+rongrong@oss.cipunited.com>
In-Reply-To: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>

The Loongson-7A has a watchdog compatible with the one on Loongson
2K0300.

Add "loongson,ls7a-wdt" compatible.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 .../devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml     | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
index 50a9b468c4a3..dbfe9795c835 100644
--- a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
@@ -14,10 +14,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - loongson,ls1b-wdt
-      - loongson,ls1c-wdt
-      - loongson,ls2k0300-wdt
+    oneOf:
+      - enum:
+          - loongson,ls1b-wdt
+          - loongson,ls1c-wdt
+          - loongson,ls2k0300-wdt
+      - items:
+          - enum:
+              - loongson,ls7a-wdt
+          - const: loongson,ls2k0300-wdt
 
   reg:
     maxItems: 1

-- 
2.55.0
