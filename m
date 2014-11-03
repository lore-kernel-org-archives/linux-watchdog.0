Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56962 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752772AbaKCV3g (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Nov 2014 16:29:36 -0500
Date: Mon, 3 Nov 2014 22:29:23 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when
 possible
Message-ID: <20141103222923.53b2870b@free-electrons.com>
In-Reply-To: <5448F7F1.1080509@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<20141022155614.04d33791@free-electrons.com>
	<5448F1A1.9040404@free-electrons.com>
	<20141023142657.6b4d61fb@free-electrons.com>
	<5448F7F1.1080509@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Ezequiel Garcia,

On Thu, 23 Oct 2014 09:43:29 -0300, Ezequiel Garcia wrote:

> > Marvell has always said they are not interested in having Z1 supported
> > in mainline, except as a first step to start getting the 375 support in
> > mainline. I have been waiting for everyone of us to have access to 375
> > A0 platforms, which is now the case. So I believe we can probably get
> > rid of the 375 Z1 support entirely.
> > 
> > It saddens me to know that a shiny development board in the office will
> > no longer be useful for anything else but its own physical beauty, but
> > I believe that's a normal retirement strategy for a very early
> > development platform :-)
> > 
> 
> I'm afraid I have news for you. Even now, the board is almost unusable,
> as the mvpp2 network driver only supports A0 (Z1 support was never even
> planned).
> 
> So you have a NAS development board without network... sounds pretty
> useless to me :)

Who needs network these days? :-)

Well, joke aside, I'm fine with seeing the Armada 375 Z1 support go
away.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
