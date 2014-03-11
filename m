Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51100 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530AbaCKVpg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Mar 2014 17:45:36 -0400
Date: Tue, 11 Mar 2014 15:45:25 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Watchdog support for Armada 375/38x SoC
Message-ID: <20140311214525.GA3564@obsidianresearch.com>
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140307001346.GB13690@arch.cereza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140307001346.GB13690@arch.cereza>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 06, 2014 at 09:13:46PM -0300, Ezequiel Garcia wrote:

> > On the driver side, we need to implement per-SoC stop() and enabled()
> > functions. Such somewhat complex infrastructure is needed to ensure the driver
> > performs proper reset of the watchdog timer, by masking and disabling the
> > RSTOUT before the interrupt is enabled.

> JasonG: How does this look now?

A cursory look seems reasonable..

> Any chance someone gives a Tested-by on Dove/Kirkwood?

If you have a git I can pull I can try it here.

Jason
