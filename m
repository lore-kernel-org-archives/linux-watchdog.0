Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56561 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751624AbaEZVKY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 17:10:24 -0400
Date: Mon, 26 May 2014 23:10:22 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, arun.ramamurthy@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: sp805: Set watchdog_device->timeout from ->set_timeout()
Message-ID: <20140526211022.GA23751@spo001.leaseweb.com>
References: <c78a7ad282aff9bd1b88c55c2590438e17ef95e1.1400127943.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78a7ad282aff9bd1b88c55c2590438e17ef95e1.1400127943.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Viresh,

> Implementation of ->set_timeout() is supposed to set 'timeout' field of 'struct
> watchdog_device' passed to it. sp805 was rather setting this in a local
> variable. Fix it.
> 
> Cc: <stable@vger.kernel.org> # 2.6.36+
> Reported-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Greg,
> 
> This driver was introduced in 2.6.36 and WDIOC_GETTIMEOUT is broken since then.
> So added it for such an old stable release. Not sure if it should only be worth
> applying to 3.0+
> 
>  drivers/watchdog/sp805_wdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

