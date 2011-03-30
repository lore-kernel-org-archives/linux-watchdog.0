Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42920 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230Ab1C3OfL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2011 10:35:11 -0400
Received: by yxs7 with SMTP id 7so537110yxs.19
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Mar 2011 07:35:10 -0700 (PDT)
Date: Wed, 30 Mar 2011 08:35:07 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] mpc8xxx_wdt: fix build
Message-ID: <20110330143507.GC13685@ponder.secretlab.ca>
References: <1301492902-12343-1-git-send-email-jacmet@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1301492902-12343-1-git-send-email-jacmet@sunsite.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 30, 2011 at 03:48:22PM +0200, Peter Korsgaard wrote:
> Since 1c48a5c93da6313 (dt: Eliminate of_platform_{,un}register_driver)
> mpc8xxx_wdt no longer builds as it tries to refer to a 'match' variable
> rather than ofdev->dev.of_match that it checks just before.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/watchdog/mpc8xxx_wdt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 6709d72..528bceb 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -195,7 +195,7 @@ static int __devinit mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  
>  	if (!ofdev->dev.of_match)
>  		return -EINVAL;
> -	wdt_type = match->data;
> +	wdt_type = ofdev->dev.of_match->data;
>  
>  	if (!freq || freq == -1)
>  		return -EINVAL;
> -- 
> 1.7.2.3
> 
