Return-path: <damien.riegel@savoirfairelinux.com>
Date: Wed, 25 Nov 2015 15:54:42 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v6 3/6] watchdog: ts4800: add driver for TS-4800 watchdog
Message-ID: <20151125205442.GA3627@localhost>
References: <1448479507-1951-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448479507-1951-4-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151125202956.GA10228@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151125202956.GA10228@rob-hp-laptop>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Nov 25, 2015 at 02:29:56PM -0600, Rob Herring wrote:
> On Wed, Nov 25, 2015 at 02:25:04PM -0500, Damien Riegel wrote:
> > This watchdog is instantiated in a FPGA that is memory mapped. It is
> > made of only one register, called the feed register. Writing to this
> > register will re-arm the watchdog for a given time (and enable it if it
> > was disable). It can be disabled by writing a special value into it.
> > 
> > It is part of a syscon block, and the watchdog register offset in this
> > block varies from board to board. This offset is passed in the syscon
> > property after the phandle to the syscon node.
> > 
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  25 +++
> >  drivers/watchdog/Kconfig                           |  10 +
> >  drivers/watchdog/Makefile                          |   1 +
> >  drivers/watchdog/ts4800_wdt.c                      | 215 +++++++++++++++++++++
> >  4 files changed, 251 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> >  create mode 100644 drivers/watchdog/ts4800_wdt.c
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> > new file mode 100644
> > index 0000000..388c60f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> > @@ -0,0 +1,25 @@
> > +Technologic Systems Watchdog
> > +
> > +Required properties:
> > +- compatible: must be "technologic,ts4800-wdt"
> > +- syscon: phandle / integer array that points to the syscon node which
> > +          describes the FPGA's syscon registers.
> > +          - phandle to FPGA's syscon
> > +          - offset to the watchdog register
> > +
> > +Optional property:
> > +- timeout-sec: contains the watchdog timeout in seconds.
> > +
> > +Example:
> > +
> > +syscon: syscon@b0010000 {
> > +	compatible = "syscon", "simple-mfd";
> > +	reg = <0xb0010000 0x3d>;
> > +	bus-width = <16>;
> > +
> > +	wdt@e {
> > +		compatible = "technologic,ts4800-wdt";
> > +		syscon = <&syscon 0xe>;
> 
> If this is single register only for the watchdog, why do you need 
> syscon? You can just use reg.

Because this is a single 16-bit register dedicated to the watchdog in a
60-register syscon.
