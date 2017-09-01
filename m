Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Fri, 1 Sep 2017 09:30:52 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Roc He <hepeng@zidoo.tv>,
	=?utf-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: Add Realtek RTD1295
Message-ID: <20170901143052.e7ch4nxcx33cmiye@rob-hp-laptop>
References: <20170828113532.32627-1-afaerber@suse.de>
 <20170828113532.32627-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170828113532.32627-2-afaerber@suse.de>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 28, 2017 at 01:35:29PM +0200, Andreas Färber wrote:
> Add a binding for the Realtek RTD1295 watchdog.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  .../devicetree/bindings/watchdog/realtek,rtd119x.txt    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt

Acked-by: Rob Herring <robh@kernel.org>
