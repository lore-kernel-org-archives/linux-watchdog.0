Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, paul@crapouillou.net
Subject: Re: [PATCH 1/2] dt: watchdog: Add DT binding documentation for jz47xx watchdog timer
Date: Wed, 28 Jan 2015 12:23:48 +0100
Message-ID: <9831838.T0biTLFe1N@wuerfel>
In-Reply-To: <54C8B974.8030703@imgtec.com>
References: <1422371490-44402-1-git-send-email-Zubair.Kakakhel@imgtec.com> <9081741.fTg5kD1W54@wuerfel> <54C8B974.8030703@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Wednesday 28 January 2015 10:27:00 Zubair Lutfullah Kakakhel wrote:
> 
> There is on-going work to fix jz4740, add jz4780 and shake the entire clock tree as well.
> 
> Patch 14 onwards in this series
> http://patchwork.linux-mips.org/bundle/paulburton/ci20-v3.20/

Right, that looks good.
 
> Instead of lumping things out in huge changesets, I intended to push out the minor patches that are disjoint.
> 
> That was the purpose of sending these two patches.
> 
> Current binding requires the clock-name to be "rtc". Hence the name at the moment.

The problem with the binding is that once you've established it, it
is very hard to change. One possible solution would be to try
'of_clk_get(dev->of_node, 0)' in the driver first, and only then
call clk_get(dev, "rtc"). Doing that, you can have an anonymous clock
in the DT without waiting for the clock driver to get merged first
or breaking the existing setup.

	Arnd
