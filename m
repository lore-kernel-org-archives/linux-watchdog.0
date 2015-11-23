Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:42655 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbbKWTAg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 14:00:36 -0500
Subject: Re: [PATCH 6/10] watchdog: bcm63xx_wdt: Obtain watchdog clock HZ from
 "periph" clk
To: Florian Fainelli <f.fainelli@gmail.com>,
	Jonas Gorski <jogo@openwrt.org>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC3C.5090200@simon.arlott.org.uk>
 <CAOiHx==Z=4H=-L2CY-FE5m6WMV0XzgsCmy1b9tUbsmOHydzkEw@mail.gmail.com>
 <565358AF.2090609@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
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
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5653624C.3030101@simon.arlott.org.uk>
Date: Mon, 23 Nov 2015 19:00:28 +0000
MIME-Version: 1.0
In-Reply-To: <565358AF.2090609@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 23/11/15 18:19, Florian Fainelli wrote:
> On 23/11/15 07:02, Jonas Gorski wrote:
>> On Sun, Nov 22, 2015 at 3:07 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>>> -#define WDT_HZ                 50000000                /* Fclk */
>>> +#define WDT_CLK_NAME           "periph"
>> 
>> @Florian:
>> Is this correct? The comment for the watchdog in 6358_map_part.h and
>> earlier claims that the clock is 40 MHz there, but the code uses 50MHz
>> - is this a bug in the comments or is it a bug taken over from the
>> original broadcom code? I'm sure that the periph clock being 50 MHz
>> even on the older chips is correct, else we'd have noticed that in
>> serial output (where it's also used).
> 
> There are references to a Fbus2 clock in documentation, but I could not
> find any actual documentation for its actual clock frequency, I would be
> surprised if this chip would have diverged from the previous and future
> ones and used a 40Mhz clock. 6345 started with a peripheral clock
> running at 50Mhz, and that is true for all chips since then AFAICT.
> 
> I agree we would have noticed this with the UART or SPI controllers if
> that was not true, so probably a code glitch here...

I've tested both the timer and the watchdog and they give near perfect
time intervals (within 1-2ms based on printk times over serial) so it'd
be obvious if they were out by 25%.

-- 
Simon Arlott
