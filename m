Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:42074 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbbKYIRd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 03:17:33 -0500
Subject: Re: [PATCH (v2) 7/10] watchdog: bcm63xx_wdt: Add get_timeleft
 function
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC90.7090402@simon.arlott.org.uk>
 <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <56552214.2050808@roeck-us.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonas Gorski <jogo@openwrt.org>
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <56556E84.50202@simon.arlott.org.uk>
Date: Wed, 25 Nov 2015 08:17:08 +0000
MIME-Version: 1.0
In-Reply-To: <56552214.2050808@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 25/11/15 02:51, Guenter Roeck wrote:
> On 11/24/2015 02:15 PM, Simon Arlott wrote:
>> Return the remaining time from the hardware control register.
>>
>> Warn when the device is registered if the hardware watchdog is currently
>> running and report the remaining time left.
> 
> This is really two logical changes, isn't it ?

If you insist then I'll split it out into yet another patch.

> Nice trick to figure out if the watchdog is running.
> 
> What is the impact ? Will this result in interrupts ?

Yes, if it is running it will receive interrupts and check hw->running
to determine if it should stop the watchdog or not.

> If so, would it make sense to _not_ reset the system after a timeout
> in this case, but to keep pinging the watchdog while the watchdog device
> is not open ?

As the whole point of a hardware watchdog is to reset the system when
there is a problem with the software, it should not be automatically
reset by the driver on startup. If the watchdog is already running then
it needs to be pinged by userspace before the timeout.

The bootloader (CFE) doesn't leave the watchdog running. On my system I
prepend some code before vmlinuz that starts it running at the maximum
timeout.

A module parameter could be added to automatically ping/stop it if it's
running, but this should be in the watchdog core and not an individual
driver.

-- 
Simon Arlott
