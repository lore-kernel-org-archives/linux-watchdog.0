Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99703B83E0
	for <linux-watchdog@vger.kernel.org>; Thu, 13 Aug 2026 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598018; cv=none; b=sP43wjFTB6m9JyBqZlGHXwyYrg5HFv/oJbeF2SX+9RW4LJeFnTfw2O6AsqTxQZoMD8rPojsGsAIdW+MBY+JRfW7VntpdgdTlMGtQhHK/aICwrdAJwV5seYzNrE3QV7Y9AHUidhkfYBJ3Qmuoj1+guMOrnK5Gx0DL/e2Sw9lo+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598018; c=relaxed/simple;
	bh=IC9m1qOo2eEDDpCrLL5Z5b7lMOKpKAwbw5xFCwfwYNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEayjMr7lvcTFxCuw5JYf6Zd7/wXMQ6IfepljL/Kd7+/LT56NiNGW7UqkjN1nkcAuisjMSzO0kRU98UjjbmgPHXVADOtNjTHMCAX17xkj0fP8QapoxXPzbpz9bFDCtk42ZDKppQf73Tw31axOCXBIjOa6miR0wVOPoXuW+CFWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0r5uRfZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0r5uRfZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1714699a91.2
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Aug 2026 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786597981; x=1787202781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DD47gfXQGF6nwCSKbyRAaZ7LXoHHtibmaDJ2ODdpViY=;
        b=c0r5uRfZ4fcYn+iYiUmlNzZiwpxwFxcGFB7d+z+AnotEaKMatyIMlUHa8Gti3amUrO
         phuxT0DD2tylEISTsTEt+u1biAB/ituMnN85ZBeCnRFTP82pkFUDH8abYa/guMRcmnbA
         w5GTfiTpypKjy0ir8WhLWJJN4N/w17t+WkGxGoUEeRwh2d55DuPwkIavqqCDUF2+AXqQ
         sNa19307krPPcysGbuA2jQntao+W+4FE28ORtTOyFUNve+Nb4BjcLNv+jLloZuggZ/Zd
         OyU32mNOYaJnEIt+RVhAUtWp5RX/8XGVrx4dHoOGthi+4id5s8g73AFwoukT6Gdojfwl
         ytOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786597981; x=1787202781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DD47gfXQGF6nwCSKbyRAaZ7LXoHHtibmaDJ2ODdpViY=;
        b=H/1Q5POlZKt20Lx7Ygf8QJ2HFLubMILcMTKGFJmRug9xOe3SVQEEcG+r3rw/gTEopT
         ZINy/poUy9jfXi/U1uOnPvIFDWyVxmNQgx7Z0Jst3PTPlPXXoxBtqK5o5wkOLNKG2+2g
         A8wWIxlwUxUB1Rlw0ZLb2oAofB9DqKVOE8C7myh1saDogHYMTJHRNBidCRJW8FFT04EV
         A0nfI6PedvtWNQCbPpKkzIb+2phpNNyRTU52noBQLRcvdIkX1guc9PeYSuo8no5RoiGV
         esUGVPiz5KMOFPQKmqV1XrkIwQnAGA1BQTTCkFdNKvDAfhHyGWTsFK2L8WgJk/Gx+2XH
         PCeg==
X-Forwarded-Encrypted: i=1; AHgh+RpyBrprF3hcNVUcPy0qO5OsJhSgThR/NEINv9ql7Zh3C+83xST2BCt1QT8PHXt6VSY2O4jilSr6Kt+xeYzJvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlTe+VArKQ0R13Oz5NHi04negyOI3KpIqyKeBpZGY6+TdxxvM
	CwDeLO6Wux/wo8uhIknMTnwudmGFF9Ll0SXTeZkOeF6+unpsJUurQ6ff
X-Gm-Gg: AR+sD11V0LvSDLHhpw50ocTr2691LfuCKJrofrWzBv7dIILwThiGKhXZPIBGVp/J6kr
	vtHFayGltQuk8/llatALVdqjgSiLOnYH7qFYfD4uYUJsruoCQnLpvQD2nZabJfExDopwkIRDaFL
	uhrADKamTOLD2/2YRrVmbLomUxDzJqHXbMmHsvWb7wX8YjOV9/ug35y7LEQLx3Zs/yXQOpyZSO3
	9e6gCF1xU8+948aJ2tHYhwHIUKLE8nXAC1y0rrdW7zRxVNy1T1/3vgTTWjeXq+hunCKEgEn7W4P
	v5q690sutpmDRaPRg7vQuC6J0Nvr8zrSRDf8nYRdu5+Ud22jxnC5MJrrPlsu+aqGqHCJSstAytD
	LGbGwmPcAcpvGT20+FKh3oKlVFGccFfscBAdVJJj4pXe7kwUMXxNJG2PQOtmpLRmqPXst7M1PYf
	20jw9xK466WvRX/vrqUXQ9lQZTzeibgm3H1//7cMUIMbnmbkF+/6ITDPIg5MtxRUQ66hEvJRJPd
	g==
X-Received: by 2002:a17:90b:180c:b0:37c:6130:7a5b with SMTP id 98e67ed59e1d1-3931e07548bmr3673397a91.8.1786597980659;
        Wed, 12 Aug 2026 22:13:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f41cd2fsm1324751a91.12.2026.08.12.22.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:13:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Aug 2026 22:12:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Zexin Wang <ot_zexin.wang@mediatek.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	light.chen@mediatek.com, Fred-WY.Chen@mediatek.com,
	Yt.Hsieh@mediatek.com, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] watchdog: sbsa_gwdt: add early_enable module parameter
Message-ID: <27ebd686-c5de-4abf-9683-6a700b7592bc@roeck-us.net>
References: <20260813041228.23084-1-ot_zexin.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813041228.23084-1-ot_zexin.wang@mediatek.com>

On Thu, Aug 13, 2026 at 12:12:18PM +0800, Zexin Wang wrote:
> On SBSA platforms using standard UEFI firmware (such as EDK II), the
> watchdog timer is often enabled during early boot stages but explicitly
> disabled by the firmware before handing over control to the OS (e.g.,
> during ExitBootServices). This is done to prevent unintended resets
> while the OS is loading, assuming the OS watchdog driver will take over.
> 
> However, this leaves a protection gap. If the system hangs between the
> firmware handover and the userspace watchdog daemon startup, the hardware
> watchdog will not fire to recover the system. For safety-critical systems
> that require continuous hardware watchdog protection from the earliest
> possible moment, this gap is problematic.
> 
> Add an 'early_enable' module parameter to allow the kernel driver to
> re-enable the watchdog immediately during probe if it was left disabled
> by the firmware. By setting the WDOG_HW_RUNNING status bit, the watchdog
> core is instructed that the hardware is active. As a result, the core's
> pre-userspace handler (controlled by 'handle_boot_enabled') will
> automatically issue periodic keepalives until userspace opens the device.
> 
> This bridges the protection gap seamlessly without requiring firmware
> modifications and without risking unintended resets during kernel boot.
> 
> The parameter defaults to false to preserve the traditional behavior.
> 
> Signed-off-by: Zexin Wang <ot_zexin.wang@mediatek.com>

You might want to wait a few minutes before sending new versions
of a patch.

> ---
> Changes in v3:
> - Fix indentation of `early_enable` in watchdog-parameters.rst to ensure
>   it renders as a separate parameter rather than part of `nowayout`'s
>   description.
> 
> Changes in v2:
> - Rename `force_enable` to `early_enable` as suggested by Guenter.
> - Update commit message to explain the UEFI handover gap motivation.
> - Add documentation for the new parameter.
> 
>  .../watchdog/watchdog-parameters.rst          |  2 ++
>  drivers/watchdog/sbsa_gwdt.c                  | 23 +++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
> index 502cb6adbeda..348229ffcb43 100644
> --- a/Documentation/watchdog/watchdog-parameters.rst
> +++ b/Documentation/watchdog/watchdog-parameters.rst
> @@ -515,6 +515,8 @@ sbsa_gwdt:
>      nowayout:
>  	Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
> +    early_enable:
> +	Watchdog is started on module insertion (default=0)
>  
>  -------------------------------------------------
>  
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index e04d42cc7774..ed913be3d1cb 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -122,6 +122,11 @@ MODULE_PARM_DESC(nowayout,
>  		 "Watchdog cannot be stopped once started (default="
>  		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +static bool early_enable;
> +module_param(early_enable, bool, 0);
> +MODULE_PARM_DESC(early_enable,
> +		 "Watchdog is started on module insertion (default=0)");
> +
>  /*
>   * Arm Base System Architecture 1.0 introduces watchdog v1 which
>   * increases the length watchdog offset register to 48 bits.
> @@ -296,6 +301,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>  	struct sbsa_gwdt *gwdt;
>  	int ret, irq;
>  	u32 status;
> +	bool early_action;
>  
>  	gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
>  	if (!gwdt)
> @@ -386,14 +392,27 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>  	 */
>  	sbsa_gwdt_set_timeout(wdd, wdd->timeout);
>  
> +	early_action = early_enable && !(status & SBSA_GWDT_WCS_EN);
> +	if (early_action) {
> +		sbsa_gwdt_start(wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +		dev_info(dev, "Watchdog early enabled.\n");

Still unnecessary noise.

> +	}
> +
>  	watchdog_stop_on_reboot(wdd);
>  	ret = devm_watchdog_register_device(dev, wdd);
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "Failed to register watchdog: %d\n", ret);

Still unrelated.

> +		if (early_action) {
> +			clear_bit(WDOG_HW_RUNNING, &wdd->status);

Still pointless / unnecessary.

> +			sbsa_gwdt_stop(wdd);
> +		}
>  		return ret;
> +	}
>  
>  	dev_info(dev, "Initialized with %ds timeout @ %u Hz, action=%d.%s\n",
>  		 wdd->timeout, gwdt->clk, action,
> -		 status & SBSA_GWDT_WCS_EN ? " [enabled]" : "");
> +		 watchdog_hw_running(wdd) ? " [enabled]" : "");
>  
>  	return 0;
>  }
