Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35030 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBUSb5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Feb 2018 13:31:57 -0500
Date: Wed, 21 Feb 2018 10:31:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        jimmy.vance@hpe.com
Subject: Re: [PATCH] watchdog/hpwdt: update maintainer information
Message-ID: <20180221183155.GA14769@roeck-us.net>
References: <20180221092201.8031-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221092201.8031-1-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 21, 2018 at 02:22:01AM -0700, Jerry Hoemann wrote:
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a7f76eadae9..98b2ef91487d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6267,7 +6267,7 @@ S:	Odd Fixes
>  F:	drivers/media/usb/hdpvr/
>  
>  HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
> -M:	Jimmy Vance <jimmy.vance@hpe.com>
> +M:	Jerry Hoemann <jerry.hoemann@hpe.com>
>  S:	Supported
>  F:	Documentation/watchdog/hpwdt.txt
>  F:	drivers/watchdog/hpwdt.c
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
