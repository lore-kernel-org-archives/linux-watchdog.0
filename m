Return-path: <robherring2@gmail.com>
Date: Fri, 23 Sep 2016 14:59:54 -0500
From: Rob Herring <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
	Wim Van Sebroeck <wim@iguana.be>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: bindings: dw_wdt: add reset lines
Message-ID: <20160923195954.GA15080@rob-hp-laptop>
References: <1474527753-22194-1-git-send-email-s.trumtrar@pengutronix.de>
 <1474527753-22194-2-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474527753-22194-2-git-send-email-s.trumtrar@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Sep 22, 2016 at 09:02:30AM +0200, Steffen Trumtrar wrote:
> Document the reset lines holding the watchdog core in reset.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-watchdog@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/watchdog/dw_wdt.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
