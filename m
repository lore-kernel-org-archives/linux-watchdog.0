Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:54462 "EHLO
	lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751804AbbFFOLW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Jun 2015 10:11:22 -0400
Message-ID: <1433599878.10861.82.camel@x220>
Subject: Re: [PATCH v3 2/2] gpio_wdt: Add option for early registration
From: Paul Bolle <pebolle@tiscali.nl>
To: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 06 Jun 2015 16:11:18 +0200
In-Reply-To: <20150606125611.GA16930@nebuchadnezzar>
References: <1433576786-14947-1-git-send-email-jtheou@adeneo-embedded.us>
	 <1433576786-14947-2-git-send-email-jtheou@adeneo-embedded.us>
	 <1433584986.10861.46.camel@x220> <20150606125611.GA16930@nebuchadnezzar>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 2015-06-06 at 14:56 +0200, Valentin Rothberg wrote:
> On Sat, Jun 06, 2015 at 12:03:06PM +0200, Paul Bolle wrote:
> > On Sat, 2015-06-06 at 00:46 -0700, Jean-Baptiste Theou wrote:
> > > +#ifdef GPIO_WATCHDOG_ARCH_INITCALL
> > 
> > You meant
> >     #ifdef CONFIG_GPIO_WATCHDOG_ARCH_INITCALL
> > 
> > Please use scripts/checkkconfigsymbols.py.
> 
> checkkconfigsymbols.py only checks CONFIG_ prefix symbols.  Since this
> prefix is missing here, the script would not complain.

Of course. Thanks for correcting me.

> But that's an interesting case and worth checking for.

Perhaps. Depends on the amount of false positives that such checks would
trigger, I'd say.


Paul Bolle

