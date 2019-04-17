Return-Path: <SRS0=uGyo=ST=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B136C282DA
	for <linux-watchdog@archiver.kernel.org>; Wed, 17 Apr 2019 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB0320663
	for <linux-watchdog@archiver.kernel.org>; Wed, 17 Apr 2019 18:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlBF+eN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfDQSF6 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:05:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33091 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDQSF6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 17 Apr 2019 14:05:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so12377717pgh.0;
        Wed, 17 Apr 2019 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TylyuSSJFZXFF5azrzu30Zk32Cd0PF6Dt+BQjglTV3g=;
        b=SlBF+eN5VBpDaB2YZe16O7Agkywy8wvv0ZHZ9Wv1AFhS0Z8VymIsnxl4QjR318bHEl
         btUmhnxUSJTRmK/BwxdqIfZTAshZyP25/oHYDSJhF9fCVuQxjKzUlzSsd3ssCebOnADj
         wL0PBbs1reeftgQeb8SsGzLmkb+8+DnQ8BoRHocusXltg9Ulu6T0myQV1ZK6xu+ehqCH
         L763954erPFoRZ2lc3+r2lby+tgFM+w02e3pha8W1hhQMnPx0MlEQzFUIizv4GG5fqPw
         37dp/1QEDnJLIACRG8w/TVcCU3AYTAm232cM7xzGbEknFATbAHJeufLgGq69tfnpvXFK
         nEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TylyuSSJFZXFF5azrzu30Zk32Cd0PF6Dt+BQjglTV3g=;
        b=gWwiN7ahVtIMYP1BIxeJaim0OugKq4oXyps4zflXcBj6s22er/Zw2xj9xrRPcoyGBX
         YdF4ukHndPMeskRU1EExa/d8rw2zvscFnNFOL0OmwmuAl4HyKTRhiuH1/G/veE1/LhVM
         AJ/6EmMU80Lc22gZaWUxZqme0V4HvFpZ7PcjTAWjqn9ZhpY9/YnyNoBtdmYICjB0xnqA
         hLpiZAOSBpwZVucnnBhx2yA5Gzg+koJUwyDFQ3jXzcrTE+Pv4skXifCKijQuFDjzgrv9
         djdCOQXd3phUEhDi17kBJC9ZMP74BvImYdECqvHM8KNp/6AilDEr1H64BJB2axpAgekw
         AVPw==
X-Gm-Message-State: APjAAAUNaAegXYxpFnOJr2yYLt/fdL8VI6JR5cF2kB51XHpmkyOVhUpf
        Hm8MEb/gbmC7pucLVxbPaKM9N2LD
X-Google-Smtp-Source: APXvYqzvqbu+iIOZpGFwLMvyCmwisJYdK0nid6CMLRS0oGg2beuIRg8jtzjPWSQ8pK9BZFD9s0r/7Q==
X-Received: by 2002:a63:6503:: with SMTP id z3mr77480785pgb.113.1555524357800;
        Wed, 17 Apr 2019 11:05:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h65sm147298349pfd.108.2019.04.17.11.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:05:57 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:05:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH] watchdog: renesas_wdt: support handover from
 bootloader
Message-ID: <20190417180556.GA18401@roeck-us.net>
References: <20190415105201.2078-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415105201.2078-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, Apr 15, 2019 at 12:52:01PM +0200, Wolfram Sang wrote:
> Support an already running watchdog by checking its enable bit and set
> up the status accordingly before registering the device.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> This patch was tested using a Renesas Salvator XS board (R-Car M3N). It works.
> However, there is a small window where the watchdog clock is disabled, namely
> after the MSSR clock driver initializes it until RuntimePM of the watchdog
> driver takes over. If the system hangs in this window, bad luck. So, I'd think
> it makes sense to have this clock either always-on or to keep the state which
> came from the firmware. Geert, what do you think?
> 
>  drivers/watchdog/renesas_wdt.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 565dbc1ec638..37d757288b22 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -179,6 +179,7 @@ static int rwdt_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	unsigned long clks_per_sec;
>  	int ret, i;
> +	u8 csra;
>  
>  	if (rwdt_blacklisted(&pdev->dev))
>  		return -ENODEV;
> @@ -198,8 +199,8 @@ static int rwdt_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_get_sync(&pdev->dev);
>  	priv->clk_rate = clk_get_rate(clk);
> -	priv->wdev.bootstatus = (readb_relaxed(priv->base + RWTCSRA) &
> -				RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
> +	csra = readb_relaxed(priv->base + RWTCSRA);
> +	priv->wdev.bootstatus = csra & RWTCSRA_WOVF ? WDIOF_CARDRESET : 0;
>  	pm_runtime_put(&pdev->dev);
>  
>  	if (!priv->clk_rate) {
> @@ -237,6 +238,16 @@ static int rwdt_probe(struct platform_device *pdev)
>  	/* This overrides the default timeout only if DT configuration was found */
>  	watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
>  
> +	if (csra & RWTCSRA_TME) {
> +		/* Ensure properly initialized dividers */
> +		rwdt_start(&priv->wdev);
> +		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
> +		//FIXME: We are missing pm_runtime_put in some code paths to
> +		// to balance PM calls. We first need to decide if we maybe
> +		// should have the RWDT clock always-on or if using RPM for
> +		// clock management is OK.

Maybe I am missing something, but ..

Is handover even possible if the clock is controlled by clock management ?
Seems to me the clock would then be turned off through pm, which effectively
turns off the watchdog. So it will be off between clock/pm initialization
and the above code, meaning wdt handover from the boot loader is for all
practical purposes useless if the kernel gets stuck in between.

Thanks,
Guenter

> +	}
> +
>  	ret = watchdog_register_device(&priv->wdev);
>  	if (ret < 0)
>  		goto out_pm_disable;
> -- 
> 2.11.0
> 
