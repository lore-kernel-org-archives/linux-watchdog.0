Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48157 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbcB2Eps (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 23:45:48 -0500
Date: Sun, 28 Feb 2016 20:45:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v7, RESEND] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
Message-ID: <20160229044546.GA31388@roeck-us.net>
References: <20160229042910.GA23468@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160229042910.GA23468@sophia>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi William,

On Sun, Feb 28, 2016 at 11:29:10PM -0500, William Breathitt Gray wrote:
> The WinSystems EBC-C384 has an onboard watchdog timer. The timeout range
> supported by the watchdog timer is 1 second to 255 minutes. Timeouts
> under 256 seconds have a 1 second granularity, while the rest have a 1
> minute granularity.
> 
> This driver adds watchdog timer support for this onboard watchdog timer.
> The timeout may be configured via the timeout module parameter.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  MAINTAINERS                     |   6 ++
>  drivers/watchdog/Kconfig        |   9 ++
>  drivers/watchdog/Makefile       |   1 +
>  drivers/watchdog/ebc-c384_wdt.c | 188 ++++++++++++++++++++++++++++++++++++++++
> 
[ ... ]

> +
> +static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
> +{
> +	/* resolution is in minutes for timeouts greater than 255 seconds */
> +	if (t > 255) {
> +		/* round second resolution up to minute granularity */
> +		wdev->timeout = DIV_ROUND_UP(t, 60) * 60;

Good catch.

Turns out there is a much better macro for this:
		wdev->timeout = roundup(t, 60);

Guenter
