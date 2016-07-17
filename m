Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43709 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751188AbcGQTp2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 15:45:28 -0400
Date: Sun, 17 Jul 2016 21:45:26 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Brian Boylston <brian.boylston@hpe.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: hpwdt: remove email address from doc
Message-ID: <20160717194526.GA32689@spo001.leaseweb.nl>
References: <20160525162015.3442-1-brian.boylston@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160525162015.3442-1-brian.boylston@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Brian,

> Remove Tom's email address from the documentation
> 
> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
> ---
>  Documentation/watchdog/hpwdt.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
> index a40398c..7a9f635 100644
> --- a/Documentation/watchdog/hpwdt.txt
> +++ b/Documentation/watchdog/hpwdt.txt
> @@ -1,9 +1,9 @@
> -Last reviewed: 04/04/2016
> +Last reviewed: 05/20/2016
>  
>                       HPE iLO NMI Watchdog Driver
>                NMI sourcing for iLO based ProLiant Servers
>                       Documentation and Driver by
> -              Thomas Mingarelli <thomas.mingarelli@hpe.com>
> +                         Thomas Mingarelli
>  
>   The HPE iLO NMI Watchdog driver is a kernel module that provides basic
>   watchdog functionality and the added benefit of NMI sourcing. Both the
> @@ -95,4 +95,3 @@ Last reviewed: 04/04/2016
>  
>  
>   -- Tom Mingarelli
> -    (thomas.mingarelli@hpe.com)
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

