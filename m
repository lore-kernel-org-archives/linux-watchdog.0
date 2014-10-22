Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53095 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751850AbaJVOZc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 10:25:32 -0400
Date: Wed, 22 Oct 2014 16:25:28 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when
 possible
Message-ID: <20141022162528.67d5d750@free-electrons.com>
In-Reply-To: <20141022140847.GQ9845@lunn.ch>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<20141022155614.04d33791@free-electrons.com>
	<20141022140847.GQ9845@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Andrew Lunn,

On Wed, 22 Oct 2014 16:08:47 +0200, Andrew Lunn wrote:

> How bad is it if you run these patches on a Z1? Is it worth adding a
> revision check and calling BUG()?

To be tested, I don't have the answer off-hand.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
