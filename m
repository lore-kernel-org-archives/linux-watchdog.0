Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56015 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbcEYRaE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 13:30:04 -0400
Date: Wed, 25 May 2016 10:30:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Boylston <brian.boylston@hpe.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: hpwdt: remove email address from doc
Message-ID: <20160525173009.GB19545@roeck-us.net>
References: <20160525162015.3442-1-brian.boylston@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160525162015.3442-1-brian.boylston@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 25, 2016 at 11:20:15AM -0500, Brian Boylston wrote:
> Remove Tom's email address from the documentation
> 
> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
