Return-path: <wsa@the-dreams.de>
Date: Fri, 1 Apr 2016 13:36:30 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: renesas-wdt: add driver
Message-ID: <20160401113629.GA2513@katana>
References: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
 <1459351725-14144-2-git-send-email-wsa@the-dreams.de>
 <20160330233411.GA24844@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160330233411.GA24844@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> > +static bool nowayout = WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, bool, S_IRUGO);
> 
> Sure you want this parameter readable ? No problem with me, but it is unusual,
> so I figure it is worth asking.

No reason, will stick to the usual case.

> > +static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned reg)
> 
> Please use 'unsigned int' throughout.

Can do. May I ask why?

> > +	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
> > +
> 
> Just wondering, does reading RWTCNT return the remaining timeout ?
> If so, you could easily implement WDIOC_GETTIMEOUT.

I assume you mean GETTIMELEFT. Tried that, seems to work.

> function. In other words, you can just drop rwdt_set_timeout() entirely.

Cool news! Works fine.

Thanks for the prompt review! Will send V2 in a minute.

   Wolfram
