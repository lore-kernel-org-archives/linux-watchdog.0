Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56514 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbcEINGk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 May 2016 09:06:40 -0400
Subject: Re: [PATCH (v5) 3/11] MIPS: bmips: Add bcm6345-l2-timer interrupt
 controller
To: =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
	Simon Arlott <simon@fire.lp0.eu>,
	Thomas Gleixner <tglx@linutronix.de>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>
 <5653612A.4050309@simon.arlott.org.uk> <565361AF.20400@simon.arlott.org.uk>
 <70d031ae4c3aa29888d77b64686c39e7e7eaae92@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5654E67A.9060800@gmail.com> <5657886F.3090908@simon.arlott.org.uk>
 <alpine.DEB.2.11.1511270926580.3572@nanos>
 <56599D73.7040801@simon.arlott.org.uk> <565CE85A.3080904@roeck-us.net>
 <256BE4660FB03085.33070B6A-E0AC-4643-92B8-4FD874210CD9@mail.outlook.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	MIPS Mailing List <linux-mips@linux-mips.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Miguel Gaio <miguel.gaio@efixo.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Jonas Gorski <jogo@openwrt.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Maxime Bizon <mbizon@freebox.fr>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-watchdog@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57308B3D.3020502@roeck-us.net>
Date: Mon, 9 May 2016 06:06:05 -0700
MIME-Version: 1.0
In-Reply-To: <256BE4660FB03085.33070B6A-E0AC-4643-92B8-4FD874210CD9@mail.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/09/2016 05:01 AM, Álvaro Fernández Rojas wrote:
> Hello Guenter,
>
> Are there any other issues preventing this patches from being merged?
>

My major problem/concern is the interrupt handling and the repeated
restart of the hardware timer with continuously reduced timeouts.
This appears fragile, and it doesn't really make sense from a system
level point of view. Unfortunately, I don't have a data sheet for
the chip, nor the means or the time to test it myself. So we are pretty
much in limbo, unless someone from Broadcom confirms that, yes, this is
the one and expected means to program this watchdog.

Guenter

> Regards,
> Álvaro.
> _____________________________
> From: Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>
> Sent: martes, diciembre 1, 2015 1:23 a. m.
> Subject: Re: [PATCH (v5) 3/11] MIPS: bmips: Add bcm6345-l2-timer interrupt controller
> To: Simon Arlott <simon@fire.lp0.eu <mailto:simon@fire.lp0.eu>>, Thomas Gleixner <tglx@linutronix.de <mailto:tglx@linutronix.de>>
> Cc: Ralf Baechle <ralf@linux-mips.org <mailto:ralf@linux-mips.org>>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>>, Mark Rutland <mark.rutland@arm.com <mailto:mark.rutland@arm.com>>, Florian Fainelli <f.fainelli@gmail.com <mailto:f.fainelli@gmail.com>>, Ian Campbell <ijc+devicetree@hellion.org.uk <mailto:ijc+devicetree@hellion.org.uk>>, Kevin Cernekee <cernekee@gmail.com <mailto:cernekee@gmail.com>>, MIPS Mailing List <linux-mips@linux-mips.org <mailto:linux-mips@linux-mips.org>>, Kumar Gala <galak@codeaurora.org <mailto:galak@codeaurora.org>>, Miguel Gaio <miguel.gaio@efixo.com <mailto:miguel.gaio@efixo.com>>, Jonas Gorski <jogo@openwrt.org <mailto:jogo@openwrt.org>>, Marc Zyngier <marc.zyngier@arm.com <mailto:marc.zyngier@arm.com>>, Pawel Moll <pawel.moll@arm.com <mailto:pawel.moll@arm.com>>, Rob Herring <robh+dt@kernel.org <mailto:robh+dt@kernel.org>>, <devicetree@vger.kernel.org <mailto:devicetree@vger.kernel.org>>, Maxime
> Bizon <mbizon@freebox.fr <mailto:mbizon@freebox.fr>>, Wim Van Sebroeck <wim@iguana.be <mailto:wim@iguana.be>>, <linux-watchdog@vger.kernel.org <mailto:linux-watchdog@vger.kernel.org>>, Jason Cooper <jason@lakedaemon.net <mailto:jason@lakedaemon.net>>
>
>
> On 11/28/2015 04:26 AM, Simon Arlott wrote:
>  > Add the BCM6345/BCM6318 timer as an interrupt controller so that it can be
>  > used by the watchdog to warn that its timer will expire soon.
>  >
>  > Support for clocksource/clockevents is not implemented as the timer
>  > interrupt is not per CPU (except on the BCM6318) and the MIPS clock is
>  > better. This could be added later if required without changing the device
>  > tree binding.
>  >
>  > Signed-off-by: Simon Arlott <simon@fire.lp0.eu <mailto:simon@fire.lp0.eu>>
>
> Hi Simon,
>
> can you please re-send the entire series, with all Acked-by:/Reviewed-by:
> tags as appropriate ?
>
> Thanks,
> Guenter
>
>
>
>

