Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35885 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaA3Uxd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jan 2014 15:53:33 -0500
Date: Thu, 30 Jan 2014 15:53:15 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 00/20] Armada 370/XP watchdog support
Message-ID: <20140130205315.GD29184@titan.lakedaemon.net>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140129181949.GB27143@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140129181949.GB27143@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Ezequiel,

On Wed, Jan 29, 2014 at 03:19:50PM -0300, Ezequiel Garcia wrote:
> On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
> > A new round, mostly fixing some minor nitpicks.
> > 
> 
> If anyone wants to give this a test, here's a public branch:
> 
> https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_v5

I just took a quick glance at this (commit oneliners/tags) and there
doesn't appear to be any dependence on Sebastian's series.  Did I miss
something?

Also, the MMIO patch hit mainline last night.

thx,

Jason.
