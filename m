Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:49111 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750718AbcCFUdi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 6 Mar 2016 15:33:38 -0500
Date: Sun, 6 Mar 2016 21:33:32 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] watchdog: pnx833x_wdt: fix typo in MODULE_PARM_DESC
Message-ID: <20160306203331.GA6048@spo001.leaseweb.nl>
References: <20160108110239.GI32195@mwanda> <568FCC65.6010106@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568FCC65.6010106@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

> On 01/08/2016 03:02 AM, Dan Carpenter wrote:
> >The module_param() is "pnx833x_wdt_timeout" and MODULE_PARM_DESC()
> >should match.
> >
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> >diff --git a/drivers/watchdog/pnx833x_wdt.c 
> >b/drivers/watchdog/pnx833x_wdt.c
> >index 882fdcb..69da25a 100644
> >--- a/drivers/watchdog/pnx833x_wdt.c
> >+++ b/drivers/watchdog/pnx833x_wdt.c
> >@@ -52,8 +52,9 @@ static int pnx833x_wdt_alive;
> >  /* Set default timeout in MHZ.*/
> >  static int pnx833x_wdt_timeout = PNX_WATCHDOG_TIMEOUT;
> >  module_param(pnx833x_wdt_timeout, int, 0);
> >-MODULE_PARM_DESC(timeout, "Watchdog timeout in Mhz. (68Mhz clock), 
> >default="
> >-			__MODULE_STRING(PNX_TIMEOUT_VALUE) "(30 seconds).");
> >+MODULE_PARM_DESC(pnx833x_wdt_timeout,
> >+		 "Watchdog timeout in Mhz. (68Mhz clock), default="
> >+		 __MODULE_STRING(PNX_TIMEOUT_VALUE) "(30 seconds).");
> 
> The intent here was to have a module parameter named 'timeout'.
> Of course that was never the case. Wonder if anyone ever noticed.
> The correct fix would be to use something like
> 	module_param_named(timeout, pnx833x_wdt_timeout, int, 0);
> but of course that would change the ABI. On the other side,
> 'timeout' is the documented module parameter in
> Documentation/watchdog/watchdog-parameters.txt, so one could argue
> that using module_param_named() would be a bug fix and not an ABI change.
> 
> Not really sure what the best approach is here. Wim, any comments ?
> Provide module_param_named() in _addition_ to the existing module_param(),
> maybe, if that is possible ?
> 

I would keep the userspace variable the same.
So keep: MODULE_PARM_DESC(timeout, "Watchdog timeout in Mhz. (68Mhz clock),
and fix the internal variables...

That will give us no userspace changes and no additional fixes.

Kind regards,
Wim.

