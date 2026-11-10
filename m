Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294177;
	b=c+eH8NVgnamXKA2noxLC8OuExhT1puFde6U1tglOSvtbu81tifzGnwQSBjSzU8v3tLG8
	 yM5GLzADmF/UV+B3WZgWp9fB6CdqbwjQkJL4PU+QI7oWhil8JszzQQuKoxHvpwSet+Cuk
	 zjvDCw4ac+LI0gYfv1TMsEiVKgoes+PRnEPKtOzkGu72FzT9K2sKyt2CM/GsvjTIQNICs
	 dbN79S4acKquwlUt8onD1qMk47pTeZEqwiI+a9Ojt7h4HZuvOwcnPvKTgKKjR5uvtiUYq
	 5YbByK1BhkdzZp0T8gaM/cwbv4CduPt0C52hwCiXELRrJAaJMYA3PjhHKxgs2uWOjOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294177;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:To:Subject:
	 Message-Id:X-Mailer:Cc:Date:X-Lms-Return-Path:Content-Type:
	 X-Original-From:X-Change-Id:X-B4-Tracking:From:Mime-Version:Received;
	bh=UleRd71tSF6eVZUuoDFDW/IbSpmyxdNph78pCLJH6Zc=;
	b=hbbjvMMyqAme6D8TfmcC/OQquWkacmYu01RQNWvfT1XyDLGJrD12qx1HD5tDMjaxRKU9
	 6LLHgNDpBrr8HsrSnYr0eJGdvhbCzL1cgDePfAmf6qV3fubZlv8sasHPXjEUxO/mzE/TT
	 6zGhmAGNsX33hU86XS39qEILzTE9XSHoyyJDx81eL2Bv8SMYiCQhAUxL8j9GYoalozhd9
	 BjzD68QF/dCr2lVtUO0YCWu38MMtdKRgxB2DNu0Lhgt1sntG45EQ09WHcMDlASpafNbrt
	 J2RTfWGY7OtAtEYYetK2VLYP1s8D1h1jCLP7jfNjlaf+d2yS2BL7YL+se1EjhtM1Gsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=0mHHzO3h;
	arc=none smtp.remote-ip=209.127.231.50
Received: from va-2-50.ptr.blmpb.com (va-2-50.ptr.blmpb.com [209.127.231.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3560606A321
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 07:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3560606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=0mHHzO3h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794294170;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=UleRd71tSF6eVZUuoDFDW/IbSpmyxdNph78pCLJH6Zc=;
 b=0mHHzO3hdDm+ZqSmeePie3b7fSizRXzVc5ISORKVWO/3kMoCUKn/YYe1Gd2lzn/GfJoG99
 VwKnnnWYfQ24n6lcS+1SLnM+XU31eB8yyR9dut/ff/ZdO0J40b4AXhv/2CDWMgSu5RBtTY
 EGR8bRzLCKjhcMAmMsWlqQrHKL9RttmkGu8zWMMiW6DpO5/PzJwnO8slzwIWYTRk2aGL/r
 alMNMEAbn/m54u36R2uqggVVy/JFyF8DRWDX3IwGbt09fZ6Cq7vxuLo/OEA4liwLnt1jus
 U+SYnJkX4mOfuwvT9PDhZ9ANE+SnmKM3fk6ww4NT4Jon28vsR7a7kQSJvdVkKg==
Content-Transfer-Encoding: 7bit
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 0/4] watchdog: loongson1: Add Loongson-7A watchdog support
Message-Id: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
X-Mailer: b4 0.17-dev-ce4c1
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
Date: Tue, 10 Nov 2026 15:02:29 +0800
X-Lms-Return-Path: <lba+26af2c197+d3af15+vger.kernel.org+rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
X-Change-Id: 664fad58-mips-ls7a-wdt-1e614643b33d
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE vPSU3UzU4B8JTMzk7TEFFML3dzMgmLdnGLzRN3ylBJdw1QzQxMzE+MkY+MUJaCegqLUtMwKsHn RsRB+cWlSVmpyCcgQpdpaAMP50/FxAAAA
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
Received: from [127.0.1.1] ([1.192.71.23]) by smtp.feishu.cn with ESMTPS; Tue, 10 Nov 2026 15:02:46 +0800

The Loongson-7A watchdog is similar to Loongson 2K0300, except that it
has no clock controller.

Add "loongson,ls7a-wdt" compatible as well as a conditionally required
field clock-frequency. The driver will retrieve clock frequency from OF
to make it work.

With these, add a watchdog node to the LS7A PCH dtsi to wire it up, and
enable LOONGSON1_WDT in defconfig to make it work by default.

Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
Rong Zhang (4):
      dt-bindings: watchdog: loongson,ls1x-wdt: Add ls7a-wdt compatible
      watchdog: loongson1: Add Loongson-7A watchdog support
      MIPS: Loongson64: Add watchdog node for LS7A PCH
      MIPS: loongson3_defconfig: Enable LOONGSON1_WDT by default

 .../bindings/watchdog/loongson,ls1x-wdt.yaml       | 31 ++++++++++++-
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi          |  6 +++
 arch/mips/configs/loongson3_defconfig              | 54 ++++------------------
 drivers/watchdog/loongson1_wdt.c                   | 29 ++++++++++--
 4 files changed, 70 insertions(+), 50 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 664fad58-mips-ls7a-wdt-1e614643b33d

Thanks,
Rong
