Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224947;
	b=CWRTHtZcZzFNbkmgzzrJ/QMXH2GmlPKVJhHTJz9VoP2wB3Ie4K9beq5iF6IYD53/G3iY
	 leVtcCast8SI8Zf/VhO58QweQaX5OxbFaf7Hmm8MMllWbP7DNXBpK7XOT34aUNuKOxxO3
	 XGdojNO2EjpdPfIQg9Pnls+crKVOmh3iL/o9Ob8XZgRA2S6wXj7OOYbdtBLD+X0UkXlGn
	 la/gpoj1Et9IFrqkVU3+IX4ZswFXNJsnfMGihrnALFODvNwboOq/gELFUeffhYpgu2Rv3
	 3CSRhTvj+S85EJrt1OjW2ujcwZiqCldvs4JzmbDBp4WaG9I2hnP5LC1I3UfBJevdYmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224947;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=EReTIrSV8j4ZDshh+rBWtwWgWDj+qs/gWLXl3ITv8i8=;
	b=lUbemrjDMED7j5VxH2zp/A0L58sop0MBOQRPqBUBX6RRg9oHE6o2J+ga+TgLKk5+7aYX
	 lyYqPmg6mBzW4CWpV+2ywN1UoZLwR6XHXRfLoD3/tnsKLX9nch9U0MBKYqFSzLrYDSZmI
	 exggkupv2F1odFCn9/NEKiQOpoVuQmBaZAcsCIsr99gTWPXNnDgDl3AXHIkiBghs23IG1
	 XdS9+g5K+vA6/Ln0jSvICQPKurACkBv6j39Xnmab+Y2fu2epHdr6DynPHDVIUBZHcTUWn
	 jA6eO8MCWg5CQ53C1rhbzaN4l9R8UJbCnzD+7aWgGAUs4XE/JfpV81zZclO55VZLaRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="DAh/S3bm";
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50ED606A68C
	for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 01:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50ED606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=DAh/S3bm
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id UV8uxA32Iyb4YUa0xxbR9U; Sat, 21 Nov 2026 01:35:39 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Ua0wxpV3q8cn4Ua0wx0NIm; Sat, 21 Nov 2026 01:35:39 +0000
X-Authority-Analysis: v=2.4 cv=Qrde3Uyd c=1 sm=1 tr=0 ts=6b00f56b
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=0SxRSwYGAAAA:8 a=AcRjwwUwVOdtBLS5SPQA:9 a=CjuIK1q_8ugA:10
 a=evtWB9OUeeBtXImRToD_:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EReTIrSV8j4ZDshh+rBWtwWgWDj+qs/gWLXl3ITv8i8=; b=DAh/S3bmwEdXASQCyiiBoJgoV+
	GmYTdYw4jWJtZJXfOTKsnNtMxlCFdqVy7SJ2Zm1ACla5NMLS/sr9LHBKWfwPwpDPENTCf6OigO7j8
	rcpFycmqXASUrcYtJv038e426vUnMgWdMNrhFKuG6kc2E7dSlxHCDmxJ6NB9TigI0oPxSFav1aRd1
	K5E03+P0hAjbLNLiCj7HXpaRtl6E+TRiQ7e0MKq/WSFZWjyWhMmwuFgwblM0I45UBW54+YcOu2O28
	aykjcHFXTKE/Iqs0rauUNCOf82nD84q68DO00UTXTMDPmMFD5iVc/+PC8Mm+Ifvr2OEvUdwhgF3vY
	GHHcpuDg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54034 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xUa0w-000000043BZ-1Wxq;
	Sat, 21 Nov 2026 07:05:38 +0530
Date: Fri, 20 Nov 2026 17:35:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sven Ulland <sven.ulland@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] watchdog: gpio: Keep GPIO level when taking over a
 running watchdog
Message-ID: <6066c7ce-8119-459d-95f3-027a0d52e0d6@roeck-us.net>
References: <20261119164841.1847870-1-sven.ulland@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119164841.1847870-1-sven.ulland@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xUa0w-000000043BZ-1Wxq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:54034
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfELC52Hf3lLjv6eTUT9kE9txC/2phwvOVsmxqOUT/Z12qfYlTpvSW+XGON6mfUJ2s+r5ZiWtGf6qAwPnamT0iKroiZA8NAsJ1Gn1AoTLA1jpQiUofsYf
 trsWWG9TmWpfPexVbUl+mhCqbDeYscktgUPrjS9L4S0QJ0rHJ2itstqOaN9UqNr3y5iu7QMxVjSTTAq5wluN+3hEzysLYqh7PNp8DaAYNbrKnKzfPNZ9DSeG

On Thu, Nov 19, 2026 at 05:48:41PM +0100, Sven Ulland wrote:
> For a watchdog with the always-running property, the driver takes over
> at probe: it requests a toggle GPIO as input, and gpio_wdt_start()
> then drives it low and toggles it. These level changes happen within
> microseconds, and a watchdog that needs hw-min-interval-ms resets the
> system when pinged that fast, so taking over from the bootloader can
> trigger a reset.
> 
> The Aruba AP-305 access point (Qualcomm IPQ4029) has an external
> watchdog that resets the board when its GPIO is toggled every 6 ms or
> faster. Even with hw-min-interval-ms set to 100 ms, 7 of 10 boots
> started from the bootloader still reset within two seconds of the kernel
> starting.
> 
> If the watchdog has both always-running and hw-min-interval-ms, request
> the GPIO as is and keep its current level. The watchdog core then sends
> the first ping once the minimum interval has passed. Other watchdogs are
> unaffected.
> 
> Tested on the Aruba AP-305 with this change backported to Linux 6.18,
> and 10 of 10 boots survived.
> 
> Assisted-by: Claude:claude-opus-5-5

This trailer is obsolete. Please stop using it.

> Signed-off-by: Sven Ulland <sven.ulland@gmail.com>

Applied (after dropping Assisted-by: trailer).

Thanks,
Guenter

> ---
> This applies on top of watchdog-next, as it depends on Florian's commit
> 2791c2bc6aca ("watchdog: gpio: Support watchdogs with a minimum
> heartbeat interval").
> 
>  drivers/watchdog/gpio_wdt.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 865c2d0f1dd3f0937865dd11819eeb59298a814c
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 1c79498db69e..4f4f9e9a7031 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -79,6 +79,20 @@ static int gpio_wdt_start(struct watchdog_device *wdd)
>  	return gpio_wdt_ping(wdd);
>  }
>  
> +/* Take over a running watchdog without changing the GPIO level */
> +static int gpio_wdt_adopt(struct gpio_wdt_priv *priv)
> +{
> +	int level = gpiod_get_value_cansleep(priv->gpiod);
> +
> +	if (level < 0)
> +		return level;
> +
> +	priv->state = level;
> +	set_bit(WDOG_HW_RUNNING, &priv->wdd.status);
> +
> +	return gpiod_direction_output(priv->gpiod, priv->state);
> +}
> +
>  static int gpio_wdt_stop(struct watchdog_device *wdd)
>  {
>  	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
> @@ -112,6 +126,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  	enum gpiod_flags gflags;
>  	unsigned int hw_margin;
>  	const char *algo;
> +	bool adopt = false;
>  	int ret;
>  
>  	priv = devm_kzalloc_obj(dev, *priv);
> @@ -120,12 +135,17 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> +	priv->always_running = device_property_read_bool(dev, "always-running");
> +
>  	ret = device_property_read_string(dev, "hw_algo", &algo);
>  	if (ret)
>  		return ret;
>  	if (!strcmp(algo, "toggle")) {
>  		priv->hw_algo = HW_ALGO_TOGGLE;
> -		gflags = GPIOD_IN;
> +		/* Switching the GPIO to input could cause an edge */
> +		adopt = priv->always_running &&
> +			device_property_present(dev, "hw-min-interval-ms");
> +		gflags = adopt ? GPIOD_ASIS : GPIOD_IN;
>  	} else if (!strcmp(algo, "level")) {
>  		priv->hw_algo = HW_ALGO_LEVEL;
>  		gflags = GPIOD_OUT_LOW;
> @@ -168,8 +188,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  	}
>  
> -	priv->always_running = device_property_read_bool(dev, "always-running");
> -
>  	watchdog_set_drvdata(&priv->wdd, priv);
>  
>  	priv->wdd.info		= &gpio_wdt_ident;
> @@ -184,8 +202,13 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  
>  	watchdog_stop_on_reboot(&priv->wdd);
>  
> -	if (priv->always_running)
> +	if (adopt) {
> +		ret = gpio_wdt_adopt(priv);
> +		if (ret)
> +			return ret;
> +	} else if (priv->always_running) {
>  		gpio_wdt_start(&priv->wdd);
> +	}
>  
>  	return devm_watchdog_register_device(dev, &priv->wdd);
>  }
