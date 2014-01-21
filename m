Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:55088 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbaAUMzZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 07:55:25 -0500
Date: Tue, 21 Jan 2014 13:53:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 15/15] ARM: mvebu: Enable watchdog support in defconfig
Message-ID: <20140121125339.GH13396@lunn.ch>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-16-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121124746.GZ29184@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140121124746.GZ29184@titan.lakedaemon.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 07:47:46AM -0500, Jason Cooper wrote:
> On Tue, Jan 21, 2014 at 06:12:41AM -0300, Ezequiel Garcia wrote:
> > Now that we have proper support for Armada 370/XP watchdog
> > let's enable it in the defconfig.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/configs/mvebu_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Just a note to myself more than anything: I need to square up multi_v7
> with mvebu.  As we make these changes next cycle, we need to be able to
> easily test that we aren't breaking multiplat build or boot.

Hi Jason

Hopefully you can also tackle multi_v5 as well, once DT kirkwood moves
into mach-mvebu.

To check for breaking boot, you need some other hardware
platform. Nomadik was breaking kirkwood multi_v5, and you would not
see the problem on Nomadik.

    Andrew
