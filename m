Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59821 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750919AbaCGAOB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Mar 2014 19:14:01 -0500
Date: Thu, 6 Mar 2014 21:13:46 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Watchdog support for Armada 375/38x SoC
Message-ID: <20140307001346.GB13690@arch.cereza>
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mar 04, Ezequiel Garcia wrote:
> Here's a new patchset adding support for watchdog on Armada 375 and
> Armada 38x SoCs. Regarding the previous patchset, this time we're han=
dling
> the SoCs differences in the watchdog driver itself.
>=20
> The new Armada 375/385 SoCs have two registers for the watchdog RSTOU=
T:
>=20
>  1. It has a dedicated register (similar to the one in A370/XP)
>  2. Also has a bit in a shared RSTOUT register.
>=20
> Therefore, in order to support this two-folded RSTOUT, we extend the =
'reg'
> property in the watchdog devicetree and require a new pair of cells t=
o specify
> the shared RSTOUT.
>=20
> On the driver side, we need to implement per-SoC stop() and enabled()
> functions. Such somewhat complex infrastructure is needed to ensure t=
he driver
> performs proper reset of the watchdog timer, by masking and disabling=
 the
> RSTOUT before the interrupt is enabled.
>=20

JasonG: How does this look now?

Any chance someone gives a Tested-by on Dove/Kirkwood?
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
