Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297710;
	b=0PP8hGSpa6p1/Xy0ac36cHJKGWltJoz1N8c/mCz5NW/Vg12uOi3DrzyXhych2E99BfNq
	 yrTuoZqBLi07ZypdMm0OA4YjH37q2EMP13w8Pc8eDKGiL6eV/iCPq5GVi0fCjKpM5ZmOM
	 TwZflkXlbucsF/zWKeGauYUgGN/L391h6RpRK6UDb4zjAoxmrlBdiYagmdDMUVFM7B3Bh
	 nILFLM3q3m2XEuI6CtnGBS9gkJl75QbrLrnZaCtyM3dtcnEDZCBrgtBtuKhdlkM23D8D8
	 QM2CPeXpBJ+S77CcE4Ttlbp2pAa92DhtXwslVUW8Rngve+QqYzYd2FjEPAXQqpdIgoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297710;
	h=DMARC-Filter:DKIM-Signature:X-Original-From:User-Agent:References:
	 From:Content-Transfer-Encoding:Subject:In-Reply-To:Message-Id:
	 X-Lms-Return-Path:To:Date:Content-Type:Received:Cc:Mime-Version;
	bh=bcIJeNa/s/CZobvKVdNkLsGHNQtQLHi4ynaZuvo975c=;
	b=wVZCWFeB2bngLkaOiXSnwCUk0Rvm58gOl4f012SB69nlaTLvrP7G3N++LNrWBeBePyGL
	 b6Uwt+W66eeZfEuljXSTcI0aOK3P7yCCzR7Jp3ly/Im+4lUD0keXLdYVLEZ3CFWRNmN2K
	 0cNtStO9OhjiJQLJqgjFfgcSsJUL5V78ZdDSCzPQF5O0/qerYOJTWfncY2Bp02yVMXkCT
	 zM8zbE6Bd6IvtK3AEdaEA9jY2LgKd5axM863o07v9E/ckaStIAWaM9/ALH/q0a9aihkBG
	 xDTCROINbdSqQd44q9o8XMd1c6Yn6wzBUMUxNsrNPlNZvk6AV70IaCz98vgYjOtdMow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=4MSVaU26;
	arc=none smtp.remote-ip=209.127.231.60
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753A606A338
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 08:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C753A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=4MSVaU26
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794297705;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=bcIJeNa/s/CZobvKVdNkLsGHNQtQLHi4ynaZuvo975c=;
 b=4MSVaU26qeVK8ynCenaBr5muoOhhmeEfeEseOYlJxcDWXZUItpMOT4FhrOUTypssG1vQ/V
 MtfK4AZR26JIN2khiZF2hKONrg98py2EB0MxutW+VrXnSptIzClnBjDXw/3b7xQz11fjOk
 f11AUeOAf2Q/HLRzF2jbtND19dn9DdAuI8w9c6NmJ02bT+Pp/7VIjuA+izB7YepL2Lqy+0
 A/iGmhnn8n7iC1mHS1Dr3OrEeZnt2KFTgmCcwj5e3OwwC60AK+poTvXf1TZJ04BID4sOn/
 /fdnzWlHDjGEzES4ffINVvCr1Q0A1Vw4hT/kE3sA+0ADFEaVtk7rSkRsKAFzmQ==
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
User-Agent: Evolution 3.62.1-3
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com> <20261110-mips-ls7a-wdt-v1-2-968bb85122e6@oss.cipunited.com> <9525d680-71e7-4dc8-a1fc-1be178453cb2@roeck-us.net>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/4] watchdog: loongson1: Add Loongson-7A watchdog support
In-Reply-To: <9525d680-71e7-4dc8-a1fc-1be178453cb2@roeck-us.net>
Message-Id: <a1cae24c83e4b60bc6abfd1b387b3e92fe54c07d.camel@oss.cipunited.com>
X-Lms-Return-Path: <lba+26af2cf66+7d6f78+vger.kernel.org+rongrong@oss.cipunited.com>
To: "Guenter Roeck" <linux@roeck-us.net>, 
	"Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Date: Tue, 10 Nov 2026 15:59:59 +0800
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.8.156] ([1.192.71.23]) by smtp.feishu.cn with ESMTPS; Tue, 10 Nov 2026 16:01:40 +0800
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0

Hi Guenter,

On Mon, 2026-11-09 at 23:47 -0800, Guenter Roeck wrote:
> On 11/9/26 23:02, Rong Zhang wrote:
> > The Loongson-7A watchdog is similar to Loongson 2K0300, except that it
> > has no clock controller.
> > 
> > Retrieve clock frequency from OF to make it work.
> > 
> > Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.
> > 
> > Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
> > ---
> >   drivers/watchdog/loongson1_wdt.c | 29 +++++++++++++++++++++++++----
> >   1 file changed, 25 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> > index 2811e7eab631..57b9e699c131 100644
> > --- a/drivers/watchdog/loongson1_wdt.c
> > +++ b/drivers/watchdog/loongson1_wdt.c
> > @@ -31,6 +31,7 @@ struct ls1x_wdt_pdata {
> >   	u32 timer_offset;
> >   	u32 set_offset;
> >   	u32 wdt_en_bit;
> > +	bool no_clk;
> >   };
> >   
> >   static const struct ls1x_wdt_pdata ls1b_wdt_pdata = {
> > @@ -45,6 +46,13 @@ static const struct ls1x_wdt_pdata ls2k0300_wdt_pdata = {
> >   	.wdt_en_bit = BIT(1),
> >   };
> >   
> > +static const struct ls1x_wdt_pdata ls7a_wdt_pdata = {
> > +	.timer_offset = 0x8,
> > +	.set_offset = 0x4,
> > +	.wdt_en_bit = BIT(1),
> > +	.no_clk = true,
> > +};
> > +
> >   struct ls1x_wdt_drvdata {
> >   	void __iomem *base;
> >   	struct clk *clk;
> > @@ -129,6 +137,8 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
> >   	struct ls1x_wdt_drvdata *drvdata;
> >   	struct watchdog_device *ls1x_wdt;
> >   	unsigned long clk_rate;
> > +	u32 freq;
> > +	int ret;
> >   
> >   	drvdata = devm_kzalloc_obj(dev, *drvdata);
> >   	if (!drvdata)
> > @@ -136,16 +146,26 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
> >   	platform_set_drvdata(pdev, drvdata);
> >   
> >   	drvdata->pdata = of_device_get_match_data(dev);
> > +	if (!drvdata->pdata)
> > +		return -ENODEV;
> >   
> >   	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> >   	if (IS_ERR(drvdata->base))
> >   		return PTR_ERR(drvdata->base);
> >   
> > -	drvdata->clk = devm_clk_get_enabled(dev, NULL);
> > -	if (IS_ERR(drvdata->clk))
> > -		return PTR_ERR(drvdata->clk);
> > +	if (drvdata->pdata->no_clk) {
> > +		ret = of_property_read_u32(dev->of_node, "clock-frequency", &freq);
> > +		if (ret)
> > +			return ret;
> > +
> > +		clk_rate = freq;
> > +	} else {
> > +		drvdata->clk = devm_clk_get_enabled(dev, NULL);
> > +		if (IS_ERR(drvdata->clk))
> > +			return PTR_ERR(drvdata->clk);
> >   
> 
> Wouldn't it be much easier to just create a fixed rate clock and use it
> (as suggested by Sashiko in the devicetree patch) ?

Makes sense. I will take that approach (and fix other concerns found by
Sashiko) when I resubmit this.

Thanks,
Rong

> 
> Guenter
> 
> > -	clk_rate = clk_get_rate(drvdata->clk);
> > +		clk_rate = clk_get_rate(drvdata->clk);
> > +	}
> >   	if (!clk_rate)
> >   		return -EINVAL;
> >   	drvdata->clk_rate = clk_rate;
> > @@ -191,6 +211,7 @@ static const struct of_device_id ls1x_wdt_dt_ids[] = {
> >   	{ .compatible = "loongson,ls1b-wdt", .data = &ls1b_wdt_pdata },
> >   	{ .compatible = "loongson,ls1c-wdt", .data = &ls1b_wdt_pdata },
> >   	{ .compatible = "loongson,ls2k0300-wdt", .data = &ls2k0300_wdt_pdata },
> > +	{ .compatible = "loongson,ls7a-wdt", .data = &ls7a_wdt_pdata },
> >   	{ /* sentinel */ }
> >   };
> >   MODULE_DEVICE_TABLE(of, ls1x_wdt_dt_ids);
> >
