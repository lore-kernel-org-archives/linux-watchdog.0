Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54352 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeLISkN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Dec 2018 13:40:13 -0500
Date: Sun, 9 Dec 2018 19:40:11 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during
 suspend/resume
Message-ID: <20181209184010.GA3585@kunai>
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
 <476b6d6c-657d-7e10-d0a8-a7aafe61eae9@roeck-us.net>
 <20181207214528.GA2853@kunai>
 <eb86c5d7-ab13-df05-0d0f-9dad811a6a98@roeck-us.net>
 <20181209163632.GB1673@kunai>
 <df16092e-f0f6-c085-3daf-303e1cb06428@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <df16092e-f0f6-c085-3daf-303e1cb06428@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I understand, but what is the use case behind it ? If the watchdog

I'll leave this discussion to Fabrizio...

> I'd rather clarify in the documentation that watchdog drivers are expected
> to ping the watchdog after resume, ie that restarting the watchdog after
> resume should be handled like starting the watchdog.

... because this (a documented default) is exactly what *I* am
interested in :)


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwNYYYACgkQFA3kzBSg
KbYF3Q/+KGoVRveBm8uigLk/RRt8BBYK7TG17p03I6EE+29uhMowE+ySsX/ToSyQ
gfGXouE6gH2+jWKYK95T7UfQbjmQeMTGhEkBYZuStwjkqCVjutLs0SSCdR0be//T
/A0fPlOzd8khGiA0DSSpvZzrFlrAcKZJJZqalUqf8vpgWWeuDUJ5GXITNZj0wsEN
qH+sGoGWBHI/UPj+FbsacOLK8Q3kF63/13JFckIwv4a2LyEBBWTfLt7f18n6V0ZV
ml7KaM06qqxPS3SJBrQN0srG0Xzx6ehpbjfoRClUPXdgRBqf7vXiDmpYCZUjRqXT
tKrtczSVRPnedj5Dix5BmA6Q6dBIZ2WvlTKRq/8kMqk7JICE6KsW4JSJCmXnBd57
3h5wregOKeDiJx4kQb2wHN9UeSP2cRSwVBQhnWi3F65oKyCFbihTmuNlBc+XN3oC
hj4JsqGVEgDSOx8K1FIcSZ0mXBJyKaTDO6aBrRCrvLnKS8VslJLsUWO3R6cn9z7x
cXwHWh105605LtC1VcZdFOWlW+N/L3czkfSXSJuE6jI/BS571kfCEF39W9ALrKCR
QHSj3MnPMmKs3lNS6SibZ0GGoSaqRvzVHsoDk3G1ZyBt9UeYTcTHhmKjMdOSOiOl
lXN5VD+vgmbG1FL/4RD4AEoTE/YHTXbn8t1Ju0DLAGW4kbs/cxA=
=4nqP
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
