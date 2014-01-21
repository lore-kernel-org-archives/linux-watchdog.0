Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39981 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754005AbaAUJnO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:43:14 -0500
Date: Tue, 21 Jan 2014 06:43:14 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-watchdog@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 09/15] watchdog: orion: Add per-compatible clock
 initialization
Message-ID: <20140121094313.GB3577@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-10-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAOMZO5BDS8Dh1PR6SJv1CK5Pkq5mub-Hs7c4RhxUn7o5efnbKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <CAOMZO5BDS8Dh1PR6SJv1CK5Pkq5mub-Hs7c4RhxUn7o5efnbKg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 07:18:44AM -0200, Fabio Estevam wrote:
> On Tue, Jan 21, 2014 at 7:12 AM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
>=20
> > +static int orion_wdt_clock_init(struct platform_device *pdev,
> > +                               struct orion_watchdog *dev)
> > +{
> > +       dev->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(dev->clk))
> > +               return -ENODEV;
>=20
> Shouldn't it be 'return PTR_ERR(dev->clk)' instead?
>=20
>=20
[..]
> > +       clk_prepare_enable(dev->clk);
>=20
> clk_prepare_enable may fail, so better check its return value.
>=20

Indeed.

Thanks!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
