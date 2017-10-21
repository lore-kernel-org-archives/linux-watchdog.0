Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:33109 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932254AbdJUXnw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 21 Oct 2017 19:43:52 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 1CCC11801BB64
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Oct 2017 23:34:11 +0000 (UTC)
Message-ID: <1508628846.14611.2.camel@perches.com>
Subject: Re: [v8,4/5] watchdog: Add RAVE SP watchdog driver
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        cphealy@gmail.com, Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Date: Sat, 21 Oct 2017 16:34:06 -0700
In-Reply-To: <20171021164730.GA20402@roeck-us.net>
References: <20171018170136.12347-5-andrew.smirnov@gmail.com>
         <20171021164730.GA20402@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 2017-10-21 at 09:47 -0700, Guenter Roeck wrote:
> On Wed, Oct 18, 2017 at 10:01:35AM -0700, Andrey Smirnov wrote:
> > This driver provides access to RAVE SP watchdog functionality.
[]
> > +static int rave_sp_wdt_legacy_configure(struct watchdog_device *wdd)
> > +{
> > +	const bool enable = watchdog_hw_running(wdd);
> > +	u8 cmd[] = {
> > +		[0] = RAVE_SP_CMD_SW_WDT,
> > +		[1] = 0,
> > +		[2] = 0,
> > +		[3] = !!enable,
> 
> Useless !!. It converts a boolean to a boolean. Besides, isn't it always
> true anyway ?

This converts a _Bool to an int which is cast to a u8
The !! is useless though.

> > +		[4] = enable ? wdd->timeout : 0,
> > +	};
> 
> Interesting; checkpatch doesn't require an empty line after variable
> declarations anymore ? Lets keep it anyway for consistency.

checkpatch is primarily a single line oriented parser.
Multi-line declarations aren't parsed.

