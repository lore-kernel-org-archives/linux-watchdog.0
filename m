Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:37981 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaKSJ0B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Nov 2014 04:26:01 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so257148wgh.37
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Nov 2014 01:26:00 -0800 (PST)
Message-ID: <546C6226.5000900@linaro.org>
Date: Wed, 19 Nov 2014 10:25:58 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 0/3] Make Armada 375 use the reference clock when possible
References: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/04/2014 02:21 PM, Ezequiel Garcia wrote:
> Hi Daniel, Wim:
>
> Seems we are ready to merge these, unless some objection raises. Do y=
ou think
> you can take the patches through your trees?

Hi Wim,

I can take through my tree the entire patchset if you want but I need=20
your blessing for the watchdog part.

Thanks
   -- Daniel

> Changes from v2:
>
>    * Fix messed up empty lines, as suggested by Thomas Petazzoni.
>
> Changes from v1:
>
>    * Make the A375 timer and watchdog devicetree binding match the ha=
rdware
>      and require the two available clocks: core and reference clock.
>
> This series adds support for the 25 MHz reference clock available on
> Armada 375 SoC to be used on the timer and watchdog drivers. It is
> similar to the one present in Armada XP SoC.
>
> Given we initially had access to only a very early SoC revision (A375=
 Z1)
> and due to a hardware issue, the timer and watchdog support was origi=
nally
> submitted to use the core clock.
>
> Now that the A0 SoC revision is out, we can fix this and use the refe=
rence
> clock. The reason for this change is that the core clock is subject t=
o the
> SSCG (Spread Spectrum Clock Generator), so boards where SSCG is enabl=
ed
> exhibit a very large timer drift.
>
> Notice that this change will produce unpleseant results on A375 Z1, g=
iven the
> reference 25 MHz clock doesn't work properly on that SoC revision.
>
> But since the Z1 revision is not supported by the recently submitted =
A375
> network driver (mvpp2), and therefore nobody is expected to run mainl=
ine
> (if there are users at all of this early revision), the support will =
be
> dropped entirely in a near future.
>
> To prevent any compatibility issues when booting with an older device=
tree,
> this series provides proper fall backs in each case.
>
> The series applies on v3.18-rc2.
>
> Ezequiel Garcia (3):
>    clocksource: armada-370-xp: Add missing clock enable
>    watchdog: orion: Use the reference clock on Armada 375 SoC
>    clocksource: armada-370-xp: Use the reference clock on A375 SoC
>
>   .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++--
>   .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
>   drivers/clocksource/time-armada-370-xp.c           | 30 +++++++++++=
+++++
>   drivers/watchdog/orion_wdt.c                       | 42 +++++++++++=
++++++++++-
>   4 files changed, 90 insertions(+), 4 deletions(-)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
