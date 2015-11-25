Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:52183 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbbKYUOo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 15:14:44 -0500
MIME-Version: 1.0
In-Reply-To: <20151124182138.GB12289@roeck-us.net>
References: <5650BFD6.5030700@simon.arlott.org.uk> <5650C08C.6090300@simon.arlott.org.uk>
 <5650E2FA.6090408@roeck-us.net> <5650E5BB.6020404@simon.arlott.org.uk>
 <56512937.6030903@roeck-us.net> <5651CB13.4090704@simon.arlott.org.uk>
 <5651CB9C.4090005@simon.arlott.org.uk> <20151124182138.GB12289@roeck-us.net>
From: Jonas Gorski <jogo@openwrt.org>
Date: Wed, 25 Nov 2015 21:14:13 +0100
Message-ID: <CAOiHx=kn4NPxxYq0Te_T+8y_Cb1udyU0_EO-_eKp2Xshh7X6EA@mail.gmail.com>
Subject: Re: [PATCH 4/10] watchdog: bcm63xx_wdt: Handle hardware interrupt and
 remove software timer
To: Guenter Roeck <linux@roeck-us.net>
Cc: Simon Arlott <simon@fire.lp0.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
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

On Tue, Nov 24, 2015 at 7:21 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Sun, Nov 22, 2015 at 02:05:16PM +0000, Simon Arlott wrote:
>> There is a level triggered interrupt for the watchdog timer as part of
>> the bcm63xx_timer device. The interrupt occurs when the hardware watchdog
>> timer reaches 50% of the remaining time.
>>
>> It is not possible to mask the interrupt within the bcm63xx_timer device.
>> To get around this limitation, handle the interrupt by restarting the
>> watchdog with the current remaining time (which will be half the previous
>> timeout) so that the interrupt occurs again at 1/4th, 1/8th, etc. of the
>> original timeout value until the watchdog forces a reboot.
>>
>> The software timer was restarting the hardware watchdog with a 85 second
>> timeout until the software timer expired, and then causing a panic()
>> about 42.5 seconds later when the hardware interrupt occurred. The
>> hardware watchdog would not reboot until a further 42.5 seconds had
>> passed.
>>
>> Remove the software timer and rely on the hardware timer directly,
>> reducing the maximum timeout from 256 seconds to 85 seconds
>> (2^32 / WDT_HZ).
>>
>
> Florian,
>
> can you have a look into this patch and confirm that there is no better
> way to clear the interrupt status ?

While the watchdog interrupt can't be masked, it should be able to be
cleared by writing 1 to the appropriate bit in the timer block's
interrupt status register. At least the broadcom sources do so.


Jonas
