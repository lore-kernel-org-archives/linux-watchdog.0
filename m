Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567104;
	b=HUTqekiOmqKg0LT3aCOQxOtjU33b32Rz1CoIZDyVc/7b2qa4ZhXWAQgbaD+Vr4WKcusG
	 +uHGdtY8sLhr7f3bfi5aLBZzWi1D0qdOFapSaTm6WuM9izj1vEawyy/IuwEjcputLz9A0
	 0XKrSYijzRpZ9IAi+s2CDDlEC/RoLGTKHlmVEhgmyFmwHP1MIGDi8JEoZYRrdHna/Iq+M
	 kEYoa2/FjDQfplaDA+RgQSX01OZn1lph+1wIq+FaFo8PlZ2ZdqKj4e7sMb+YN2g56Dsnx
	 KJwdE1f5bKwjFgGE2djoBbojope0H2ZVPquuP9xmSjpMUPyq7IEWk4LKi9LOcIgBuWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567104;
	h=DMARC-Filter:DKIM-Signature:To:Cc:From:Subject:Date:
	 Content-Transfer-Encoding:In-Reply-To:Message-Id:Mime-Version:
	 X-Mailer:X-Lms-Return-Path:References:Content-Type:X-Original-From:
	 Received;
	bh=PvWgb9sB0gJNLtO8374oDyk5f8yiTyQ7HhcAVQ4G2sk=;
	b=biBZpgv4UyorMMr4socBfH34+pysnvh+Wy20GrFnMXjPWpLMUf0DpSJknvNZgmkfQRlK
	 gGiOyoIJJffhZeSXEU1xqJaxTU78nRqt6z8mo86mg33EMRpzWUhBucM5d5+BsxgisOr00
	 P1YsnPBMTwMK/4CXT+EHir6X5PtVqsa1dpBFjSffKKQ5+bd9Cpj5ZXy7ZOwwYLn72kIQt
	 upB2mYRvFhprePEVYW5VFMkZ+emzxrr5gXP3I12T0JtOJZyKiCtwXYFsq4eaUJ53I0Scm
	 cckzX/GmyhyDQRExUkHD0EbjFnFMdXn1lMgmoTfcQE8msiNkBOM3xmsjdkmB34RpEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=FNASwYY8;
	arc=none smtp.remote-ip=209.127.231.41
Received: from va-2-41.ptr.blmpb.com (va-2-41.ptr.blmpb.com [209.127.231.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595CA606BD8F
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 10:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 595CA606BD8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=FNASwYY8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794567101;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=PvWgb9sB0gJNLtO8374oDyk5f8yiTyQ7HhcAVQ4G2sk=;
 b=FNASwYY8pivaxKNx7kDdle/d5sdKGdwI1kpR5rY1Ag+QT9zbtZNiiJmdst0Fk4xe9LjG2V
 vYViA3fyfccJXUZAr14l4cTafbeMVzKEb2DdSEss0tr5XLBZOjhM7G0Orw7tCjqF9alTQk
 YRu+jQwN6QaUjTz42Wx9CQ/CLDKVvojAB6CviEGmuUUVBjr0+wy68g87urO9ox/DTSS+Lu
 XunGoafc3pYMyOOzSk3cHP/DbhCJJGiXt/i8v7uOANm4LONq8KjanP2Pe4TKG5P0vmlyXM
 rl63+y5NbG0E1o7o3FCko29ExGo2pP3XCfaDf2l28SHWBziSetG4FrWVqPBmFQ==
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH v2 5/8] MIPS: Loongson64: dts: ls7a-pch: Add miscellaneous clock node
Date: Fri, 13 Nov 2026 18:51:12 +0800
Content-Transfer-Encoding: 7bit
In-Reply-To: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
Message-Id: <20261113-mips-ls7a-wdt-v2-5-e8abd6b2f77c@oss.cipunited.com>
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
X-Lms-Return-Path: <lba+26af6ebb0+58033b+vger.kernel.org+rongrong@oss.cipunited.com>
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Fri, 13 Nov 2026 18:51:28 +0800

The Loongson-7A has an internal clock source for miscellaneous
peripherals. The clock source is nonconfigurable and has a fixed 50MHz
clock frequency.

Add a 50MHz fixed-clock node with label "pch_misc_clk" to represent it.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 9f0a183bd348..2ef1ad10a8ec 100644
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
