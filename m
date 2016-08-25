Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tryphon.debian.net ([109.190.112.8]:39732 "EHLO mailhost.home"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759544AbcHYQnx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 25 Aug 2016 12:43:53 -0400
Received: from localhost ([127.0.0.1])
        by mailhost.home with esmtp (Exim 4.80)
        (envelope-from <nboullis@debian.org>)
        id 1bcxZH-0007vd-Gz
        for linux-watchdog@vger.kernel.org; Thu, 25 Aug 2016 18:31:51 +0200
Received: from mailhost.home ([127.0.0.1])
        by localhost (mailhost.home [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EI6nduCeuG1A for <linux-watchdog@vger.kernel.org>;
        Thu, 25 Aug 2016 18:31:50 +0200 (CEST)
Received: from [2a01:240:fe87:1:e4d:e9ff:feba:8ae5] (helo=haddock.home)
        by mailhost.home with esmtp (Exim 4.80)
        (envelope-from <nboullis@debian.org>)
        id 1bcxZF-0007vX-T4
        for linux-watchdog@vger.kernel.org; Thu, 25 Aug 2016 18:31:50 +0200
Date: Thu, 25 Aug 2016 18:31:49 +0200
From: Nicolas Boullis <nboullis@debian.org>
To: linux-watchdog@vger.kernel.org
Subject: Linux-compatible watchdog add-on?
Message-ID: <20160825163149.GB3636@haddock.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry if my question is off-topic for this list.

I have a computer that experienced a kernel failure while a was far away=20
and nobody could reboot it. So I thought it would be nice to have a=20
watchdog. Unfortunately, to the best of my knowledge, it has no hardware=20
watchdog, so I thought I should add one.

Hence, do you have suggestions for I=B2C-, serial- or USB-connected=20
watchdog add-ons? It should of course be compatible with linux.

I found=20
  http://www.berkprod.com/Product_Web_Pages/usb_v1_pc_watchdog.aspx
but I think it is a little too expensive.

If no such thing exists, I might consider designing my own (open=20
hardware) I=B2C- or USB-connected watchdog add-on, using a cheap MCU. But=
=20
then I would welcome opinions on what the interface between the host and=20
watchdog should look like.


Cheers,

--=20
Nicolas Boullis

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJXvx1xAAoJEHnxj5DMK4Q1p3gP/38ImGmJf0ZcDup8o86dH9Dp
ewsz1T0y7ZidNBVIAb2+tCtSx8RSVDFzwdpQrV9KBiJJMDxSkeZN2VF7TRGMhOnJ
99OZC4LCXlfDxz0vG+xMwiprQ49YZLgKoSXlpxGy9j+CiAjTlBs7jyqa6UFKdeP6
vOqa2kYWsJYpuvAwtrDGYnz3H3oNqvVG0tfgVqB5j0kTL8xuHVF9E5flDrwTqU/v
Z+JgC6qYnoLN4FL0xdy+m/VkwyFgre4W4W5Vs+cgTxrchxyoa8iKX+e5R6NYk5qc
DkcW9JJF6yee2HbjbI7ypMwgmgf+Iayj1e5WplfiUtSiSpXctNVW2EQC+r1cB0sn
k4KZLCOoZ6akO9lxyuQdUjA3Fv0artftM0HRBX2Y9ALui4yuPU/GMgoVhzZNBvb8
iFnrnG+SAMKHkPYdqSMFYdbSIGSP4qU7/P5kzMdG9mg4eIElolEVxM0jHgMH+FyX
KrjO895m051N+Fgw7WZHUN/g4lwlJ7vtgvCrd+abvbXQ/m2PIyDpDeYZKH7JnsD9
oOmttAChtNBMQ7UlJLv7+7lke9mEdB/sRIk+kMgycYsQAHbZR78WC48niixq6OeY
80nG85BdkLW6yh8gQy+Y9Q5wS7RYp7nW9DR4IbzX4F/5ieWVWzOPBUMSXF9fqIWI
WDQOCvvEPl72i+nkdSSw
=+FCm
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
