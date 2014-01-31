Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:56097 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbaAaR1M (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 Jan 2014 12:27:12 -0500
Date: Fri, 31 Jan 2014 18:25:25 +0100
From: Willy Tarreau <w@1wt.eu>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Lior Amsalem <alior@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 00/20] Armada 370/XP watchdog support
Message-ID: <20140131172525.GL31190@1wt.eu>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com> <20140129181949.GB27143@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140129181949.GB27143@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 29, 2014 at 03:19:50PM -0300, Ezequiel Garcia wrote:
> On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
> > A new round, mostly fixing some minor nitpicks.
> > 
> 
> If anyone wants to give this a test, here's a public branch:
> 
> https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_v5

Tested-By: Willy Tarreau <w@1wt.eu>

Works like a charm on the mirabox, I've long been missing a hardware
watchdog to save me from unplugging the power cord after some hangs
during development.

Thanks,
Willy

