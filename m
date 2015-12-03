Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50388 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbbLCRWo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Dec 2015 12:22:44 -0500
Message-ID: <56607A5F.6090708@arm.com>
Date: Thu, 03 Dec 2015 17:22:39 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Simon Arlott <simon@fire.lp0.eu>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>
CC: Florian Fainelli <f.fainelli@gmail.com>,
	MIPS Mailing List <linux-mips@linux-mips.org>,
	Jonas Gorski <jogo@openwrt.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 02/11] MIPS: bmips: Add bcm6345-l2-timer interrupt controller
References: <565D9A40.60409@simon.arlott.org.uk> <565D9A73.3000500@simon.arlott.org.uk>
In-Reply-To: <565D9A73.3000500@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/12/15 13:02, Simon Arlott wrote:
> Add the BCM6345/BCM6318 timer as an interrupt controller so that it can be
> used by the watchdog to warn that its timer will expire soon.
> 
> Support for clocksource/clockevents is not implemented as the timer
> interrupt is not per CPU (except on the BCM6318) and the MIPS clock is
> better. This could be added later if required without changing the device
> tree binding.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  drivers/irqchip/Kconfig                |   5 +
>  drivers/irqchip/Makefile               |   1 +
>  drivers/irqchip/irq-bcm6345-l2-timer.c | 386 +++++++++++++++++++++++++++++++++
>  3 files changed, 392 insertions(+)
>  create mode 100644 drivers/irqchip/irq-bcm6345-l2-timer.c

I'm not sure how useful it is to have a bunch of timers that are just
turned off, but from an irqchip PoV:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
