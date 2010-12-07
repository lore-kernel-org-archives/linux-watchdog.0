Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45915 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab0LGSuK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Dec 2010 13:50:10 -0500
Date: Tue, 7 Dec 2010 19:50:02 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	u.kleine-koenig@pengutronix.de, wim@iguana.be,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: imx: use clk_get to acquire the
	watchdogclock
Message-ID: <20101207185002.GE6017@pengutronix.de>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com> <20101207164905.GD6017@pengutronix.de> <4CFE6BDF.9030706@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4CFE6BDF.9030706@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 07, 2010 at 03:16:15PM -0200, Fabio Estevam wrote:
> Hi Sascha,
>
> On 12/7/2010 2:49 PM, Sascha Hauer wrote:
> ...
>> I should have seen this happen. This breaks i.MX1 reset which uses
>> imx-wdt.0.
>
> I think it doesn´t break current mx1 reset mechanism. Please see the  
> code below (arcm/arm/plat-mxc/system.c):
>
> 	if (cpu_is_mx1()) {
> 		wcr_enable = (1 << 0);
> 	} else {
> 		struct clk *clk;
>
> 		clk = clk_get_sys("imx2-wdt.0", NULL);
> 		if (!IS_ERR(clk))
> 			clk_enable(clk);
> 		wcr_enable = (1 << 2);
> 	}
>
> For mx1 the clk_get_sys function is not called.

Oh, you are right. In this case your patch is ok.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
