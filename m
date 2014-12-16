Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49679 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaLPQoz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Dec 2014 11:44:55 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Y0vEz-002wLv-Oa
	for linux-watchdog@vger.kernel.org; Tue, 16 Dec 2014 16:44:55 +0000
Date: Tue, 16 Dec 2014 08:44:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Athira Lekshmi <andnlnbn18@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drivers: watchdog: Fixed missing blank line warning
Message-ID: <20141216164444.GC26966@roeck-us.net>
References: <1418747129-3766-1-git-send-email-andnlnbn18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418747129-3766-1-git-send-email-andnlnbn18@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 16, 2014 at 09:55:22PM +0530, Athira Lekshmi wrote:
> Added a new line after declarations to remove the warning:

'Add', per SubmittingPatches, Chapter 2.

You might also want to add that this is a checkpatch warning
(not a compiler warning).

> 'Missing blank line after declarations'
> 

"drivers" in the subject line of your patches is irrelevant. 
On the other side, the actual drivers you are touching are missing,
resulting in eight identical subject lines. That is not really helpful.

Use something like "watchdog: wdt_pci: ..." to give the maintainer
a hint about the modified driver.

Guenter

> Signed-off-by: Athira Lekshmi <andnlnbn18@gmail.com>
> ---
>  drivers/watchdog/wdt_pci.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
> index 48b2c05..b84a180 100644
> --- a/drivers/watchdog/wdt_pci.c
> +++ b/drivers/watchdog/wdt_pci.c
> @@ -279,6 +279,7 @@ static int wdtpci_get_temperature(int *temperature)
>  {
>  	unsigned short c;
>  	unsigned long flags;
> +
>  	spin_lock_irqsave(&wdtpci_lock, flags);
>  	c = inb(WDT_RT);
>  	udelay(8);
> @@ -366,6 +367,7 @@ static ssize_t wdtpci_write(struct file *file, const char __user *buf,
>  
>  			for (i = 0; i != count; i++) {
>  				char c;
> +
>  				if (get_user(c, buf + i))
>  					return -EFAULT;
>  				if (c == 'V')
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
