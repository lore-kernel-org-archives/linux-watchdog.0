Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:51328 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab3A2InX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Jan 2013 03:43:23 -0500
Received: by mail-we0-f179.google.com with SMTP id x43so121758wey.24
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Jan 2013 00:43:22 -0800 (PST)
Date: Tue, 29 Jan 2013 09:43:13 +0100
From: Fabio Baltieri <fabio.baltieri@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH 3/4] watchdog: add support for ux500_wdt watchdog
Message-ID: <20130129084313.GA20514@balto.lan>
References: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
 <1358509214-22407-4-git-send-email-fabio.baltieri@linaro.org>
 <20130128211222.GA3338@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130128211222.GA3338@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Wim,

thanks for the review!

On Mon, Jan 28, 2013 at 10:12:22PM +0100, Wim Van Sebroeck wrote:
> > +static int timeout = WATCHDOG_TIMEOUT;
> > +module_param(timeout, int, 0);
> > +MODULE_PARM_DESC(timeout,
> > +	"Watchdog timeout in seconds. default="
> > +				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> 
> We should go for unsigned int timeout values...

You're right!  This ends up in an unsigned on the rest of the code
anyway and I see other drivers using it as unsigned so I'll change it in
v2 (here and in ux500_wdt_data).

> 
> > +static int nowayout = WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, int, 0);
> > +MODULE_PARM_DESC(nowayout,
> > +	"Watchdog cannot be stopped once started (default="
> > +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> 
> nowayout is a boolean value so please change this to
> static bool nowayout = WATCHDOG_NOWAYOUT;

Right.

> The rest is OK by me. So if bowayout get's fixed then you have my acked-by.

Ok, I'll send a v2 of this patch soon with both parameters fixed for you
to ack.

Thanks!
Fabio

-- 
Fabio Baltieri
