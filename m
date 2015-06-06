Return-path: <jtheou@adeneo-embedded.us>
Date: Sat, 6 Jun 2015 09:19:03 -0700
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Paul Bolle <pebolle@tiscali.nl>
CC: Valentin Rothberg <valentinrothberg@gmail.com>, Wim Van Sebroeck
	<wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] gpio_wdt: Add option for early registration
Message-ID: <20150606091903.944aa609c53ea713952d73f5@adeneo-embedded.us>
In-Reply-To: <1433599878.10861.82.camel@x220>
References: <1433576786-14947-1-git-send-email-jtheou@adeneo-embedded.us>
	<1433576786-14947-2-git-send-email-jtheou@adeneo-embedded.us>
	<1433584986.10861.46.camel@x220>
	<20150606125611.GA16930@nebuchadnezzar>
	<1433599878.10861.82.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Thanks for the feedback.

I tested a version before cleanup, and the mistake was introduce during it.
It's my mistake, sorry about that. Will fix it on v4.


On Sat, 6 Jun 2015 16:11:18 +0200
Paul Bolle <pebolle@tiscali.nl> wrote:

> On Sat, 2015-06-06 at 14:56 +0200, Valentin Rothberg wrote:
> > On Sat, Jun 06, 2015 at 12:03:06PM +0200, Paul Bolle wrote:
> > > On Sat, 2015-06-06 at 00:46 -0700, Jean-Baptiste Theou wrote:
> > > > +#ifdef GPIO_WATCHDOG_ARCH_INITCALL
> > > 
> > > You meant
> > >     #ifdef CONFIG_GPIO_WATCHDOG_ARCH_INITCALL
> > > 
> > > Please use scripts/checkkconfigsymbols.py.
> > 
> > checkkconfigsymbols.py only checks CONFIG_ prefix symbols.  Since this
> > prefix is missing here, the script would not complain.
> 
> Of course. Thanks for correcting me.
> 
> > But that's an interesting case and worth checking for.
> 
> Perhaps. Depends on the amount of false positives that such checks would
> trigger, I'd say.
> 
> 
> Paul Bolle
> 


-- 
Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
