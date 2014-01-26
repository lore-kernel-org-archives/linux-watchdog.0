Return-Path: <ezequiel.garcia@free-electrons.com>
Date: Sun, 26 Jan 2014 10:18:56 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 08/18] watchdog: orion: Make RSTOUT register a
 separate resource
Message-ID: <20140126131855.GB14713@localhost>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-9-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140126091753.2910a39f@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140126091753.2910a39f@skate>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Jan 26, 2014 at 09:17:53AM +0100, Thomas Petazzoni wrote:
[..]
> > +/*
> > + * The original devicetree binding for this driver specified only
> > + * one memory resource, so in order to keep DT backwards compatibility
> > + * we try to fallback to a hardcoded register address, if the resource
> > + * is missing from the devicetree.
> > + */
> > +static void __iomem *try_rstout_ioremap(struct platform_device *pdev,
> > +					phys_addr_t internal_regs)
> 
> Why is it called "try" ? It actually does the mapping. So I would
> prefer the function to be named:
> 
> 	orion_wdt_ioremap_rstout()
> 

Ah, yes. This is a left over from the previous attempt.
-- 
Ezequiel García, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
