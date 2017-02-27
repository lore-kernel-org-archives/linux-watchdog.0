Return-path: <robherring2@gmail.com>
Date: Mon, 27 Feb 2017 10:34:03 -0600
From: Rob Herring <robh@kernel.org>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: renesas-wdt: add support for rza
Message-ID: <20170227163403.itptnpa24immhx7s@rob-hp-laptop>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-3-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216172320.10897-3-chris.brandt@renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Feb 16, 2017 at 12:23:19PM -0500, Chris Brandt wrote:
> Describe the WDT hardware in the RZ/A series.
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v2:
> * added to renesas-wdt.txt instead of creating a new file
> * changed commit title
> * added "renesas,rza-wdt" as a fallback
> * added interrupts property
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
