Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:47923 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757816Ab3EYUDy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 May 2013 16:03:54 -0400
Date: Sat, 25 May 2013 22:03:52 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 2/5] watchdog: imx2_wdt: use devm_clk_get()
Message-ID: <20130525200352.GA13370@spo001.leaseweb.com>
References: <000301ce44ba$266397b0$732ac710$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301ce44ba$266397b0$732ac710$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> Use devm_clk_get() to make cleanup paths more simple.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/imx2_wdt.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.

