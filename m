Return-Path: <SRS0=Yb/R=2H=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA95C2D0CD
	for <linux-watchdog@archiver.kernel.org>; Tue, 17 Dec 2019 16:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02E72467B
	for <linux-watchdog@archiver.kernel.org>; Tue, 17 Dec 2019 16:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfLQQOM (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:14:12 -0500
Received: from sauhun.de ([88.99.104.3]:54336 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfLQQOM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 17 Dec 2019 11:14:12 -0500
Received: from localhost (p54B330AA.dip0.t-ipconnect.de [84.179.48.170])
        by pokefinder.org (Postfix) with ESMTPSA id 694742C06A5;
        Tue, 17 Dec 2019 17:14:10 +0100 (CET)
Date:   Tue, 17 Dec 2019 17:14:10 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a77961
 support
Message-ID: <20191217161410.GE14061@ninjato>
References: <20191205134751.6928-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
In-Reply-To: <20191205134751.6928-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 02:47:51PM +0100, Geert Uytterhoeven wrote:
> Document support for the Watchdog Timer in the Renesas R-Car M3-W+
> (R8A77961) SoC.
>=20
> No driver update is needed.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl34/tEACgkQFA3kzBSg
KbZM9Q//UNnF9l2ZCPRcTVEtC6zTo9ZH6YXtWDH9JXXnqaP2/ohMAdQ7qpv3q5kQ
HZazX2a+641bjiDiJ+lEft6Oit4LfcI811466in8Cs43f/F9pSQCb0JeRq42HVau
uf7ZCW7jMe2d/dZVcCWzx+KUsKV4vSlFdhIySUJOXLPCaUq0mUcFWf6fNdlMuJWT
jmvR030rsi51fc0H7ees3fAH5i/tDs4JuWiGrsFxDbqUPUE7DXSr87l9jl/AB+Jv
EVIQnXOz0kbtf9EFi/QQuBfmFrt8onYmLICPGI2QSZskDI7ytShxKslhIHY6spzU
O6O6kGIYNT3DaisrJEnqGk9nEzxpOWZ20y8u/Xq5vajkgMMLEILbmjecH+MM4eKj
t3+urZwV44GwCOf4Mhz0RHPFi/nXyz/mCNPtviN+uaD0ihFMUzZ6gAXxeyGQ31r1
ZWthkJICfWHueBkZnHbh5niYpc6GcBgQhKjqQHF+iSDBqxnJ9DLgD+NNn8vZiLKB
CZHFSko6JVH3AEk/icVhIGG6sv1KR4asUv3/GlgS1lCWJDIgI/98tKF/oUntemj6
+8elvtColf0fC2GTRvGxsaCbvvKJvodfyugEib4SMSG0SDqRiUWZnIjY0lBciAsp
Xhgk8dTxpYBIZdIC11wwE1Q3GOAYYZk60FeStmSXIBGteWjJlSg=
=l4M/
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
