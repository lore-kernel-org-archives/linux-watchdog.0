Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45147 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeLQUH6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Dec 2018 15:07:58 -0500
Date: Mon, 17 Dec 2018 12:07:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] watchdog: docs: kernel-api: don't reference removed
 functions
Message-ID: <20181217200755.GA29585@roeck-us.net>
References: <20181217191411.3254-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217191411.3254-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 17, 2018 at 08:14:11PM +0100, Wolfram Sang wrote:
> Those functions are not only deprecated, but gone for good.
> 
> Fixes: 62cd1c40ce1c ("watchdog: kill unref/ref ops")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/watchdog-kernel-api.txt | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index 9b93953f69cf..3a91ef5af044 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -128,8 +128,6 @@ struct watchdog_ops {
>  	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
>  	unsigned int (*get_timeleft)(struct watchdog_device *);
>  	int (*restart)(struct watchdog_device *);
> -	void (*ref)(struct watchdog_device *) __deprecated;
> -	void (*unref)(struct watchdog_device *) __deprecated;
>  	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
>  };
>  
> @@ -218,8 +216,6 @@ they are supported. These optional routines/operations are:
>    if a command is not supported. The parameters that are passed to the ioctl
>    call are: watchdog_device, cmd and arg.
>  
> -The 'ref' and 'unref' operations are no longer used and deprecated.
> -
>  The status bits should (preferably) be set with the set_bit and clear_bit alike
>  bit-operations. The status bits that are defined are:
>  * WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
> -- 
> 2.19.1
> 
