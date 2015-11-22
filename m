Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:59317 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbbKVODZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Nov 2015 09:03:25 -0500
Subject: Re: [PATCH 4/10] (Was: [PATCH 4/4]) MIPS: bmips: Convert bcm63xx_wdt
 to use WATCHDOG_CORE
To: Guenter Roeck <linux@roeck-us.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonas Gorski <jogo@openwrt.org>
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5651CB13.4090704@simon.arlott.org.uk>
Date: Sun, 22 Nov 2015 14:02:59 +0000
MIME-Version: 1.0
In-Reply-To: <56512937.6030903@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 22/11/15 02:32, Guenter Roeck wrote:
> On 11/21/2015 01:44 PM, Simon Arlott wrote:
>> On 21/11/15 21:32, Guenter Roeck wrote:
>>> this is really doing a bit too much in a single patch.
>>> Conversion to the watchdog infrastructure should probably be
>>> the first step, followed by further optimizations and improvements.
>>

I've split patch 4 up into 7 patches, which will be patches 4/10..10/10
in this thread.

Instead of using bcm63xx_timer_register in #ifdefs, I'll remove most of
bcm63xx_timer because it's only used by the watchdog.

>>> We have some infrastructure changes in the works which will move
>>> the need for soft-timers from individual drivers into the watchdog core.
>>> Would this possibly be helpful here ? The timer-driven watchdog ping
>>> seems to accomplish pretty much the same.
>>
>> There is no need for a software timer. This is not a timer-driven
>> watchdog ping, there is an unmaskable timer interrupt when the watchdog
>> timer has less than 50% remaining.
>>
> Ok. Maybe I got confused by the interrupt-triggered watchdog ping.
> I'll have to look into that much more closely; it is quite unusual
> and complex. The explanation is also not easy to understand.
> What does "The only way to stop this interrupt" mean ? Repeatedly

The interrupt is level triggered at less than 50% of the time remaining.
Unless the watchdog is stopped or restarted, the interrupt will not stop
occurring.

> triggering the interrupt in 1/2, 1/4, 1/8 of the remaining time is
> really odd.

It's a bit odd but there's no way to ack the interrupt. This seemed like
the best approach without adding the complexity of a software timer or
trying to mask and unmask the timer interrupt. I don't  want to ignore
the interrupt entirely because I'd like to know if the watchdog is going
to cause a reboot.

> On side note, the subject tag should be "watchdog:", not "MIPS:".

Fixed.

-- 
Simon Arlott
