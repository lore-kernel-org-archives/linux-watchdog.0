Return-Path: <ezequiel.garcia@free-electrons.com>
Date: Tue, 21 Jan 2014 11:35:59 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 04/15] watchdog: orion: Handle IRQ
Message-ID: <20140121143558.GA24923@localhost>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <52DE84A6.6090909@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52DE84A6.6090909@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Jan 21, 2014 at 06:31:02AM -0800, Guenter Roeck wrote:
> On 01/21/2014 05:26 AM, Ezequiel Garcia wrote:
> > DT-enabled where an irqchip driver for the brigde interrupt controller is
> > available can handle the watchdog IRQ properly. Therefore, we request
> > the interruption and add a dummy handler that merely calls panic().
> >
> > This is done in order to have an initial 'ack' of the interruption,
> > which clears the watchdog state.
> >
> > Furthermore, since some platforms don't have such IRQ, this commit
> > makes the interruption specification optional.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >   .../devicetree/bindings/watchdog/marvel.txt        |  2 ++
> >   drivers/watchdog/orion_wdt.c                       | 22 +++++++++++++++++++++-
> >   2 files changed, 23 insertions(+), 1 deletion(-)
> >
> 
> [ ... ]
> 
> >   static int orion_wdt_probe(struct platform_device *pdev)
> >   {
> >   	struct resource *res;
> > -	int ret;
> > +	int ret, irq;
> >
> >   	clk = devm_clk_get(&pdev->dev, NULL);
> >   	if (IS_ERR(clk)) {
> > @@ -131,6 +138,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
> >   	if (!wdt_reg)
> >   		return -ENOMEM;
> >
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq > 0) {
> 
> 0 is a valid interrupt number, and platform_get_irq returns an error code on errors.
> Should be >= 0.
> 

Yes, indeed. I'll wait to see if there's any other feedback and then send a v4.

Thanks a lot!
-- 
Ezequiel García, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
