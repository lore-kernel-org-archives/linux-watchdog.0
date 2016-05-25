Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55731 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbcEYR3r (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 13:29:47 -0400
Date: Wed, 25 May 2016 10:29:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Boylston <brian.boylston@hpe.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MAINTAINERS: add entry for HPE watchdog driver
Message-ID: <20160525172952.GA19545@roeck-us.net>
References: <20160525161954.3354-1-brian.boylston@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160525161954.3354-1-brian.boylston@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 25, 2016 at 11:19:54AM -0500, Brian Boylston wrote:
> Add a maintainer for the HPE watchdog driver
> 
> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 804bc4f..520e306 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5130,6 +5130,12 @@ T:	git git://linuxtv.org/anttip/media_tree.git
>  S:	Maintained
>  F:	drivers/media/dvb-frontends/hd29l2*
>  
> +HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
> +M:	Brian Boylston <brian.boylston@hpe.com>
> +S:	Supported
> +F:	Documentation/watchdog/hpwdt.txt
> +F:	drivers/watchdog/hpwdt.c
> +
>  HEWLETT-PACKARD SMART ARRAY RAID DRIVER (hpsa)
>  M:	Don Brace <don.brace@microsemi.com>
>  L:	iss_storagedev@hp.com
> -- 
> 2.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
