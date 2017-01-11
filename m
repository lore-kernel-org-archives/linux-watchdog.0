Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33191 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762860AbdAKR2k (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jan 2017 12:28:40 -0500
Date: Wed, 11 Jan 2017 09:28:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mans Rullgard <mans@mansr.com>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device
 managed functions
Message-ID: <20170111172837.GA22289@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
 <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
 <20170111143917.hedhyfu6m5dopag7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170111143917.hedhyfu6m5dopag7@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 11, 2017 at 03:39:17PM +0100, Uwe Kleine-König wrote:
> On Wed, Jan 11, 2017 at 01:31:47PM +0100, Marc Gonzalez wrote:
> > On 11/01/2017 11:52, Guenter Roeck wrote:
> > 
> > > On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
> > > 
> > >>> @@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
> > >>>  	err = clk_prepare_enable(dev->clk);
> > >>>  	if (err)
> > >>>  		return err;
> > >>> +	err = devm_add_action_or_reset(&pdev->dev,
> > >>> +				       (void(*)(void *))clk_disable_unprepare,
> > >>> +				       dev->clk);
> > >>> +	if (err)
> > >>> +		return err;
> 
> This looks wrong. There is no clk_unprepare_disable when
> devm_add_action_or_reset fails.
> 
That is what the _or_reset part of devm_add_action_or_reset() is for.

> > >>
> > >> Hello Guenter,
> > >>
> > >> I would rather avoid the function pointer cast.
> > >> How about defining an auxiliary function for the cleanup action?
> > >>
> > >> clk_disable_unprepare() is static inline, so gcc will have to
> > >> define an auxiliary function either way. What do you think?
> > > 
> > > Not really. It would just make it more complicated to replace the
> > > call with devm_clk_prepare_enable(), should it ever find its way
> > > into the light of day.
> > 
> > More complicated, because the cleanup function will have to be deleted later?
> > The compiler will warn if someone forgets to do that.
> > 
> > In my opinion, it's not a good idea to rely on the fact that casting
> > void(*)(struct clk *clk) to void(*)(void *) is likely to work as expected
> > on most platforms. (It has undefined behavior, strictly speaking.)
> 
> I would expect it to work on all (Linux) platforms. Anyhow, I wonder if
> there couldn't be found a better solution.
> 
> If in the end it looks like the following that would be good I think:
> 
> 	clk = devm_clk_get(...);
> 	if (IS_ERR(clk))
> 		...
> 
> 	ret = devm_clk_prepare_enable(clk)
> 	if (ret)
> 		return ret;
> 
Yes, Dmitry tried to introduce devm_clk_prepare_enable() some 5 years ago,
but the effort stalled.

My take is that it will be easy to write another coccinelle script to convert
to devm_clk_prepare_enable() once that is available, but I didn't see the point
of waiting for that, especially since it may never happen.

Guenter
