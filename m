Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296852;
	b=GsigS+mazw6qNnxmFJUMeo4nWC/0yP/Uxc4+ZcTBI4FvsSuQq0cyPc4Xivs91TU+Tdhq
	 7eaYfxOyEGuFQciI9edOjvx22SxuTN29k8RiMdW3squqMvY/Bw5cG6xfzreJcW2zQdr+J
	 kN+p2auvH0K/iuqTTC78h9USqJvOI3aTfnzp4mqqDqxosn6Z10TZJl01vqMvY+Z8TJie/
	 6ub+UxaZA3BHMONyaLo4cMgPN5vADTSzre2uYqGf/TUBPC71Y7lJ09S5uYteI+wx+iC0Q
	 tg6xIqYF82E6yGQTuUYYs3J1uUsFnplvXZ6vph72RnblcyeVMgbFh4RhzQnQRvfF5TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296852;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=ZdOpelxHEyCF0gxFn3MQJ7SWUNe56C4I7f9Inm7VJXY=;
	b=R7J9Y/qVR9gcJ7ImeoEstXCVW0zp76m5DIgj4HvNwC/cWXNF5agszDzf0HlToc2a4Hx5
	 nsQR96vGxuG1jrKjxGY01j9ewzDxHm54VFhW2jH1W9C08GagrTzNFfUqzpCWbpNCPiknt
	 9gzCNYDp1Rg+XDGGDxTSX/91I5S5gCfcpB7inXFdWB1HRhLCquAxv816/M78HmnMMkQiO
	 YYizA01Bpw8CeS2mtcTWtZJF1kXb7OHCiSXAG2IRUUKdpCsa3ou0KlXcyhR/ugAoWEOpJ
	 YBxhHDMSP0UtKvHF/Qb6oWDDcemqxlGtlh7iuewW4u5dim4VJFU3xq73pyyN6ivtGAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="U2Cw/7TT";
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEFA606B525
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 07:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AEFA606B525
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=U2Cw/7TT
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id Qetpxtfh34vCDQgZmxEcmw; Tue, 10 Nov 2026 07:47:30 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id QgZlxh7ydGh2BQgZmxEMfq; Tue, 10 Nov 2026 07:47:30 +0000
X-Authority-Analysis: v=2.4 cv=Aszu3P9P c=1 sm=1 tr=0 ts=6af2cc12
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=rxihhvIKAAAA:8
 a=igakLOeW_9eA_uLUBNUA:9 a=QEXdDO2ut3YA:10 a=vyXZNj8PikhivSrfMdal:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=ZdOpelxHEyCF0gxFn3MQJ7SWUNe56C4I7f9Inm7VJXY=; b=U2Cw/7TT81ID
	O2OAzJ6ZhvN5ToA3vikuAdlPBfe8y8AoBRPL8PUiKOrPNt8Qn/inWHuO4GZbK/kG0yn+vOzSAqyYZ
	toKMqKk/r1NQedBlT00k5MeTyHLEHSHtuEZDnJOraLrfApTNHffu4TmbmArlmLcXYoWsnomMLITc1
	2TfSg2HjfLw13ubb5a+o8frHWD12hVjWhArW0bRcGVKsLaBQFtn3zFdeh+NMUtn6x4qKUIKnpPwCO
	FjaGLOT4XrtDdtrK/tvGXVWO8UBmI1jkVJ+A0LU/9nAzoU61Os77s6p2gEi4OEbx6C3pMuztIlO0X
	qMhbXeoDwlFmYdSGFyPxmg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51292)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xQgZk-00000001A5f-2jf5;
	Tue, 10 Nov 2026 13:17:28 +0530
Message-ID: <9525d680-71e7-4dc8-a1fc-1be178453cb2@roeck-us.net>
Date: Mon, 9 Nov 2026 23:47:26 -0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] watchdog: loongson1: Add Loongson-7A watchdog support
To: Rong Zhang <rongrong@oss.cipunited.com>,
 Keguang Zhang <keguang.zhang@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Rong Zhang <i@rong.moe>, Yao Zi <me@ziyao.cc>,
 Icenowy Zheng <uwu@icenowy.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
 <20261110-mips-ls7a-wdt-v1-2-968bb85122e6@oss.cipunited.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261110-mips-ls7a-wdt-v1-2-968bb85122e6@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xQgZk-00000001A5f-2jf5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:51292
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 9
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH8nyBJWmRZioWzUxuS0IGU0ZMe3+FWqgM1R+w69jg3z2GFgJK01upLcBKwS53GtlYv25aUuSb6AfhRdWaIzYicC+3Bh2ubuVp9Aoy+GoYc5agqqi2Zp
 sCpMtJZ6fnMvmT3SeLu2Q2nYJZKEylr4Rs9KUWnd6VtRsApPUcSzgKC/rC4KJD4G0CtiAPm7/BQgvFvWTsxnJsVjrzDM9Wu2t4bHbYE/HEwzkWucDV6XywrI

On 11/9/26 23:02, Rong Zhang wrote:
> The Loongson-7A watchdog is similar to Loongson 2K0300, except that it
> has no clock controller.
> 
> Retrieve clock frequency from OF to make it work.
> 
> Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.
> 
> Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
> ---
>   drivers/watchdog/loongson1_wdt.c | 29 +++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> index 2811e7eab631..57b9e699c131 100644
> --- a/drivers/watchdog/loongson1_wdt.c
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -31,6 +31,7 @@ struct ls1x_wdt_pdata {
>   	u32 timer_offset;
>   	u32 set_offset;
>   	u32 wdt_en_bit;
> +	bool no_clk;
>   };
>   
>   static const struct ls1x_wdt_pdata ls1b_wdt_pdata = {
> @@ -45,6 +46,13 @@ static const struct ls1x_wdt_pdata ls2k0300_wdt_pdata = {
>   	.wdt_en_bit = BIT(1),
>   };
>   
> +static const struct ls1x_wdt_pdata ls7a_wdt_pdata = {
> +	.timer_offset = 0x8,
> +	.set_offset = 0x4,
> +	.wdt_en_bit = BIT(1),
> +	.no_clk = true,
> +};
> +
>   struct ls1x_wdt_drvdata {
>   	void __iomem *base;
>   	struct clk *clk;
> @@ -129,6 +137,8 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
>   	struct ls1x_wdt_drvdata *drvdata;
>   	struct watchdog_device *ls1x_wdt;
>   	unsigned long clk_rate;
> +	u32 freq;
> +	int ret;
>   
>   	drvdata = devm_kzalloc_obj(dev, *drvdata);
>   	if (!drvdata)
> @@ -136,16 +146,26 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, drvdata);
>   
>   	drvdata->pdata = of_device_get_match_data(dev);
> +	if (!drvdata->pdata)
> +		return -ENODEV;
>   
>   	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(drvdata->base))
>   		return PTR_ERR(drvdata->base);
>   
> -	drvdata->clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(drvdata->clk))
> -		return PTR_ERR(drvdata->clk);
> +	if (drvdata->pdata->no_clk) {
> +		ret = of_property_read_u32(dev->of_node, "clock-frequency", &freq);
> +		if (ret)
> +			return ret;
> +
> +		clk_rate = freq;
> +	} else {
> +		drvdata->clk = devm_clk_get_enabled(dev, NULL);
> +		if (IS_ERR(drvdata->clk))
> +			return PTR_ERR(drvdata->clk);
>   

Wouldn't it be much easier to just create a fixed rate clock and use it
(as suggested by Sashiko in the devicetree patch) ?

Guenter

> -	clk_rate = clk_get_rate(drvdata->clk);
> +		clk_rate = clk_get_rate(drvdata->clk);
> +	}
>   	if (!clk_rate)
>   		return -EINVAL;
>   	drvdata->clk_rate = clk_rate;
> @@ -191,6 +211,7 @@ static const struct of_device_id ls1x_wdt_dt_ids[] = {
>   	{ .compatible = "loongson,ls1b-wdt", .data = &ls1b_wdt_pdata },
>   	{ .compatible = "loongson,ls1c-wdt", .data = &ls1b_wdt_pdata },
>   	{ .compatible = "loongson,ls2k0300-wdt", .data = &ls2k0300_wdt_pdata },
> +	{ .compatible = "loongson,ls7a-wdt", .data = &ls7a_wdt_pdata },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, ls1x_wdt_dt_ids);
> 

