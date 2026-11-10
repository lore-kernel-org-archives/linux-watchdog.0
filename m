Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294179;
	b=3zHvBCzBj/YruRPDfx9jjbGKqPj6RZurWYcmlFmAGyKRVfWCKkfugDqAHZDHcLwpyXFN
	 dSvVl80B5DdVKlc26wuDc7ZI32whAflyPLK7MSBscOia05MevGqZKqL7VF4BPQj7RONqd
	 1UYEsrF1/3rMpqCziBVb/VorPxXBFcvK7peEIumlDT8mCiGllnwhV3iXJnW2YbH/e1SCX
	 BfCRFQUOyHE4zqbmjxTqLZiqX+mTzJAb0uJv2ovLzdd6h7pFhoBtso1rRKffYcIWviwFb
	 Nb/APkCUo5R1rRTlT5ktWcPhQW2MxyoU5Gn/d0/OU8wHkxf299ZFKBxs0DjU55FJ7KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294179;
	h=DMARC-Filter:DKIM-Signature:Cc:From:Date:X-Mailer:Content-Type:
	 Received:References:X-Original-From:In-Reply-To:Message-Id:
	 Mime-Version:Content-Transfer-Encoding:To:Subject:X-Lms-Return-Path;
	bh=VtDaiBvkfKI1+bXdcUXzcnZOabPvH6+FEFj3kyTZ72Y=;
	b=GLI4n7m//1JktwQ8MxaR0RVDbwKSkVqS54DntElta9WTMXPvpBYwzoVPd2N4ua+EhT4J
	 Wz28k4WktvzTTTL3d5T2IiyhtkSmpXrwvK0h4VDeSAhwb5tWfSG1kih+bpqQQEKTbB6tj
	 +j39d6bkfQ/W8+rjah5IBqhJzzBchoy1wtBPL/3itierf0HZB+thC/wggFzYBD1pinP/R
	 qVPl/Ae96FC18dzXROC11RVAwH3WdYrzsCJz1ixB4N/7JMAlkC398fcnWypWMRqtVYlnF
	 5Go3fh0Z1225I7CtOcGhkw02ZWjGfdnqD7UV1vgjl0rdlWwjKx1sweOGYzXqXoaFpFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b="d9GI3/Bp";
	arc=none smtp.remote-ip=209.127.231.42
Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852D606A336
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 07:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9852D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=d9GI3/Bp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794294174;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=VtDaiBvkfKI1+bXdcUXzcnZOabPvH6+FEFj3kyTZ72Y=;
 b=d9GI3/Bpox/LDYRbAdfDF3TMwJ1HXTzwZLm6rJY0h6UxDvk/7dGgm3ciG7BxeMvnxd2Y+K
 a6rpsPcGJUE9JLBrQlpaN4oDe7hRjYLrDqnaVlKrkbAH7Vp/4uWqK83VGunKgJIS3+i/Is
 M2ancIUQV+NNQph+Rx0lfaf8uY18evuXkfqmFVPeo332xtgPw7IfDKiQ61FkDh7iLDQjfv
 G6p+ll7860h91JSpkGYb/0cuJbQkZg/dhn6NB+IYno8A4/32MVB3LHL+v8bY6lkol/gE5E
 2iJCQ1JGUEBxXEfIOFapKIgN09ZEIbBkBJLOdaAcJmhe7unavkLZeCKgq9HEsw==
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Date: Tue, 10 Nov 2026 15:02:31 +0800
X-Mailer: b4 0.17-dev-ce4c1
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.1.1] ([1.192.71.23]) by smtp.feishu.cn with ESMTPS; Tue, 10 Nov 2026 15:02:51 +0800
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
In-Reply-To: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
Message-Id: <20261110-mips-ls7a-wdt-v1-2-968bb85122e6@oss.cipunited.com>
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
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 2/4] watchdog: loongson1: Add Loongson-7A watchdog support
X-Lms-Return-Path: <lba+26af2c19c+d3620a+vger.kernel.org+rongrong@oss.cipunited.com>

The Loongson-7A watchdog is similar to Loongson 2K0300, except that it
has no clock controller.

Retrieve clock frequency from OF to make it work.

Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 drivers/watchdog/loongson1_wdt.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 2811e7eab631..57b9e699c131 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -31,6 +31,7 @@ struct ls1x_wdt_pdata {
 	u32 timer_offset;
 	u32 set_offset;
 	u32 wdt_en_bit;
+	bool no_clk;
 };
 
 static const struct ls1x_wdt_pdata ls1b_wdt_pdata = {
@@ -45,6 +46,13 @@ static const struct ls1x_wdt_pdata ls2k0300_wdt_pdata = {
 	.wdt_en_bit = BIT(1),
 };
 
+static const struct ls1x_wdt_pdata ls7a_wdt_pdata = {
+	.timer_offset = 0x8,
+	.set_offset = 0x4,
+	.wdt_en_bit = BIT(1),
+	.no_clk = true,
+};
+
 struct ls1x_wdt_drvdata {
 	void __iomem *base;
 	struct clk *clk;
@@ -129,6 +137,8 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	struct ls1x_wdt_drvdata *drvdata;
 	struct watchdog_device *ls1x_wdt;
 	unsigned long clk_rate;
+	u32 freq;
+	int ret;
 
 	drvdata = devm_kzalloc_obj(dev, *drvdata);
 	if (!drvdata)
@@ -136,16 +146,26 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, drvdata);
 
 	drvdata->pdata = of_device_get_match_data(dev);
+	if (!drvdata->pdata)
+		return -ENODEV;
 
 	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
-	drvdata->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(drvdata->clk))
-		return PTR_ERR(drvdata->clk);
+	if (drvdata->pdata->no_clk) {
+		ret = of_property_read_u32(dev->of_node, "clock-frequency", &freq);
+		if (ret)
+			return ret;
+
+		clk_rate = freq;
+	} else {
+		drvdata->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(drvdata->clk))
+			return PTR_ERR(drvdata->clk);
 
-	clk_rate = clk_get_rate(drvdata->clk);
+		clk_rate = clk_get_rate(drvdata->clk);
+	}
 	if (!clk_rate)
 		return -EINVAL;
 	drvdata->clk_rate = clk_rate;
@@ -191,6 +211,7 @@ static const struct of_device_id ls1x_wdt_dt_ids[] = {
 	{ .compatible = "loongson,ls1b-wdt", .data = &ls1b_wdt_pdata },
 	{ .compatible = "loongson,ls1c-wdt", .data = &ls1b_wdt_pdata },
 	{ .compatible = "loongson,ls2k0300-wdt", .data = &ls2k0300_wdt_pdata },
+	{ .compatible = "loongson,ls7a-wdt", .data = &ls7a_wdt_pdata },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ls1x_wdt_dt_ids);

-- 
2.55.0
