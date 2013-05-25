Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:47918 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757750Ab3EYTvY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 May 2013 15:51:24 -0400
Date: Sat, 25 May 2013 21:51:23 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 1/5] watchdog: dw_wdt: use devm_clk_get()
Message-ID: <20130525195123.GA13203@spo001.leaseweb.com>
References: <000201ce44ba$160fc0a0$422f41e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201ce44ba$160fc0a0$422f41e0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> Use devm_clk_get() to make cleanup paths more simple.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/dw_wdt.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.
