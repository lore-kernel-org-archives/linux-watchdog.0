Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43710 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751174AbcGQTqb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 15:46:31 -0400
Date: Sun, 17 Jul 2016 21:46:29 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Brian Boylston <brian.boylston@hpe.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MAINTAINERS: add entry for HPE watchdog driver
Message-ID: <20160717194629.GB32689@spo001.leaseweb.nl>
References: <20160525161954.3354-1-brian.boylston@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160525161954.3354-1-brian.boylston@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Brian,

> Add a maintainer for the HPE watchdog driver
> 
> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
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

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

