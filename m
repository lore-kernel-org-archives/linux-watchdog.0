Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56295 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932257AbcFHHKL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 03:10:11 -0400
Date: Wed, 8 Jun 2016 09:10:01 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] watchdog: pretimeout: add noop pretimeout governor
Message-ID: <20160608071001.GE1521@katana>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-7-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <1465321127-19522-7-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +static void pretimeout_noop(struct watchdog_device *wdd)
> +{
> +	pr_alert("watchdog pretimeout event\n");
> +}

My version said which watchdog caused the event, why not adding that?


--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXV8TJAAoJEBQN5MwUoCm2JqoQAJiSSzTStRKRyUybK5djLTTy
1LkSZixUukQtN0mu4qukKF99xcsvbUyLWx5NYaDxIN4aS6AUvNVJI5EXCXH9uvoc
6So1QDzaCBTp732Xgae7MJiSDvEeT7I/gr+ekG1HNl7MRPfkQl5v8zMtj92+fpCk
6hnjzwofeC8L5YW1MEhJ0T0CCS87flGjhibL+OPSCrJU/MmCMzjggb2t4g+lW5Tz
ikFuucoyyoDVeYK7koRO8ww7DYc53Ijcw2j4rbOzXLVdW/lsG88cNSZ5d7fhkTir
dOELdN16eGaNeI4x7rsIG067Q6c2uoHy3335uXr0vd00hm8dv12lBPkbwSE198ap
cnhTI/csSSQKpMBiObAjSqRTKj2goUWZFTQ/jPoEcCoVizDwMjjdWvAFfETHNO42
TKaSDUuQJ6to0EFN4VutzTB2L3Q/RCW5w9+MK92xt/zsfHESuvdtbQYm8Lxz2zgU
PgJPPcA0hsPpZoCWSe41fSC9rVYUPekg6TKy2rM8dpFi5fWnIHFSQwH3nSineIwY
zpZVH2TcSASeR4vBVdQN01k+CDASBSuEKFWP9kPND2AQDKu0R8+7JP0eEiAMJQcY
fZ75/3unLUvR2A3CKMdUOigeY9e22JE1cem9HP8ryDhrDSi1CCFy97kK0QsLwh7y
v9/UKC1ktvzArPgjVS97
=p5JP
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
