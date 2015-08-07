Return-path: <p.zabel@pengutronix.de>
Message-ID: <1438967295.3638.41.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] watchdog: da9063: Ping watchdog only during allowed
 time window
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	support.opensource@diasemi.com, kernel@pengutronix.de
Date: Fri, 07 Aug 2015 19:08:15 +0200
In-Reply-To: <55C4B473.90307@roeck-us.net>
References: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>
	 <55C4B473.90307@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Am Freitag, den 07.08.2015, 06:36 -0700 schrieb Guenter Roeck:
> On 08/06/2015 09:36 AM, Philipp Zabel wrote:
> > There is a cooldown period after watchdog timer setup, and also after each
> > watchdog ping. If a ping is issued too early, the watchdog triggers the
> > watchdog error condition and causes a system reset.
> >
> > The 256 ms period length is a best guess based on the same value being used
> > for the DA9053 predecessor PMIC and experiments that have shown 200 ms are
> > not enough to avoid the error.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Hi Philipp,
> 
> instead of using this quite complex approach, would it be possible to use the
> same approach as the da9062 driver ?
> 
> I understand the downside, which is that the caller may end up sleeping,
> but this should not happen too often.

Depending on the userspace this can happen quite a lot ...

>  Also, I plan to move the enforcement
> of a minimal time between heartbeats into the infrastructure, so this would
> not least forever.

... but certainly taking care of this in the framework is better than
doing it in the drivers.

regards
Philipp
