Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:44407 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754798Ab2CUTuy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Mar 2012 15:50:54 -0400
Date: Wed, 21 Mar 2012 20:50:49 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jan Beulich <JBeulich@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	xen-devel <xen-devel@lists.xen.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog/xen: don't clear is_active when xen_wdt_stop() failed
Message-ID: <20120321195049.GQ10698@spo001.leaseweb.com>
References: <4F670B3C020000780007935F@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F670B3C020000780007935F@nat28.tlf.novell.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jan,

> xen_wdt_release() shouldn't clear is_active even when the watchdog
> didn't get stopped (which by itself shouldn't happen, but let's return
> a proper error in this case rather than adding a BUG() upon hypercall
> failure).
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> ---
>  drivers/watchdog/xen_wdt.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- 3.3/drivers/watchdog/xen_wdt.c
> +++ 3.3-xen-watchdog-release/drivers/watchdog/xen_wdt.c
> @@ -131,16 +131,18 @@ static int xen_wdt_open(struct inode *in
>  
>  static int xen_wdt_release(struct inode *inode, struct file *file)
>  {
> +	int err = 0;
> +
>  	if (expect_release)
> -		xen_wdt_stop();
> +		err = xen_wdt_stop();
>  	else {
>  		printk(KERN_CRIT PFX
>  		       "unexpected close, not stopping watchdog!\n");
>  		xen_wdt_kick();
>  	}
> -	is_active = false;
> +	is_active = err;
>  	expect_release = false;
> -	return 0;
> +	return err;
>  }
>  
>  static ssize_t xen_wdt_write(struct file *file, const char __user *data,

Just for my understanding:
is_active is a bool value and err is an integer. What values are returned by xen_wdt_stop?

Kind regards,
Wim.

