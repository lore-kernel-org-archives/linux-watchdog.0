Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39361 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751495Ab3J2IA1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 04:00:27 -0400
Date: Tue, 29 Oct 2013 09:00:25 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 1/1] watchdog: Fix a trivial typo
Message-ID: <20131029080025.GJ19704@spo001.leaseweb.com>
References: <1382950037-19682-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1382950037-19682-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> Fixed a trivial typo.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/watchdog/watchdog_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 05d18b4..461336c 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -77,7 +77,7 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>  
>  	watchdog_check_min_max_timeout(wdd);
>  
> -	/* try to get the tiemout module parameter first */
> +	/* try to get the timeout module parameter first */
>  	if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
>  		wdd->timeout = timeout_parm;
>  		return ret;

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

