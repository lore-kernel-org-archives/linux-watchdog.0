Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:45690 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab2JBUH4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Oct 2012 16:07:56 -0400
Date: Tue, 2 Oct 2012 22:07:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: fabio.porcedda@gmail.com
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re:  [PATCH v7 1/3] watchdog: at91sam9_wdt: add device tree
Message-ID: <20121002200753.GA12565@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Date: Tue,  2 Oct 2012 18:01:00 +0200
> From: Fabio Porcedda <fabio.porcedda@gmail.com>
> To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
>         linux-arm-kernel@lists.infradead.org, Nicolas Ferre
>         <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD
>         <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>
> Cc: devicetree-discuss@lists.ozlabs.org
> Subject: [PATCH v7 1/3] watchdog: at91sam9_wdt: add device tree
>         support
> Message-ID:
>         <1349193662-23482-2-git-send-email-fabio.porcedda@gmail.com>
> 
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -32,6 +32,7 @@
>  #include <linux/timer.h>
>  #include <linux/bitops.h>
>  #include <linux/uaccess.h>
> +#include <linux/of.h>
> 
>  #include "at91sam9_wdt.h"
> 
> > @@ -302,11 +303,21 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
>         return res;
>  }
> 
> +#if defined(CONFIG_OF)
> +static const struct of_device_id at91_wdt_dt_ids[] = {
> +       { .compatible = "atmel,at91sam9260-wdt" },
> +       { /* sentinel */ }
> +};

Hi Fabio

You are missing __devinitdata.

    Andrew
