Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:38807
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751555Ab0LGRPK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Dec 2010 12:15:10 -0500
Message-ID: <4CFE6BDF.9030706@freescale.com>
Date: Tue, 7 Dec 2010 15:16:15 -0200
From: Fabio Estevam <fabio.estevam@freescale.com>
MIME-Version: 1.0
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Estevam Fabio-R49496 <r49496@freescale.com>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>,
	<u.kleine-koenig@pengutronix.de>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdogclock
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com> <20101207164905.GD6017@pengutronix.de>
In-Reply-To: <20101207164905.GD6017@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sascha,

On 12/7/2010 2:49 PM, Sascha Hauer wrote:
...
> I should have seen this happen. This breaks i.MX1 reset which uses
> imx-wdt.0.

I think it doesn´t break current mx1 reset mechanism. Please see the 
code below (arcm/arm/plat-mxc/system.c):

	if (cpu_is_mx1()) {
		wcr_enable = (1 << 0);
	} else {
		struct clk *clk;

		clk = clk_get_sys("imx2-wdt.0", NULL);
		if (!IS_ERR(clk))
			clk_enable(clk);
		wcr_enable = (1 << 2);
	}

For mx1 the clk_get_sys function is not called.

Regards,

Fabio Estevam


