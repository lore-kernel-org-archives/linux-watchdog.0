Return-Path: <ezequiel.garcia@free-electrons.com>
Date: Sun, 26 Jan 2014 10:14:46 -0300
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
Subject: Re: [PATCH v4 07/18] watchdog: orion: Handle IRQ
Message-ID: <20140126131445.GA14713@localhost>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140126090412.37f4932f@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140126090412.37f4932f@skate>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Jan 26, 2014 at 09:04:12AM +0100, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Wed, 22 Jan 2014 20:05:04 -0300, Ezequiel Garcia wrote:
> > DT-enabled where an irqchip driver for the brigde interrupt controller is
> > available can handle the watchdog IRQ properly. Therefore, we request
> > the interruption and add a dummy handler that merely calls panic().
> 
> I don't quiite understand the first sentence of this commit log, and
> the commit title looks wrong. Maybe a bad copy/paste or something?
> 

Hm... yes it doesn't look right. It should read:

"DT-enabled platforms, where the irqchip driver for the brigde interrupt
controller is available, can handle the watchdog IRQ properly. Therefore,
we request the interrupt and add a dummy handler that merely calls panic()".

I guess we can re-phrase it be a bit more readable.

Why does th commit title looks wrong? By requesting the IRQ we are
"handling it", no?

> > 
> > This is done in order to have an initial 'ack' of the interruption,
> 
> interruption -> interrupt
> 

Right.

-- 
Ezequiel García, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
