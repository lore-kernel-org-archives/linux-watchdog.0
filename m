Return-Path: <SRS0=Thl8=C5=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A437C43465
	for <linux-watchdog@archiver.kernel.org>; Sun, 20 Sep 2020 08:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC0223119
	for <linux-watchdog@archiver.kernel.org>; Sun, 20 Sep 2020 08:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgITIn1 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 20 Sep 2020 04:43:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60224 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgITIn0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 20 Sep 2020 04:43:26 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 04:43:25 EDT
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 893A71C0B9B; Sun, 20 Sep 2020 10:37:46 +0200 (CEST)
Date:   Sun, 20 Sep 2020 10:37:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: fix memory leak in error path
Message-ID: <20200920083745.GA1186@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix memory leak in error path.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index 6798addabd5a..785270ee337c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -994,8 +994,10 @@ static int watchdog_cdev_register(struct watchdog_devi=
ce *wdd)
 	wd_data->wdd =3D wdd;
 	wdd->wd_data =3D wd_data;
=20
-	if (IS_ERR_OR_NULL(watchdog_kworker))
+	if (IS_ERR_OR_NULL(watchdog_kworker)) {
+		kfree(wd_data);
 		return -ENODEV;
+	}
=20
 	device_initialize(&wd_data->dev);
 	wd_data->dev.devt =3D MKDEV(MAJOR(watchdog_devt), wdd->id);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9nFNkACgkQMOfwapXb+vLdywCgnFLCnxHVctMo7+9IbLVDqk59
u14AnjQxnSyuJm9frlrtWQEkFWq7L7yh
=gAoN
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
