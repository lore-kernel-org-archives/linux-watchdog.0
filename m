Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45683 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbLAAW6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Nov 2015 19:22:58 -0500
Subject: Re: [PATCH (v5) 3/11] MIPS: bmips: Add bcm6345-l2-timer interrupt
 controller
To: Simon Arlott <simon@fire.lp0.eu>,
	Thomas Gleixner <tglx@linutronix.de>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>
 <5653612A.4050309@simon.arlott.org.uk> <565361AF.20400@simon.arlott.org.uk>
 <70d031ae4c3aa29888d77b64686c39e7e7eaae92@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5654E67A.9060800@gmail.com> <5657886F.3090908@simon.arlott.org.uk>
 <alpine.DEB.2.11.1511270926580.3572@nanos>
 <56599D73.7040801@simon.arlott.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	MIPS Mailing List <linux-mips@linux-mips.org>,
	Jonas Gorski <jogo@openwrt.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Miguel Gaio <miguel.gaio@efixo.com>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565CE85A.3080904@roeck-us.net>
Date: Mon, 30 Nov 2015 16:22:50 -0800
MIME-Version: 1.0
In-Reply-To: <56599D73.7040801@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/28/2015 04:26 AM, Simon Arlott wrote:
> Add the BCM6345/BCM6318 timer as an interrupt controller so that it can be
> used by the watchdog to warn that its timer will expire soon.
>
> Support for clocksource/clockevents is not implemented as the timer
> interrupt is not per CPU (except on the BCM6318) and the MIPS clock is
> better. This could be added later if required without changing the device
> tree binding.
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Hi Simon,

can you please re-send the entire series, with all Acked-by:/Reviewed-by:
tags as appropriate ?

Thanks,
Guenter

