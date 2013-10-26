Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:38932 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751615Ab3JZPqq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 26 Oct 2013 11:46:46 -0400
Date: Sat, 26 Oct 2013 17:46:45 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Kevin Strasser' <kevin.strasser@linux.intel.com>
Subject: Re: [PATCH 1/2] watchdong: kempld_wdt: Add __user annotation
Message-ID: <20131026154645.GB17394@spo001.leaseweb.com>
References: <003201ce8e79$885e46f0$991ad4d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003201ce8e79$885e46f0$991ad4d0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> Added __user annotation to fix the following sparse warnings.
> Also, it makes 'kempld_prescaler' static because it is used
> only in this file.
> 
> drivers/watchdog/kempld_wdt.c:70:11: warning: symbol 'kempld_prescaler' was not declared. Should it be static?
> drivers/watchdog/kempld_wdt.c:364:23: warning: incorrect type in initializer (different address spaces)
> drivers/watchdog/kempld_wdt.c:364:23:    expected int const [noderef] <asn:1>*register __p
> drivers/watchdog/kempld_wdt.c:364:23:    got int *<noident>
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Added to linux-watchdog-next.

Kind regards,
Wim.

