Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:35406 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568Ab1DZMmX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Apr 2011 08:42:23 -0400
Date: Tue, 26 Apr 2011 14:42:12 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V6] MIPS: lantiq: add watchdog support
Message-ID: <20110426124212.GA17580@infomag.iguana.be>
References: <1303817863-19526-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1303817863-19526-1-git-send-email-blogic@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi John,

> +static int
> +ltq_wdt_open(struct inode *inode, struct file *file)
> +{
> +	if (ltq_wdt_in_use)
> +		return -EBUSY;
> +	ltq_wdt_in_use = 1;
> +	ltq_wdt_enable();
> +
> +	return nonseekable_open(inode, file);
> +}

I prefer to see a test_and_set_bit(ltq_wdt_in_use) and a ...

> +static int
> +ltq_wdt_release(struct inode *inode, struct file *file)
> +{
> +	if (ltq_wdt_ok_to_close)
> +		ltq_wdt_disable();
> +	else
> +		pr_err("ltq_wdt: watchdog closed without warning\n");
> +	ltq_wdt_ok_to_close = 0;
> +	ltq_wdt_in_use = 0;
> +
> +	return 0;
> +}

... clear_bit(ltq_wdt_in_use);

For the rest is looks ok for me. So Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.

