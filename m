Return-path: <p.zabel@pengutronix.de>
Message-ID: <1438967349.3638.42.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] watchdog: da9063: Disable and wait before changing
 timeout
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	support.opensource@diasemi.com, kernel@pengutronix.de
Date: Fri, 07 Aug 2015 19:09:09 +0200
In-Reply-To: <55C4B534.5050602@roeck-us.net>
References: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>
	 <1438879019-12978-2-git-send-email-p.zabel@pengutronix.de>
	 <55C4B534.5050602@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Am Freitag, den 07.08.2015, 06:40 -0700 schrieb Guenter Roeck:
> On 08/06/2015 09:36 AM, Philipp Zabel wrote:
> > The DA9063 watchdog occasionally enters error condition and resets the
> > system if the timeout is changed quickly after the timer was enabled.
> >
> > The method of disabling and waiting for > 150 µs before setting the
> > new timeout is taken from the DA9052 driver.
> >
> Using sleep concerns me a bit, since during that time the watchdog
> is disabled. Bad enough that we have to do this to start with,
> but using usleep adds more risk to an already bad situation.
> 
> How about udelay() instead ?

Ok, I'll change it.

regards
Philipp
