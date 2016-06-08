Return-path: <joe@perches.com>
Message-ID: <1465400332.25087.56.camel@perches.com>
Subject: kbuild: default n removals? (was: Re: [PATCH v3 4/6] watchdog: add
 watchdog pretimeout framework)
From: Joe Perches <joe@perches.com>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Guenter Roeck
	 <linux@roeck-us.net>, Michal Marek <mmarek@suse.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>,
 Robin Gong <b38343@freescale.com>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kbuild <linux-kbuild@vger.kernel.org>
Date: Wed, 08 Jun 2016 08:38:52 -0700
In-Reply-To: <5758358A.602@mentor.com>
References: 
	<1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
	 <1465321127-19522-5-git-send-email-vladimir_zapolskiy@mentor.com>
	 <20160607214309.GA17129@roeck-us.net> <57581FB2.10806@mentor.com>
	 <57582363.8050406@roeck-us.net> <5758358A.602@mentor.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

(Adding Michal Marek and linux-kbuild)

On Wed, 2016-06-08 at 18:11 +0300, Vladimir Zapolskiy wrote:
> On 08.06.2016 16:53, Guenter Roeck wrote:
> > On 06/08/2016 06:37 AM, Vladimir Zapolskiy wrote:
> > > > > +comment "Watchdog Pretimeout Governors"
> > > > > +
> > > > > +config WATCHDOG_PRETIMEOUT_GOV
> > > > > +	bool "Enable watchdog pretimeout governors"
> > > > > +	default n
> > > > I don't think 'default n" is needed.
> > > > 
> > > No strict objections, but probably 'default n' may save quite many
> > > lines in defconfigs.
> > > 
> > I always wondered why it would be necessary to say "default n".
> > What is the difference between "default n" and no explicit default ?
> > 
> I pointed out that it may have impact on defconfig, but experimentally
> it has no effect.
> 
> Users of "make oldconfig" get a prompt in both cases as well.
> 
> Also I haven't found any difference for silentoldconfig, olddefconfig
> and alldefconfig, I assume explicit "default n" and "def_bool n"
> can be safely dropped.

It's not completely clear removals are always appropriate.

from: Documentation/kbuild/kconfig-language.txt:
------------------------------------------------------------------
- default value: "default" <expr> ["if" <expr>]
  A config option can have any number of default values. If multiple
  default values are visible, only the first defined one is active.
  Default values are not limited to the menu entry where they are
  defined. This means the default can be defined somewhere else or be
  overridden by an earlier definition.
  The default value is only assigned to the config symbol if no other
  value was set by the user (via the input prompt above). If an input
  prompt is visible the default value is presented to the user and can
  be overridden by him.
  Optionally, dependencies only for this default value can be added with
  "if".
------------------------------------------------------------------

Michal?  Do you have an opinion or clarification?
