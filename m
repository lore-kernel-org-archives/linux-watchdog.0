Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:36199 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758736AbcAKV2F (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jan 2016 16:28:05 -0500
Date: Mon, 11 Jan 2016 22:28:01 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: Re: [watchdog-next] watchdog: kill unref/ref ops
Message-ID: <20160111212801.GC6613@spo001.leaseweb.nl>
References: <1451820757-8840-1-git-send-email-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451820757-8840-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomas,

> ref/unref ops are not called at all so even marked them as deprecated
> is misleading, we need to just drop the API.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  include/linux/watchdog.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 850af04fe0c7..aaabd4703b46 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -47,8 +47,6 @@ struct watchdog_ops {
>  	int (*set_timeout)(struct watchdog_device *, unsigned int);
>  	unsigned int (*get_timeleft)(struct watchdog_device *);
>  	int (*restart)(struct watchdog_device *);
> -	void (*ref)(struct watchdog_device *) __deprecated;
> -	void (*unref)(struct watchdog_device *) __deprecated;
>  	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
>  };
>  
> -- 
> 2.4.3
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

