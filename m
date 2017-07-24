Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Mon, 24 Jul 2017 14:56:44 -0500
From: Rob Herring <robh@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: wim@iguana.be, linux@roeck-us.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 1/4] ARM: mediatek: dts: Cleanup bindings documentation
Message-ID: <20170724195644.oztdexqhicir5xn3@rob-hp-laptop>
References: <20170720102247.12342-1-matthias.bgg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170720102247.12342-1-matthias.bgg@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Jul 20, 2017 at 12:22:44PM +0200, Matthias Brugger wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> This patch cleans up the binding documentation stating explicitly
> the binding and it's fallback for every SoC.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
