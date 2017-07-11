Return-Path: <wimvs@spo001.leaseweb.nl>
Return-path: <wimvs@spo001.leaseweb.nl>
Date: Tue, 11 Jul 2017 17:50:33 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	esben.haabendal@gmail.com, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v6,3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Message-ID: <20170711155033.GB31924@spo001.leaseweb.nl>
References: <1496134608-7375-4-git-send-email-rasmus.villemoes@prevas.dk> <20170708151554.GA3816@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170708151554.GA3816@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> > This allows setting a default value for the watchdog.open_timeout
> > commandline parameter via Kconfig.
> > 
> > Some BSPs allow remote updating of the kernel image and root file
> > system, but updating the bootloader requires physical access. Hence, if
> > one has a firmware update that requires relaxing the
> > watchdog.open_timeout a little, the value used must be baked into the
> > kernel image itself and cannot come from the u-boot environment via the
> > kernel command line.
> > 
> > Being able to set the initial value in .config doesn't change the fact
> > that the value on the command line, if present, takes precedence, and is
> > of course immensely useful for development purposes while one has
> > console acccess, as well as usable in the cases where one can make a
> > permanent update of the kernel command line.
> > 
> > Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> 
> Wim, any thoughts on making this configurable ? I used to be opposed to it,
> but it does seem to make some sense to me now after thinking about it.

I will look at it later this week.

Kind regards,
Wim.
