Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:38926 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751615Ab3JZPqQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 26 Oct 2013 11:46:16 -0400
Date: Sat, 26 Oct 2013 17:46:14 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] watchdog: dw_wdt: Add __user annotation
Message-ID: <20131026154614.GA17394@spo001.leaseweb.com>
References: <003101ce8e79$5e7a6670$1b6f3350$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003101ce8e79$5e7a6670$1b6f3350$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> Added __user annotation to fix the following sparse warnings.
> 
> drivers/watchdog/dw_wdt.c:206:38: warning: incorrect type in argument 1 (different address spaces)
> drivers/watchdog/dw_wdt.c:206:38:    expected void [noderef] <asn:1>*to
> drivers/watchdog/dw_wdt.c:206:38:    got struct watchdog_info *<noident>
> drivers/watchdog/dw_wdt.c:211:24: warning: incorrect type in initializer (different address spaces)
> drivers/watchdog/dw_wdt.c:211:24:    expected int const [noderef] <asn:1>*register __p
> drivers/watchdog/dw_wdt.c:211:24:    got int *<noident>
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Added to linux-watchdog-next.

Kind regards,
Wim.

