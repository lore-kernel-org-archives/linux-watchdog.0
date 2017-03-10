Return-path: <horms@verge.net.au>
Date: Fri, 10 Mar 2017 10:19:05 +0100
From: Simon Horman <horms@verge.net.au>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Brandt <chris.brandt@renesas.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ARM: dts: r7s72100: Add watchdog timer
Message-ID: <20170310091905.GD21820@verge.net.au>
References: <20170304223737.20419-1-chris.brandt@renesas.com>
 <20170304223737.20419-4-chris.brandt@renesas.com>
 <ef7f631f-efa9-9d8b-658d-aeaa5bce5bc7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7f631f-efa9-9d8b-658d-aeaa5bce5bc7@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Mar 05, 2017 at 08:04:57AM -0800, Guenter Roeck wrote:
> On 03/04/2017 02:37 PM, Chris Brandt wrote:
> >Add watchdog timer support for RZ/A1.
> >For the RZ/A1, the only way to do a reset is to overflow the WDT, so this
> >is useful even if you don't need the watchdog functionality.
> >
> >Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> >Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,

as the driver bindings have also been Acked I have queued up this
change for v4.12.
