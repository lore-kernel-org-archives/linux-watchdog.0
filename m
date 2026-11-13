Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530654;
	b=PcNqovGsY3VF9En6bnfY74AWuRSEkiKfukOLMVySYSDok4xXXpiEQztsMFu6uFT2vRAB
	 E2wc2M3f61K7MW+jjnhjRWc00SBPhL3TGjbfomT72LELAxlN+tFaw8oX9jmpSQ1PV705k
	 CSVQBgWI//SVhP6o617RNMAqpv61aZBBSHnWBjs5ojBMm818C8OAs4IXPtDd5eQ8wnrrT
	 BArJDUnWeO5r8l+wKC2WjI9gA+czaavudw6OMPbTVkvMUn3L08KfqN+95xX44uTsa9NiI
	 CgtIJWLJV2sbAOOU3c/gaDOgKn06ewlSMCcnSBkXRUpW45EFtm7nExD79fjxnhMpoug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530654;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=gPEqd6cD/fqQw04EbCe32E6BIonMlduxm+Jx4+v1FHE=;
	b=eIQBwmyiYf6DY7lE6c4a4zpDy0Am/geSw/igpCcoD9rsqSqCeXG9RYzRAcH6BfWltMmv
	 XJnfGEOrTm0Zt1snKUsmFK5InFEWvN4IpHHkEIC3N+zTN/EXwQ9DUjlHvDoQEjnRM09rn
	 tkXXgOvUZU3xhoCc84ssoyT2vT0DXspe2cmI7tNIkO0raWlHNUxWd1cVt6DIOE3tZQ+gs
	 tqg5ya8vP/5VqkPrLkEZ5MQYnThMXv0xwaQTHaoGHjGbJRKsazVbljmyPgPdEIUdKSHXo
	 m6H3gxd8ljyvUy/5err8G64Z8aDOVspxR9e4RaFm9baHdAzhAxSuSJHdNnD4mbnfOFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=NFsDDVSI;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20380606A31C
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 00:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20380606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=NFsDDVSI
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id RcrQx8NtE4vCDRfOnxn8bs; Fri, 13 Nov 2026 00:44:13 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id RfNKxXgDn0288RfNLxZqtc; Fri, 13 Nov 2026 00:42:43 +0000
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=6af65d03
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=u2c38VbFgFXAgpsfhD0A:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=gPEqd6cD/fqQw04EbCe32E6BIonMlduxm+Jx4+v1FHE=; b=NFsDDVSI3739
	BFP/m9EezS79Uh7f+eZwoFR9ze53dIuj7/S/TYa1YgvCO2CXb7oskLS6ARti8hlH44YRPhEI4jdS6
	18T//UjOyARN7Y8rnJ1CsxYcWfEWm8kYp/HF/0aUTqTBUTNskuaj3xy++H6R9g/p9ElUQr3AMA4p3
	qae5rKX/wPSGSDI7xWmosRrRpLfwqiv8Q9zw6Fkvz5H0t0bX++xFMUhdC6BBhJzQhDoYeGBlht244
	h6vP2l9oNoakywR/w7nGdp3NUlSgboaZu+jnMv8FckacgWi2NSIGRCjXFaWjGn2mOuMZj/8NOb1T0
	oSR1/M2Of2T4N8+dD9/S4Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:42682)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xRfNK-00000003M8j-1MrI;
	Fri, 13 Nov 2026 06:12:42 +0530
Message-ID: <468e51cb-5852-4c8a-938d-bda2aca8c83e@roeck-us.net>
Date: Thu, 12 Nov 2026 16:42:41 -0800
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
Subject: Re: [PATCH v6 4/4] watchdog: vt8500: Add a restart handler
To: Alexey Charkov <alchark@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <20261112-vt8500-timer-updates-v6-0-fd1cea645d1f@gmail.com>
 <20261112-vt8500-timer-updates-v6-4-fd1cea645d1f@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261112-vt8500-timer-updates-v6-4-fd1cea645d1f@gmail.com>
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
X-Exim-ID: 1xRfNK-00000003M8j-1MrI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:42682
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBzC6foHFX+jAuSuv7WosdzwmqVMTtgAhptxTmCSpi/ZyiO96xa7cLPxM1tYojhrEodY1BsrLTJ7XdQLg0w9SHKeEcHL8f8s74xixMlSEek/C/BIN9+E
 NERS6Y1Kd7uxLatY/8vHLOZ/oRWJL/0JqQ9LCn2K9cwhwJ4OfBNuWYMXgohQ22oykCh9huJNoIWQP0ZpQwsy6piSXYby7jWH5b4oLBVONo3Q8rhnn2fE94QN

On 11/12/26 10:55, Alexey Charkov wrote:
> Reset the SoC through the watchdog when the machine's own restart hook
> leaves it running: the PMSR write in vt8500_restart() has no effect on
> WM8950, so a reboot there ends in "Reboot failed -- System halted"
> unless a watchdog armed from userspace happens to fire.
> 
> Arm the match a millisecond ahead of the current count, which leaves
> ample margin for the register writes to land.
> 
> Register at priority 128, the default for restart handlers and also the
> priority of the ARM machine restart hook. That hook is registered first,
> from setup_arch(), and handlers of equal priority run in registration
> order, so this one runs right after it and only matters where the hook
> fails to reset the SoC.

This isn't really the idea of restart handlers. The sequence should be well
defined. That is what the priorities are for. Why not give it a slightly
lower priority ?

> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   drivers/watchdog/vt8500-wdt.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/watchdog/vt8500-wdt.c b/drivers/watchdog/vt8500-wdt.c
> index e0f838fd1d50..0ce1e2b06410 100644
> --- a/drivers/watchdog/vt8500-wdt.c
> +++ b/drivers/watchdog/vt8500-wdt.c
> @@ -25,6 +25,9 @@
>   
>   #define VT8500_WDT_DEFAULT_TIMEOUT	30	/* seconds */
>   
> +/* How far ahead of the current count to arm the match for a restart */
> +#define VT8500_WDT_RESTART_TICKS	(VT8500_TIMER_HZ / 1000)	/* 1 ms */
> +
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> @@ -75,9 +78,18 @@ static int vt8500_watchdog_stop(struct watchdog_device *wdd)
>   	return 0;
>   }
>   
> +static int vt8500_watchdog_restart(struct watchdog_device *wdd,
> +				   unsigned long action, void *data)
> +{
> +	struct vt8500_wdt_info *info = watchdog_get_drvdata(wdd);
> +
> +	return vt8500_watchdog_arm(info, VT8500_WDT_RESTART_TICKS);

This sets a 1-ms timer and doesn't wait for it to fire, so the next
restart handler (if it exists) will be called. That seems odd,
and may introduce unexpected behavior. Is this intentional ? If so,
it should be explained.

Thanks,
Guenter

> +}
> +
>   static const struct watchdog_ops vt8500_watchdog_ops = {
>   	.start			= vt8500_watchdog_start,
>   	.stop			= vt8500_watchdog_stop,
> +	.restart		= vt8500_watchdog_restart,
>   };
>   
>   static const struct watchdog_info vt8500_watchdog_info = {
> @@ -107,6 +119,7 @@ static int vt8500_wdt_probe(struct auxiliary_device *auxdev,
>   	info = container_of(auxdev, struct vt8500_wdt_info, auxdev);
>   	watchdog_set_drvdata(wdd, info);
>   	watchdog_set_nowayout(wdd, nowayout);
> +	watchdog_set_restart_priority(wdd, 128);
>   
>   	/* Let the core feed a watchdog left running, e.g. across kexec */
>   	if (readl(info->regbase + VT8500_WDT_EN_REG) & VT8500_WDT_EN)
> 

