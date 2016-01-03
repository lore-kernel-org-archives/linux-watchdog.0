Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51261 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbcACPsT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Jan 2016 10:48:19 -0500
Subject: Re: [watchdog-next] watchdog: kill unref/ref ops
To: Tomas Winkler <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1451820757-8840-1-git-send-email-tomas.winkler@intel.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <568942BF.2090402@roeck-us.net>
Date: Sun, 3 Jan 2016 07:48:15 -0800
MIME-Version: 1.0
In-Reply-To: <1451820757-8840-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/03/2016 03:32 AM, Tomas Winkler wrote:
> ref/unref ops are not called at all so even marked them as deprecated
> is misleading, we need to just drop the API.
>
One the other side, the functions are now no-ops, so they don't hurt either.
Only reason for not dropping the functions as part of my series was that
the mei watchdog code was starting to implement them, and I didn't want
to create dependencies for that code. Maybe my thinking was too conservative.

> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

... of course that is no concern anymore since this patch is from its
maintainer.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks!
Guenter

> ---
>   include/linux/watchdog.h | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 850af04fe0c7..aaabd4703b46 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -47,8 +47,6 @@ struct watchdog_ops {
>   	int (*set_timeout)(struct watchdog_device *, unsigned int);
>   	unsigned int (*get_timeleft)(struct watchdog_device *);
>   	int (*restart)(struct watchdog_device *);
> -	void (*ref)(struct watchdog_device *) __deprecated;
> -	void (*unref)(struct watchdog_device *) __deprecated;
>   	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
>   };
>
>

