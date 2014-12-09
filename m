Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38348 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbaLIQWz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Dec 2014 11:22:55 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XyNYt-003hB1-C3
	for linux-watchdog@vger.kernel.org; Tue, 09 Dec 2014 16:22:55 +0000
Date: Tue, 9 Dec 2014 08:22:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <wsa@the-dreams.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: Re: [PATCH 1/4] watchdog: da9063: Add restart handler support
Message-ID: <20141209162222.GA19663@roeck-us.net>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
 <1418124169-7123-2-git-send-email-geert+renesas@glider.be>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B4C115@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B4C115@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 09, 2014 at 12:37:15PM +0000, Opensource [Steve Twiss] wrote:
> On 09 December 2014 11:23 Geert Uytterhoeven wrote:
> 
[ ... ]

> > +	ret = register_restart_handler(&wdt->restart_handler);
> > +	if (ret)
> > +		dev_err(wdt->da9063->dev,
> > +			"Failed to register restart handler (err = %d)\n", ret);
> 
>  (I guess this is intentional).. if the restart handler doesn't get registered then
> this problem is just ignored and not counted as a real error.
> 
This makes sense, since one doesn't want the watchdog driver to fail
loading just because the restart handler failed to register.
One option might be to make the message dev_warn instead of dev_err,
but that is really a nitpick.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
