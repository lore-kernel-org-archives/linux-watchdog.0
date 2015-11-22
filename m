Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39904 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbbKVWMn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Nov 2015 17:12:43 -0500
Date: Sun, 22 Nov 2015 16:12:37 -0600
From: Rob Herring <robh@kernel.org>
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
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/4] clocksource: Add brcm,bcm6345-timer device tree
 binding
Message-ID: <20151122221237.GA11852@rob-hp-laptop>
References: <5650BFD6.5030700@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5650BFD6.5030700@simon.arlott.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Nov 21, 2015 at 07:02:46PM +0000, Simon Arlott wrote:
> Add device tree binding for the BCM6345 timer. This is required for the
> BCM6345 watchdog which needs to respond to one of the timer interrupts.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

One minor nit, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

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
> +- reg: specifies the base physical address and size of the registers, excluding
> +  the watchdog registers
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 1.
> +- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
> +  this one is cascaded from
> +- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
> +  node for the main timer interrupt, followed by the individual timer interrupts
> +  if present; valid values depend on the type of parent interrupt controller
> +
> +Example:
> +
> +timer: timer@0x10000080 {

Drop the '0x'

> +        compatible = "brcm,bcm63168-timer", "brcm,bcm6345-timer";
> +        reg = <0x10000080 0x1c>;
> +
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        interrupt-parent = <&periph_intc>;
> +        interrupts = <0>;
> +};
> +
> +timer: timer@0x10000040 {

Ditto.

> +        compatible = "brcm,bcm6318-timer", "brcm,bcm6345-timer";
> +        reg = <0x10000040 0x28>;
> +
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        interrupt-parent = <&periph_intc>;
> +        interrupts = <31>, <0>, <1>, <2>, <3>;
> +};
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
