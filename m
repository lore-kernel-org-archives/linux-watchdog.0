Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53305 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751889AbaJVOnP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 10:43:15 -0400
Message-ID: <5447C276.4050106@free-electrons.com>
Date: Wed, 22 Oct 2014 16:43:02 +0200
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when possible
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Ezequiel,

On 22/10/2014 15:34, Ezequiel Garcia wrote:
> This series adds support for the 25 MHz reference clock available on
> Armada 375 SoC to use on the timer and watchdog drivers. It is
> similar to the one present in Armada XP SoC.

I agree with Thomas P. comments: could you see if it was possible to reuse the same
function and dt bindings that the ones used for Armada XP ?
I am not aware of any difference between Armada XP and Armada 375 for this IP.


Thanks,

Gregory


> 
> Given we initially had access to only a very early SoC revision (A375 Z0)
> and due to a hardware issue, the timer and watchdog support was originally
> submitted to use the core clock.
> 
> Now that the A0 SoC revision is out, we can fix this and use the reference
> clock. The reason for this change is that the core clock is subject to the
> SSCG, so boards where SSCG is enabled exhibit a very large timer drift.
> 
> To prevent any compatibility issues when booting with an older devicetree,
> this series provides proper fall backs in each case.
> 
> The series applies on v3.18-rc1. As usual, any feedback is well received!
> 
> Ezequiel Garcia (4):
>   clocksource: armada-370-xp: Add missing clock enable
>   watchdog: orion: Use the reference clock on Armada 375 SoC
>   clocksource: armada-370-xp: Use the reference clock on A375 SoC
>   ARM: dts: Enable the reference clock for timer and watchdog on Armada
>     375 SoC
> 
>  .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++--
>  arch/arm/boot/dts/armada-375.dtsi                  | 12 +++++--
>  drivers/clocksource/time-armada-370-xp.c           | 30 ++++++++++++++++
>  drivers/watchdog/orion_wdt.c                       | 40 +++++++++++++++++++++-
>  4 files changed, 86 insertions(+), 5 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
