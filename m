Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45831 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575AbaLDQMX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Dec 2014 11:12:23 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XwZ0x-0032fc-BH
	for linux-watchdog@vger.kernel.org; Thu, 04 Dec 2014 16:12:23 +0000
Date: Thu, 4 Dec 2014 08:11:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Tomasz Figa <t.figa@samsung.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
Message-ID: <20141204161108.GA7385@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <CAMuHMdX-WsVErpiZ_EbFSGxeJEfpu3cRaZzitupiSAA2hXEJ8g@mail.gmail.com>
 <54807505.2000406@roeck-us.net>
 <3875532.ABOh5kXkPb@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3875532.ABOh5kXkPb@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Dec 04, 2014 at 04:06:22PM +0100, Arnd Bergmann wrote:
> On Thursday 04 December 2014 06:51:49 Guenter Roeck wrote:
> > On 12/04/2014 06:44 AM, Geert Uytterhoeven wrote:
> > > On Thu, Dec 4, 2014 at 3:26 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > >> On 12/04/2014 05:36 AM, Geert Uytterhoeven wrote:
> > >>> On Wed, Aug 20, 2014 at 2:45 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > >>>> Implementing a restart handler in a module don't make sense
> > >>>> as there would be no guarantee that the module is loaded when
> > >>>> a restart is needed. Unexport arm_pm_restart to ensure that
> > >>>> no one gets the idea to do it anyway.
> > >>>
> > >>> Why not? I was just going to do that, but I got greeted by:
> > >>
> > >> Because you should register a restart handler instead, like the other
> > >> drivers in the same directory now do.
> > >
> > > That's a different thing. "there would be no guarantee that the module is
> > > loaded when a restart is needed" is also valid for restart handlers...
> > >
> > 
> > Not really, because you are supposed to unregister the restart handler
> > on unload. Sure, you can instead clear arm_pm_reastart and leave the system
> > with no means to restart ...
> 
> I agree with Geert that your commit message was confusing, it sounds like
> you were referring to drivers that are not yet loaded, while the problem
> that you are really address is drivers that have been unloaded later.
> 
Yes, I realize that now. I should probably have added the rationale
for the entire series to this commit. I'll try to do better next time.

Guenter
