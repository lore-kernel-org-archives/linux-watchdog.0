Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47331 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751406Ab1ECJgC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2011 05:36:02 -0400
Date: Tue, 3 May 2011 10:37:04 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jimmy Chen (=?big5?B?s6+lw7lG?=) <jimmy.chen@moxa.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<wim@iguana.be>
Subject: Re: [PATCH 2/2] watchdog: add support for MOXA V2100 watchdog
 driver
Message-ID: <20110503103704.69aba5b2@lxorguk.ukuu.org.uk>
In-Reply-To: <ECB3782BB8F03341905DD923270296115F7124@mhqms01.moxa.com>
References: <ECB3782BB8F03341905DD923270296115F7122@mhqms01.moxa.com>
	<ECB3782BB8F03341905DD923270296115F7124@mhqms01.moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Add real function for watchdog driver

Looks a lot better

> +#define __KERNEL_SYSCALLS__
> +

You shouldn't need that define now


> +	/* we suppose to check magic id in case wrong devices */
> +	if (wdt_verify_vendor()) {
> +		printk(KERN_ERR "hw device id not match!!\n");
> +		ret = -ENODEV;
> +		goto reqreg_err;
> +	}

This wants to happen after the request_region - if the region is busy
then you know your device isn't present but that the addresses in
question are currently in use so you shouldn't touch them

We tend to use pr_err()/pr_debug() etc now rather than printk(KERN_ERR
"Oops"); to be less long winded - but the code you have there isn't wrong
in using printk().

With the tests re-ordered this looks fairly sound to me

Alan
