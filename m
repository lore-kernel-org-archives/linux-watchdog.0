Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:52851 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdAIKzc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jan 2017 05:55:32 -0500
Subject: Re: [PATCH 0/3] watchdog: imx2: handle WMCR only being available on
 i.MX35 and later
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <19492fdf-a0f7-8525-f955-8c9136575659@mleia.com>
Date: Mon, 9 Jan 2017 12:55:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Uwe,

On 01/09/2017 11:50 AM, Uwe Kleine-König wrote:
> Hello,
> 
> this is my approach to fix the issue reported by Vladimir Zapolskiy.
> 
> IMHO we don't need the third commit because I'm convinced most machines
> just don't do anything when the WDOG signal becomes active. An affected
> machine powers off 16 seconds after startup. This would be noticed
> during development of the bootloader and so I assume all affected
> machines having bootloaders that make the compat code unimportant.
> 
> If you want to know if your machine is affected, do:
> 
> 	mw -w $(watchdog_base_addr) 0x10

is it a command in barebox shell?

> The machines I tested this on (among a few customer boards a
> Phycore i.MX35 and a Freescale i.MX53 Quick Start Board) don't power off.
> 
> I don't have manuals handy for ls1021a, ls1043a and ls1046a but assume
> they use the i.MX35 type, too. This needs to be fixed before this series
> is applied.
> 
> Compared to Vladimir's patch machines still using board files are fixed,
> too.
> 

This addition can be done on top of my changes, in my version the driver
ignores WMCR on all machines with board files.

So now we have two competing series unfortunately...

--
With best wishes,
Vladimir
