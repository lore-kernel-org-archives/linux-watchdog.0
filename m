Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:46099 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbaCLVnY (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 17:43:24 -0400
Date: Wed, 12 Mar 2014 15:43:12 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v3 0/8] Watchdog support for Armada 375/38x SoC
Message-ID: <20140312214312.GA14357@obsidianresearch.com>
References: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 12, 2014 at 06:11:47PM -0300, Ezequiel Garcia wrote:

> I've pushed a branch so people can test this easily, e.g. ensuring
> no regressions on Dove, Kirkwood and A370/XP:
> 
> https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_a385_a375_v3

This branch worked for me, the watchdog functioned as expected.

# killall -STOP wdt...
..
.
orion_wdt: Oops: Watchdog Timeout
CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-rc1-00205-g666e53f-dirty #1
[..]
<REBOOT>

I got these two oddball messages during boot though:

irq: Cannot allocate irq_descs @ IRQ26, assuming pre-allocated
irq: Cannot allocate irq_descs @ IRQ61, assuming pre-allocated

Probably unrelated to the watchdog.. Unfortunately I've run out of
time right now to investigate.

Jason
