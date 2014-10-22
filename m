Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42012 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbaJVOJp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 10:09:45 -0400
Date: Wed, 22 Oct 2014 16:08:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when possible
Message-ID: <20141022140847.GQ9845@lunn.ch>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022155614.04d33791@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141022155614.04d33791@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> You don't clearly state whether your patch series keep compatibility
> with the 375 Z1 or not. And in fact, it doesn't keep compatibility with
> Z1.

Hi Thomas

That answers my question. Thanks

> I'm fine with that, but then it means we should officially declare
> the Z1 support in mainline as dead, and get rid of the workarounds that
> applied only to 375 Z1.

A big ACK.

How bad is it if you run these patches on a Z1? Is it worth adding a
revision check and calling BUG()?

	 Andrew
