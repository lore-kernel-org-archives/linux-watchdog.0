Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34444 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbdACPrz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 10:47:55 -0500
Received: by mail-io0-f194.google.com with SMTP id n85so30779847ioi.1
        for <linux-watchdog@vger.kernel.org>; Tue, 03 Jan 2017 07:47:54 -0800 (PST)
Subject: Re: [PATCH] watchdog: gpio: Add "keep-armed-on-close" feature
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <1482258332.13119.16.camel@localhost>
References: <1481139980-13429-1-git-send-email-slemieux.tyco@gmail.com>
         <20161209210712.GA14339@roeck-us.net> <1481823963.26329.23.camel@localhost>
         <1482258332.13119.16.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Jan 2017 10:20:50 -0500
Message-ID: <1483456850.7643.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 2016-12-20 at 13:25 -0500, Sylvain Lemieux wrote:
> Hi Guenter,
> 
> On Thu, 2016-12-15 at 12:46 -0500, Sylvain Lemieux wrote:
> > Hi Guenter,
> > 
> > On Fri, 2016-12-09 at 13:07 -0800, Guenter Roeck wrote:
> > > On Wed, Dec 07, 2016 at 02:46:20PM -0500, Sylvain Lemieux wrote:
> > > > From: Sylvain Lemieux <slemieux@tycoint.com>
> > > > 
> > > > There is a need to allow a grace period after the watchdog software
> > > > client has closed. It could be used for syncing the filesystem or
> > > > allow graceful termination while still providing a hardware reset
> > > > in case the system has hung.
> > > > 
> > > > The "always-running" configuration from device-tree does not provide
> > > > this since it will automatically keep the hardware watchdog alive as
> > > > soon as the software client closes (i.e. keep toggling the GPIO line
> > > > regardless of the state of the soft part of the watchdog).
> > > > 
> > > > The "keep-armed-on-close" member in the GPIO watchdog implementation
> > > > indicates if an expired timeout should cause a reset.
> > > > 
> > > > This patch add a new "keep-armed-on-close" device-tree configuration
> > > > that will keep the watchdog "armed" until the next timeout period after
> > > > a close. During this period, the hardware watchdog is kept alive.
> > > > 
> > > > A software watchdog client that wants to provide a grace period,
> > > > before a hard reset, can set the timeout before properly closing.
> > > > 
> > > > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > > 
> > > Rather than changing the current gpio watchdog code, I would prefer to start
> > > with https://lkml.org/lkml/2016/1/26/517, which moves part of its code into
> > > the watchdog core - even more so here since I suspect that the suggested
> > > changes won't work anymore after the above patch is applied.
> > > 
> > I agree that we should apply the "keepalive" change for this driver
> > first; ref. https://lkml.org/lkml/2016/2/28/239 (version v8).
> > 
> [...]
> > 
> I took the "watchdog: gpio: keepalives" patch and rebase this
> patch on top of it.
> 
> We have a scenario that will open and close the GPIO watchdog
> device a few times during the user-space initialization. This
> scenario is working properly with this patch on top of v4.9.
> 
> With the "watchdog: gpio: keepalives", I am getting an error
> when the GPIO watchdog driver is open for the 3rd time
> during this initialization process.
> 
> This is a short summary of stack trace:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 808 at lib/kobject.c:597 kobject_get+0x6c/0xac
> kobject: '(null)' (c397f304): is not initialized, yet kobject_get()
> is being called.
> ...
> [<c01a97f8>] (kobject_get) from [<c00c1278>] (chrdev_open+0x54/0x21c)
> [<c00c1224>] (chrdev_open) from [<c00b9df0>] (do_dentry_open
> +0x188/0x2d8)
> ...
> [<c00cabcc>] (do_filp_open) from [<c00bb668>] (do_sys_open+0x114/0x1cc)
> [<c00bb554>] (do_sys_open) from [<c00bb74c>] (SyS_open+0x2c/0x30)
> [<c00bb720>] (SyS_open) from [<c000f840>] (ret_fast_syscall+0x0/0x38)
> [   16.807133] ---[ end trace 7d55a0fe58991d4c ]---
> [   16.807143] ------------[ cut here ]------------
> 
> Regards,
> Sylvain
> 
ping

Sylvain

> > 
> > > Also, isn't this quite identical to nowayout ?
> > > 
> > Nowayout block the watchdog driver from being stop.
> > 
> > In this case, we want to stop the watchdog (i.e. close) and be able
> > to reopen it within the timeout period. If the driver is not reopen
> > within the timeout period, the board should reset.
> > 
> > Regards,
> > Sylvain
> > 
> > > Thanks,
> > > Guenter
> > > 
> > > > ---
> > > >  Documentation/devicetree/bindings/watchdog/gpio-wdt.txt | 3 +++
> > > >  drivers/watchdog/gpio_wdt.c                             | 6 ++++++
> > > >  2 files changed, 9 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> > > > index 83d2814..2669735 100644
> > > > --- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> > > > +++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> > > > @@ -17,6 +17,9 @@ Optional Properties:
> > > >  - always-running: If the watchdog timer cannot be disabled, add this flag to
> > > >    have the driver keep toggling the signal without a client. It will only cease
> > > >    to toggle the signal when the device is open and the timeout elapsed.
> > > > +- keep-armed-on-close: if the watchdog timer need to keep toggling the signal
> > > > +  when close, until the timeout elapsed, add this flag to have the driver
> > > > +  keep toggling the signal, until the timeout elapsed.
> > > >  - timeout-sec: Contains the watchdog timeout in seconds.
> > > >  - start-at-init: Start kicking watchdog as soon as driver is loaded.
> > > >  
> > > > diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> > > > index ef9ab91..ba9091a 100644
> > > > --- a/drivers/watchdog/gpio_wdt.c
> > > > +++ b/drivers/watchdog/gpio_wdt.c
> > > > @@ -32,6 +32,7 @@ struct gpio_wdt_priv {
> > > >  	bool			active_low;
> > > >  	bool			state;
> > > >  	bool			always_running;
> > > > +	bool			keep_armed_on_close;
> > > >  	bool			armed;
> > > >  	unsigned int		hw_algo;
> > > >  	unsigned int		hw_margin;
> > > > @@ -72,6 +73,9 @@ static int gpio_wdt_stop(struct watchdog_device *wdd)
> > > >  {
> > > >  	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
> > > >  
> > > > +	if(priv->keep_armed_on_close)
> > > > +		return 0;
> > > > +
> > > >  	priv->armed = false;
> > > >  	if (!priv->always_running) {
> > > >  		mod_timer(&priv->timer, 0);
> > > > @@ -210,6 +214,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
> > > >  
> > > >  	priv->always_running = of_property_read_bool(pdev->dev.of_node,
> > > >  						     "always-running");
> > > > +	priv->keep_armed_on_close = of_property_read_bool(pdev->dev.of_node,
> > > > +						 "keep-armed-on-close");
> > > >  
> > > >  	watchdog_set_drvdata(&priv->wdd, priv);
> > > >  
> > > > -- 
> > > > 1.8.3.1
> > > > 
> > 
> > 
> 
> 


