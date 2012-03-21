Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:16392 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab2CUR2X (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Mar 2012 13:28:23 -0400
Date: Wed, 21 Mar 2012 13:23:57 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jan Beulich <JBeulich@suse.com>, wim@iguana.be
Cc: wim@iguana.be, xen-devel <xen-devel@lists.xen.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog/xen: don't clear is_active when xen_wdt_stop()
 failed
Message-ID: <20120321172357.GB5923@phenom.dumpdata.com>
References: <4F670B3C020000780007935F@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F670B3C020000780007935F@nat28.tlf.novell.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 19, 2012 at 09:32:28AM +0000, Jan Beulich wrote:
> xen_wdt_release() shouldn't clear is_active even when the watchdog
> didn't get stopped (which by itself shouldn't happen, but let's return
> a proper error in this case rather than adding a BUG() upon hypercall
> failure).
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Looks good to me too. Wim, want me to carry it for 3.4?

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
> 
> 
