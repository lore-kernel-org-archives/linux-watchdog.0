Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7FEC10F13
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC3320850
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 13:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfDNNmm (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:42:42 -0400
Received: from sauhun.de ([88.99.104.3]:33926 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfDNNml (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 09:42:41 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id AB7672CF687;
        Sun, 14 Apr 2019 15:42:39 +0200 (CEST)
Date:   Sun, 14 Apr 2019 15:42:38 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 01/16] watchdog: refactor watchdog_init_timeout
Message-ID: <20190414134238.aj6c42pjj7xjbtxo@ninjato>
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
 <20190414102627.5564-2-wsa+renesas@sang-engineering.com>
 <64e8adf0-cf87-3d54-4513-fd531ab7b7f2@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l4lozuxu2fynhf3w"
Content-Disposition: inline
In-Reply-To: <64e8adf0-cf87-3d54-4513-fd531ab7b7f2@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


--l4lozuxu2fynhf3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The function is not easy to read and has two problems: a) -EINVAL is
> > returned when the module parameter is invalid but the DT parameter is
> > OK, and b) for the module parameter, zero is a valid value but for DT it
> > is invalid.
> >=20
>=20
> That was on purpose: A module parameter of 0 reflects that no module para=
meter
> was provided, which is not an error. An explicit DT property with value 0=
 _is_
> an error and does not make sense. "use the default", in the DT case, can =
and
> should be expressed by providing no property, not by providing a property=
 with
> value 0.

OK, I can fix the code to do that as before. And add some documentation
to describe that. Please let me know if it is documented already and I
just missed it.


--l4lozuxu2fynhf3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyzOMoACgkQFA3kzBSg
KbYbXBAAtFUaxqlGnmreNt91s4/h8NGsBgRY3JIDVo+PVLC4m7FULrJmQuqE2jyx
whZakU1c9PteR3u2OyBSB7jARq1tZlZr0nevkC8swJz/CTMiz67Rh7kzNjcGEch0
rVhsz3KfsYiOdAB2WheT6njRKkJ+OUx9UiLKA3zCsUPI7n7tvHTj0HC43zvEa0oV
qYtojcDgUa9BtW+44IT2GEveZRtFyFAutRKUtFG7ZyVHwmTq79p2QaGX25hvsnCM
78h/2m40N7KsouSueoZnya+uy8TISKTRlRTjXQ+f9gYZk772hHbR4ZKhBzIiETjz
9vlPXGRze73WewGu95uMQpc2iRcNlDeSy/SP9nMxzOnLWCn/AAH0lWx7/OOg4M8k
U9pdZo9oDoxkKJ6iE8h+UEz9cdFT1r6CNfu1IEDRsSXKdER+C5i46OZyfv+DQKm1
uDEWv26MTSU2HE0976slPCk6HrEp0Unzior17hy9P5HUJ+IDtQwyW8wIYC8yKQDy
PEeK0QPr/R4tr4YoDLluvBYMR8Hh/djcsjTHGcydGI6m8S4sTP4XJH5mFBV5vGLq
iMoSZQQRw5RDMoxhrV1XZtbkYjbfgjzPq7vnYO55E0CT7yM3MZDAFmeZsY5Ifvs0
zm5E3CUODQLWhjdeG9yu2GuG6yYTmsSWfmcUX4yD0YMnQpVCIgc=
=zCjR
-----END PGP SIGNATURE-----

--l4lozuxu2fynhf3w--
