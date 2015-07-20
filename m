Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:43286 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932126AbbGTIaD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Jul 2015 04:30:03 -0400
Date: Mon, 20 Jul 2015 10:26:58 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Francesco Lavra <francescolavra.fl@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sunxi: fix activation of system reset
Message-ID: <20150720082658.GU28632@lukather>
References: <559AC20B.4090601@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aIPTgi9H47uqouUT"
Content-Disposition: inline
In-Reply-To: <559AC20B.4090601@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--aIPTgi9H47uqouUT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

Your patch looks mostly good, but there's just a few minor things.

On Mon, Jul 06, 2015 at 07:59:39PM +0200, Francesco Lavra wrote:
> Commit f2147de3 ("watchdog: sunxi: support parameterized compatible

The commit ID should have at least 12 chars to avoid future ID
collisions (which already start to happen)

> strings") introduced a regression in sunxi_wdt_start(), by which
> the system reset function of the watchdog is not enabled upon
> starting the watchdog. Fix it.

Having a description of what that actually means for the end-user (I
guess that it won't reset the system when the watchdog expires) would
be nice.

> Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>

Could you also CC stable, and add a Fixes: tag please?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--aIPTgi9H47uqouUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVrLDSAAoJEBx+YmzsjxAgCPwP/2If/4GSq5j+Xh0dv58X+iJM
Q2wsK+lwAtkvLSSFlNiF0p7OD1Z4nDzeViYwwSTv0GLRO93tKiwBsmT0+4Ji/CE0
8Qb3fIXyqdPR6oMsQxeM4l6VePkknCB4c/YdniqtE3nLb+R5ziMhqH5Vf6qjfdaQ
vMbkLUvqXztliRb9qILPgQit/Bal7k/GUBHBtLecSgjMF979ap3cZBUnNn/l5Euz
GIlleK7LO0cLSW6t/Ms3YQfdXiTmpuHLz/2+vqbm6korDcjDOT8h3B2feQoh/mid
1gablxyKdBSQ2Pz5zl8EAidx1NTBFiNpqkUyhjx/vH1HfEMRq2fLitFpmb1G9+SV
0r2vbg0IE/nyAc+bNMM6rOlqKYySij8R/8ewbq/pwVrWby5kmamdA+fOJuAOHgFr
ZBRQHVCagTk1NDmXcVYP9m2EUQc6fg9845GQJvpQrOR+sY4a47CRBbMUcwumd/Xo
citlFobvVtaUUcMjauPLditrDjtsMNLf75PxXrTfCCpKeTtnvbchQYHtXag+9RCT
5/kUUDa/6G6kGkYXpgCcDXh83Ou46Lhx/H+gRvC/uC5tQwyb5QALKi2Pro7lSitV
tI2bSdJgXmDad3KCfgI6nTVTBVJ41/gWve46Dgd4aampjSJVNDoih092XtDTF5Ez
1YGkI0kLZdREJv8VhY2a
=1lYn
-----END PGP SIGNATURE-----

--aIPTgi9H47uqouUT--
