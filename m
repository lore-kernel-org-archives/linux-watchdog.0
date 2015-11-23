Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:45671 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118AbbKWPdc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 10:33:32 -0500
MIME-Version: 1.0
In-Reply-To: <5650BFD6.5030700@simon.arlott.org.uk>
References: <5650BFD6.5030700@simon.arlott.org.uk>
From: Jonas Gorski <jogo@openwrt.org>
Date: Mon, 23 Nov 2015 16:33:03 +0100
Message-ID: <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] clocksource: Add brcm,bcm6345-timer device tree binding
To: Simon Arlott <simon@fire.lp0.eu>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Miguel Gaio <miguel.gaio@efixo.com>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	MIPS Mailing List <linux-mips@linux-mips.org>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Nov 21, 2015 at 8:02 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
> Add device tree binding for the BCM6345 timer. This is required for the
> BCM6345 watchdog which needs to respond to one of the timer interrupts.
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  .../bindings/timer/brcm,bcm6345-timer.txt          | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
> new file mode 100644
> index 0000000..2593907
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
> @@ -0,0 +1,57 @@
> +Broadcom BCM6345 Timer
> +
> +This block is a timer that is connected to one interrupt on the main interrupt
> +controller and functions as a programmable interrupt controller for timer events.
> +
> +- 3 to 4 independent timers with their own maskable level interrupt bit (but not
> +  per CPU because there is only one parent interrupt and the timers share it)
> +

This is true for the 6345 one but not the 6318/63148/63381 one, which
has one interrupt per timer (+ one extra watchdog interrupt on
6318/63148), and the parent interrupt controller supports affinity. So
you could e.g. route the timer 0 irq to cpu 0 and timer1 irq on cpu 1.

> +- 1 watchdog timer with an unmaskable level interrupt
> +
> +- Contains one enable/status word pair
> +
> +- No atomic set/clear operations
> +
> +The lack of per CPU ability of timers makes them unusable as a set of
> +clockevent devices, otherwise they could be attached to the remaining
> +interrupts.
> +
> +The BCM6318 also has a separate interrupt for every timer except the watchdog.
> +
> +Required properties:
> +
> +- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6345-timer"

Since bcm6318 uses a slightly different register layout than the
earlier SoCs, I'd argue that using bcm6345-timer as a compatible for
bcm6318 is wrong.


Jonas
