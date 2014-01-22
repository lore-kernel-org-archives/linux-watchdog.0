Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:33322 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbaAVRue (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 12:50:34 -0500
Date: Wed, 22 Jan 2014 10:50:30 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
Message-ID: <20140122175030.GU18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <20140122174539.GD27273@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140122174539.GD27273@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 22, 2014 at 02:45:40PM -0300, Ezequiel Garcia wrote:
 
> Agreed. So, let's assume we can guarantee that request_irq() does the
> job of clearing the cause register (clearing pending irqs).
> 
> So, your suggestion is to put request_irq() in the watchdog start()?
> 
> Otherwise, we can ensure a watchdog full stop at probe(), before
> requesting the IRQ. Both solutions should work, uh?

Right, I would keep the request_irq in probe, just because that feels
more idiomatic..

Jason
