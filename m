Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37009 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753503AbaDXLHH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Apr 2014 07:07:07 -0400
Date: Thu, 24 Apr 2014 08:06:36 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [RESEND/PATCH v4 0/9] Watchdog support for Armada 375/38x SoC
Message-ID: <20140424110636.GA1735@arch.cereza>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140424045153.GU28159@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140424045153.GU28159@titan.lakedaemon.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Apr 24, Jason Cooper wrote:
> On Mon, Apr 14, 2014 at 10:23:24AM -0300, Ezequiel Garcia wrote:
> >=20
> > Tested on A375-DB, A385-DB, A370-RD and Dove Cubox. Sebastian did m=
ore tests
> > on Dove, and Jason Gunthorpe on Kirkwood.
>=20
> Applied patches 7 and 8 to mvebu/dt.  For the rest,
>=20
> Acked-by: Jason Cooper <jason@lakedaemon.net>
>=20

Wim,

Can you take the rest of the patches throught your tree, with Jason's a=
ck?

Thanks!
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
