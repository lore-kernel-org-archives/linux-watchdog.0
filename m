Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Sun, 18 Feb 2018 17:13:49 -0600
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: allow setting timeout in devicetree
Message-ID: <20180218231349.k55xhl7z7wzwbbjg@rob-hp-laptop>
References: <20180208131108.3048-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208131108.3048-1-marcus.folkesson@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Feb 08, 2018 at 02:11:08PM +0100, Marcus Folkesson wrote:
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also let us to set
> timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 2 ++
>  drivers/watchdog/imx2_wdt.c                                | 8 ++------
>  2 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
