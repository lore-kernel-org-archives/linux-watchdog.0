Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199188;
	b=wk2f74gygMWG5mHvZBk3+Bc4y8um14DX1usnvM+WdwtcHj2o676u2IqM8n/AzMGhNB4O
	 sHP5EADDnVq6b9UCPsjVE+UnRpNI12Zbl/5kZ8Jve0SnCOEfR6IxI/1OPL/ALSjAQ68c1
	 Qjv2xszeuMjLsVHZ57R0givNaF+JmwBvydoYDr4Kv869J92BEmqqjc8QJd8ADJD/u0Wps
	 z1wX0b00ZMCyKZFuKI6PlmOPphtswlFJJ5WeyfP74CImhsAxfLeIGhOGrkH79cpL5KoFd
	 RZoAZ6w39i0XQX0+TltpSgMwhseyWHkcy/OSTverboiPW1bcPcEhZ8sn41X0KQSlmIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199188;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=P1GIpgUgATjRtmShaLmb9WJ65EK51EMomNgm/lz9AjM=;
	b=hIKOUCAKk1Q7WG2ojdez2228jj9N3J9Jl5m2/ifsTDYVEsJ7lg6Qco4wK87hhNFWAuGd
	 8wdTYEjyyKRJmCT8lA7paKDeJCVhbM9XUr9UIyzFWPtqUoasgOWoEZjsmftRfNCo0D9PI
	 0W7RMEKMyt0HSpjkdTd+2+utn0iJ+CbMZTEx/JB6dkLrUiAh2yDX8/+6qs6ouoFuHVB7f
	 /FUdtiWbd0Vw+5tQngQO4tgrO8Rn5wt8htQ08WYy3EGI6RcAHED5T8dMfXmVIWqN6k21y
	 +fKUbOh6Q3XMNEEB//GQZMyjM9GupVQEwfEhItcl31mxKuzFa1iu3HEZkqI20gyNULw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="mSJpWq6/";
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF09606A31C
	for <linux-watchdog@vger.kernel.org>; Wed, 28 Oct 2026 14:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FF09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=mSJpWq6/
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id Lv2YxJJqic3XsM51XxrGsW; Wed, 28 Oct 2026 14:53:07 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id M51WxEDeyWZOZM51XxLMqP; Wed, 28 Oct 2026 14:53:07 +0000
X-Authority-Analysis: v=2.4 cv=UfZRSLSN c=1 sm=1 tr=0 ts=6ae20c53
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=Zefr6VZ22Yr9aPQxvcwA:9 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=P1GIpgUgATjRtmShaLmb9WJ65EK51EMomNgm/lz9AjM=; b=mSJpWq6/+oO0
	yLuDGrC5uwCv4kTgX5kx7qnJO2Xit0zwUbr7guTTkMP3s8EVLCBIsCCw54TjcolN69pfKDKawPkeB
	VzNSfCU+6N/yI67upJkWxnIdV7iLb3AV84nI4qDGWuDtsxIcMqvAMAjp73DzylBpGvIRro4JaNO+S
	XjNvaaPxTqnPeg3zn785tPRJPjrpxzdAbbTU9Z1xxZ3t/Fi/2V1PD93k7PWLXkA9xuycEcVcXPLaB
	uDLlTw+F9ES+yP0pkDmiwgYKfQ5wOrEJE1b/tXLZZrHQHn8waEH+r++dj9pvuh2aljk344sGcxlqv
	rKbLwI2Z9X4h7nz2cIemAg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:45432)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xM51W-00000004EWL-1ljv;
	Wed, 28 Oct 2026 20:23:06 +0530
Message-ID: <fe262c42-6657-4e98-912b-f6d37b145ec8@roeck-us.net>
Date: Wed, 28 Oct 2026 07:53:05 -0700
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
Subject: Re: [PATCH 6/6] watchdog: rdc321x: initialize device state before
 registration
To: Jiale Yao <yaojiale02@163.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Florian Fainelli <florian.fainelli@telecomint.eu>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261028044828.96177-1-yaojiale02@163.com>
 <20261028044828.96177-7-yaojiale02@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261028044828.96177-7-yaojiale02@163.com>
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
X-Exim-ID: 1xM51W-00000004EWL-1ljv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:45432
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMOVdiQbkte75tksttkqq3TfTLo2h5/JPPhZOadZcjyIvv0oynI62yN6Ueh/kcUnVR2oEStRyPUdtIQWFCFthaevPZqDvuSNJRsdEXJ5GoHR6KPHB87R
 aYSY9cEI5r7NIukOYVjPLrmh1qhNaO2bXK6xmT0JUf6lxnOlEXlaJwj8v90ktOKtANpHcBiIOPBv3Shkk4KVWWlMkiZmDv4Ax1/rc5mcw0QaBacuycMVeO2F

On 10/27/26 21:48, Jiale Yao wrote:
> misc_register() exposes the watchdog before its lock, completion, and
> timer are initialized. A userspace operation racing probe can therefore
> use any of these objects before it is ready.
> 
> Finish initializing the watchdog state before registering the misc
> device.
> 
> Fixes: b3e8f2c13ae9 ("[WATCHDOG] Add support for the built-int RDC R-321x SoC watchdog")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

I am not going to apply this (or similar) patches.
If you do have hardware utilizing this watchdog, pleae convert the driver
to use the watchdog subsystem. Otherwise, please leave it alone.

Thanks,
Guenter

> ---
>   drivers/watchdog/rdc321x_wdt.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
> index 8955177072fa..a2520d8d5c90 100644
> --- a/drivers/watchdog/rdc321x_wdt.c
> +++ b/drivers/watchdog/rdc321x_wdt.c
> @@ -233,12 +233,6 @@ static int rdc321x_wdt_probe(struct platform_device *pdev)
>   	rdc321x_wdt_device.queue = 0;
>   	rdc321x_wdt_device.default_ticks = ticks;
>   
> -	err = misc_register(&rdc321x_wdt_misc);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "misc_register failed\n");
> -		return err;
> -	}
> -
>   	spin_lock_init(&rdc321x_wdt_device.lock);
>   
>   	/* Reset the watchdog */
> @@ -251,6 +245,12 @@ static int rdc321x_wdt_probe(struct platform_device *pdev)
>   
>   	timer_setup(&rdc321x_wdt_device.timer, rdc321x_wdt_trigger, 0);
>   
> +	err = misc_register(&rdc321x_wdt_misc);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "misc_register failed\n");
> +		return err;
> +	}
> +
>   	dev_info(&pdev->dev, "watchdog init success\n");
>   
>   	return 0;

