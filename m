Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58479 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbcFHSFt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 14:05:49 -0400
Date: Wed, 8 Jun 2016 11:05:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joe Perches <joe@perches.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Michal Marek <mmarek@suse.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <wsa@the-dreams.de>,
	Robin Gong <b38343@freescale.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: kbuild: default n removals? (was: Re: [PATCH v3 4/6] watchdog:
 add watchdog pretimeout framework)
Message-ID: <20160608180536.GB17549@roeck-us.net>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-5-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160607214309.GA17129@roeck-us.net>
 <57581FB2.10806@mentor.com>
 <57582363.8050406@roeck-us.net>
 <5758358A.602@mentor.com>
 <1465400332.25087.56.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1465400332.25087.56.camel@perches.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 08, 2016 at 08:38:52AM -0700, Joe Perches wrote:
> (Adding Michal Marek and linux-kbuild)
> 
> On Wed, 2016-06-08 at 18:11 +0300, Vladimir Zapolskiy wrote:
> > On 08.06.2016 16:53, Guenter Roeck wrote:
> > > On 06/08/2016 06:37 AM, Vladimir Zapolskiy wrote:
> > > > > > +comment "Watchdog Pretimeout Governors"
> > > > > > +
> > > > > > +config WATCHDOG_PRETIMEOUT_GOV
> > > > > > +	bool "Enable watchdog pretimeout governors"
> > > > > > +	default n
> > > > > I don't think 'default n" is needed.
> > > > > 
> > > > No strict objections, but probably 'default n' may save quite many
> > > > lines in defconfigs.
> > > > 
> > > I always wondered why it would be necessary to say "default n".
> > > What is the difference between "default n" and no explicit default ?
> > > 
> > I pointed out that it may have impact on defconfig, but experimentally
> > it has no effect.
> > 
> > Users of "make oldconfig" get a prompt in both cases as well.
> > 
> > Also I haven't found any difference for silentoldconfig, olddefconfig
> > and alldefconfig, I assume explicit "default n" and "def_bool n"
> > can be safely dropped.
> 
> It's not completely clear removals are always appropriate.
> 
> from: Documentation/kbuild/kconfig-language.txt:
> ------------------------------------------------------------------
> - default value: "default" <expr> ["if" <expr>]
>   A config option can have any number of default values. If multiple
>   default values are visible, only the first defined one is active.
>   Default values are not limited to the menu entry where they are
>   defined. This means the default can be defined somewhere else or be
>   overridden by an earlier definition.
>   The default value is only assigned to the config symbol if no other
>   value was set by the user (via the input prompt above). If an input
>   prompt is visible the default value is presented to the user and can
>   be overridden by him.
>   Optionally, dependencies only for this default value can be added with
>   "if".

This describes default settings such as
	default n if <expr>
	default y

which would set the default to y unless <expr> is true.

Question here was about the stand-alone "default n" which always
perplexed me.

Guenter
