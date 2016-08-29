Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37730 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbcH2StS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 14:49:18 -0400
Date: Mon, 29 Aug 2016 20:49:09 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 5/7] watchdog: pretimeout: add noop pretimeout governor
Message-ID: <20160829184909.GC1610@katana>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1472227681-1405-6-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <1472227681-1405-6-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/watchdog.h>
> +
> +#include <watchdog_pretimeout.h>

This include must be in "" to compile.


--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxIOkAAoJEBQN5MwUoCm2zJcP/Re7ruPMyjBUMJ7w4HTLd9xi
DH67U6Z8XsrGjcnkRiUwSTKKrfQkj3ghJsFO02JDm+dOgW+BLHUMAhdeYBTRlGdC
dxYwIb0Yveqwj1om3vSVtwUMSD7sGU3j02AQclYpZzFfwB6Hzbl7hZfh1UjwGI4H
b8s0HlMOxfVlkpm3YclilYN68IGSFnOq+BwQE5ijahYxIT0NSYxU74yPTPwIGxO8
sZW7XPy5zdohMVSaSbJu7odv+BOYYD5dGid77tHf6pVjbRYveFZ2ZTu9Ve27q5qD
x8FQ1DHOcSLx0Xt1l2GqIRvR2vYDWUg0JbnA0W3soVp6XSRC+syj0/icqcYaVUC1
RSDmbGAfuJWWUr1XkY9040BXKk/SMEyyfc8p9uKFJJkgOfmNh6cnP07rAHE2FhWL
0D8LS3qg1rtb6pXow7MHiUOcZU/weAgfOlFgnm8Al5UXt/hL43QHIs37VVUoXSBE
QBrP2hLmfpQ0izKno5g8v7SOVg2sWxQE5gP1Wsbt89BkKiJFC70yAg36bM9FcLr5
9USasmMDGp0WPwaf21CPclZtafZIJVwkM2bNMgyHS0bedUd+jhp+bcHBohbKBLex
1dnD3q5fLGGZ4mCac07digBSSRl+Fz0mBEwSX99HJcW/d0sp0oDm5rSzl+IPrLgY
qVODosiWiSeME0+nqyzr
=Z+Ug
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
