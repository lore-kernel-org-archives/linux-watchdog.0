Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33205 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab1ALLa6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Jan 2011 06:30:58 -0500
Received: by wyb28 with SMTP id 28so434427wyb.19
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Jan 2011 03:30:57 -0800 (PST)
Date: Wed, 12 Jan 2011 11:30:54 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: viresh kumar <viresh.linux@gmail.com>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110112113054.GA2658@pulham.picochip.com>
References: <1294675181-18273-1-git-send-email-jamie@jamieiles.com>
 <AANLkTikbxyCSX5eKiwtZyW+gYToTD7Jcucst6su2fEjN@mail.gmail.com>
 <20110112082416.GE3181@pulham.picochip.com>
 <AANLkTim2LJVA+qJNqYd2uPNKjP54kuyvsZ7-T3jSJsta@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTim2LJVA+qJNqYd2uPNKjP54kuyvsZ7-T3jSJsta@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 12, 2011 at 02:27:47PM +0530, viresh kumar wrote:
> Jamie,
> 
> On Wed, Jan 12, 2011 at 1:54 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> >> I don't know why, but checkpatch used to give few errors which it is
> >> not giving now.
> >> Like:
> >> - Mixing spaces and tabs
> >> - Line over 80 columns.
> >>
> >> There are few places in this patch where i have seen these issues, but
> >> checkpatch doesn't
> >> report them at all.
> >
> > Hmm, the only lines over 80 chars are printk lines and I can't see any
> > with mixed spaces and tabs...
> 
> There are few in file drivers/watchdog/dw_wdt.c
> line 40-45, 127, 133, 156, 167, 204, 216, 315, 319.

I do need to fix up the register locations (40-45) but the others are ok 
- they are tab indented to get to a multiple of 8 then spaces to align 
to the '(' brackets etc.

> >> I know it doesn't make sense for a platform to have support for clk framework
> >> and pass rate through plat data. But this code will always take
> >> pdata->rate, if it is passed.
> >> Wouldn't it be better if we reverse the sequence.
> >>
> >> if (clk)
> >>  rate = clk_get_rate(...);
> >> else {
> >>  pdata = pdev->dev.platform_data;
> >>  if (pdata)
> >>   rate = pdata->rate;
> >> }
> >>
> >> and then following code
> >
> > That's what I did first (without the test that clk is not NULL) but
> > switched it the other way round so that the platform can override the
> > frequency by setting platform_data->clk_rate to nonzero.  That just
> > seems a little more flexible and easy for testing but I'm happy to
> > switch the order if you feel that's important.
> >
> 
> Problem will occur if rate is dynamically changed and we are still believing
> on platform code's clk_rate.
> Would be better if we switch order. i.e. give priority to clk_get_rate over
> pdata->rate.

If the platform can change the rate then I don't see why it would define 
the rate in the platform data though.  Anyway, I can make the change and 
issue a warning and fail the probe if we're using the rate from 
clk_get_rate() and there is a non-zero rate in the platform data.

Jamie
