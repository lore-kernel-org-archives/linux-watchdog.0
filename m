Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:50574 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab2CUR2K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Mar 2012 13:28:10 -0400
Date: Wed, 21 Mar 2012 13:23:32 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jan Beulich <JBeulich@suse.com>, wim@iguana.be
Cc: wim@iguana.be, Ian Campbell <ian.campbell@citrix.com>,
	Wouter de Geus <benv-xensource.com@junerules.com>,
	xen-devel <xen-devel@lists.xen.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog/xen: don't unconditionally enable the watchdog
 during resume
Message-ID: <20120321172332.GA5923@phenom.dumpdata.com>
References: <4F670AC9020000780007934F@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F670AC9020000780007934F@nat28.tlf.novell.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 19, 2012 at 09:30:33AM +0000, Jan Beulich wrote:
> This was found to be a problem particularly after guest migration.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Reported-by: Wouter de Geus <benv-xensource.com@junerules.com>
> Reported-by: Ian Campbell <Ian.Campbell@citrix.com>
> Tested-by: Wouter de Geus <benv-xensource.com@junerules.com>

Looks good to me.

Wim, would you like me to carry it for 3.4 or are you OK doing it?

Thanks!
> 
> ---
>  drivers/watchdog/xen_wdt.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- 3.3/drivers/watchdog/xen_wdt.c
> +++ 3.3-xen-watchdog-resume/drivers/watchdog/xen_wdt.c
> @@ -299,11 +299,18 @@ static void xen_wdt_shutdown(struct plat
>  
>  static int xen_wdt_suspend(struct platform_device *dev, pm_message_t state)
>  {
> -	return xen_wdt_stop();
> +	typeof(wdt.id) id = wdt.id;
> +	int rc = xen_wdt_stop();
> +
> +	wdt.id = id;
> +	return rc;
>  }
>  
>  static int xen_wdt_resume(struct platform_device *dev)
>  {
> +	if (!wdt.id)
> +		return 0;
> +	wdt.id = 0;
>  	return xen_wdt_start();
>  }
>  
> 
> 
