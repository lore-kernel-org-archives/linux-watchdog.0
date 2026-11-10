Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294181;
	b=29BYGy6D5H+uwA/ZFijSwFoh7IGVmzgG2sBoAcPPjLIFmeXrYyqepr3vmRS1N+Q5GBlH
	 gqSpF5PP2MeZQ+VeCIkth3jgMblB2Enc+VfCmRdLtikOpQm+6qGadH+J2Nwxy/YhlLUQJ
	 ogY4vWq/U6E4lYhhH1zzzyAn3dvYwnkr8iUDDOTFYTRR80OI07nsZTkedYjAe2oh9mpmL
	 iCnubMhd1EcGVFsXSIbpSe843YkbLZBgtfyOHfqc5eKkAdXjG7th1iLZX2bDO+eGtutXJ
	 W8qv+1XCl2xyG/xRMeqpHTSYc8Huw0Jpi2naYNtOIyZ4a5FU2zyz7Xfk41v29QAOsFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294181;
	h=DMARC-Filter:DKIM-Signature:Date:Received:References:
	 X-Lms-Return-Path:In-Reply-To:Content-Transfer-Encoding:Cc:
	 X-Original-From:Content-Type:Message-Id:Mime-Version:X-Mailer:To:From:
	 Subject;
	bh=TdtHdBztAO/0JtU1zECI9wziZwsMfxOqTiJiU6DPEOw=;
	b=rBl6ePA6p2XzsDjEyG/jqcLlrurDzqXJ8+AY87bbAoWcSNqEH1T+qjPOMdpiUhYZ8Hrs
	 aNP4fpA97U9L/4Dt/QmuJ2J0xFmKRQJ4Z+eTOhAXcme6VJF9pzzL+0Om4CtjhWrLBgG3U
	 7YXWFS7dl74Xc0gTdNsxO2MT0YbBSlzgG0fVrCbTeVQty8/5381hIW/UA2sayK6Y3XPkG
	 2sQKs0aNNQhSzNoMG0QlJoYtz7UO9J9t0SQS/odMz/aDbAtrPSKEl/Dyb7/Sm/XnSYaxP
	 R/nPDcXp/LpkjYL75drPmgjX7otgeu3rly4yYDsltrwoMS3CspJ4a81jj0xZqNR0qhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=gRjtFQyL;
	arc=none smtp.remote-ip=209.127.231.45
Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3E60A2609
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 07:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E3E60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=gRjtFQyL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794294176;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TdtHdBztAO/0JtU1zECI9wziZwsMfxOqTiJiU6DPEOw=;
 b=gRjtFQyL5jfft0V5B+TWMCAQhFrUGgfN85KdrLQa29lPx3DmVs4wOx2qSu4ELwkWoIgNKN
 LWERIR55XZXQe4mfkfOij4Hq3pp23GHIkxILnNe8fRKfO3XrePlnS9Ti9bZshe+uAHjPrj
 0mridLdzRWKB4f8XKd0+RDY+jM3Ytd7KBs9iG3I+YGpK/dekOJN5CkulX/LDUlX3ySdiJ5
 Szhlug1ynfNBUzuEtv3lU0AN5mU4joZER0PIUZ4woO/UqWuW0AWkQji5g0P2Pc8otHx2nR
 M071v9EkDrifglenrIM/gzsV8siXW8saU5GzJw2VDgKN9gmGDPqSpHP7zWv8hw==
Date: Tue, 10 Nov 2026 15:02:32 +0800
Received: from [127.0.1.1] ([1.192.71.23]) by smtp.feishu.cn with ESMTPS; Tue, 10 Nov 2026 15:02:53 +0800
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
X-Lms-Return-Path: <lba+26af2c19e+93210f+vger.kernel.org+rongrong@oss.cipunited.com>
In-Reply-To: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
Content-Transfer-Encoding: 7bit
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20261110-mips-ls7a-wdt-v1-3-968bb85122e6@oss.cipunited.com>
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
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH 3/4] MIPS: Loongson64: Add watchdog node for LS7A PCH

The Loongson-7A has a watchdog. With proper support added to the
loongson1_wdt driver, wire it up by adding a watchdog node to
ls7a-pch.dtsi.

Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index f304f99946f1..770c96e9b908 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -67,6 +67,12 @@ ls7a_uart3: serial@10080300 {
 			no-loopback-test;
 		};
 
+		watchdog: watchdog@100d0030 {
+			compatible = "loongson,ls7a-wdt";
+			reg = <0 0x100d0030 0 0xc>;
+			clock-frequency = <50000000>;
+		};
+
 		rtc0: rtc@100d0100 {
 			compatible = "loongson,ls7a-rtc";
 			reg = <0 0x100d0100 0 0x78>;

-- 
2.55.0
