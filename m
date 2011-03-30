Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:34043 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754218Ab1C3JgU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2011 05:36:20 -0400
Date: Wed, 30 Mar 2011 11:36:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V5 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110330093618.GH3974@infomag.iguana.be>
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org> <1301470076-17279-6-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1301470076-17279-6-git-send-email-blogic@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi John,

> Changes in V2
> * add comments to explain register access
> * cleanup resource allocation
> * cleanup clock handling
> * whitespace fixes
> 
> Changes in V3
> * whitespace
> * change __iomem void to void __iomem
> * typo fixes
> * comment style
> * fix exit path in init function
> 
> Changes in V4
> * fixes register offsets (we use a smaller memory window)
> * typo in the comments
> * add __init to probe function

What were the changes for V5?

> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +static int ltq_wdt_ok_to_close;
> +#endif
...
> +static void
> +ltq_wdt_disable(void)
> +{
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	ltq_wdt_ok_to_close = 0;
> +#endif
> +	/* write the first password magic */
> +	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	/* write the second password magic with no config
> +	 * this turns the watchdog off
> +	 */
> +	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
> +}

Don't like this ifdef/ifndef stuff. The nowayout things can be done in the /dev/watchdog handling.

> +static long
> +ltq_wdt_ioctl(struct file *file,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	int ret = -ENOTTY;
> +
> +	switch (cmd) {
> +	case WDIOC_GETSUPPORT:
> +		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
> +				sizeof(ident)) ? -EFAULT : 0;
> +		break;
> +
> +	case WDIOC_GETTIMEOUT:
> +		ret = put_user(ltq_wdt_timeout, (int __user *)arg);
> +		break;
> +
> +	case WDIOC_SETTIMEOUT:
> +		ret = get_user(ltq_wdt_timeout, (int __user *)arg);
> +		if (!ret)
> +			ltq_wdt_enable(ltq_wdt_timeout);
> +		break;
> +
> +	case WDIOC_KEEPALIVE:
> +		ltq_wdt_enable(ltq_wdt_timeout);
> +		ret = 0;
> +		break;
> +	}
> +	return ret;
> +}

Please add WDIOC_GETSTATUS and WDIOC_GETBOOTSTATUS iotcl calls.

> +static int
> +ltq_wdt_open(struct inode *inode, struct file *file)
> +{
> +	ltq_wdt_enable(ltq_wdt_timeout);
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int
> +ltq_wdt_release(struct inode *inode, struct file *file)
> +{
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	if (ltq_wdt_ok_to_close)
> +		ltq_wdt_disable();
> +	else
> +#endif
> +		pr_err("ltq_wdt: watchdog closed without warning\n");
> +	return 0;
> +}

Please add the code to make sure that /dev/watchdog can be opened once.
The rest I will look into at a later moment.

Kind regards,
Wim.

