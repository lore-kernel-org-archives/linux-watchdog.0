Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52795 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751839AbaJVN4S (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 09:56:18 -0400
Date: Wed, 22 Oct 2014 15:56:14 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when
 possible
Message-ID: <20141022155614.04d33791@free-electrons.com>
In-Reply-To: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Ezequiel Garcia,

On Wed, 22 Oct 2014 10:34:40 -0300, Ezequiel Garcia wrote:
> This series adds support for the 25 MHz reference clock available on
> Armada 375 SoC to use on the timer and watchdog drivers. It is
> similar to the one present in Armada XP SoC.
> 
> Given we initially had access to only a very early SoC revision (A375 Z0)

Actually: s/Z0/Z1/.

> and due to a hardware issue, the timer and watchdog support was originally
> submitted to use the core clock.
> 
> Now that the A0 SoC revision is out, we can fix this and use the reference
> clock. The reason for this change is that the core clock is subject to the
> SSCG, so boards where SSCG is enabled exhibit a very large timer drift.
> 
> To prevent any compatibility issues when booting with an older devicetree,
> this series provides proper fall backs in each case.

You don't clearly state whether your patch series keep compatibility
with the 375 Z1 or not. And in fact, it doesn't keep compatibility with
Z1. I'm fine with that, but then it means we should officially declare
the Z1 support in mainline as dead, and get rid of the workarounds that
applied only to 375 Z1.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
