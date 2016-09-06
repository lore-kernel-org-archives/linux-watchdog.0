Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40772 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756343AbcIFOGI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Sep 2016 10:06:08 -0400
Date: Tue, 6 Sep 2016 16:05:55 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 00/10] watchdog: add watchdog pretimeout framework
Message-ID: <20160906140555.GD1652@katana>
References: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160905164923.GA1548@katana>
 <29631170-1687-fbd0-8072-6a65b8868009@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <29631170-1687-fbd0-8072-6a65b8868009@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I suppose watchdog maintainers would like to provide more review comments,
> so probably this is not the last version of the change, anyway do you
> consider to send SH-Mobile watchdog driver changes for v4.9?

SH Mobile doesn't have HW support for that, this is why the softdog
updates are needed.


--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXzs1DAAoJEBQN5MwUoCm2kJQP/Rn7kcKxWgeYVydWZ3hMdsD+
2/H25Fr7u+vlYVO9RHxEbn0R2BNLYoGjP5rCTcOsioDoaWdl73lnAiscxwH0Ztuv
po9cbxC+HHDsdJAEleRYLkxO5zNN5YX0GoM7N6dMw1thGSrVyThAhdU+opwCSuJ+
4sGqcQlmAQQfq5kadN1Ru4q0MixihWuw2890Oi9xA41PRVaBXv1yeidgsMyZnTcr
dLTg1F5Lp9rxJx6fZodaEh6vfYGZ1Ma4T2PdthGqDSHxSQPQBsOxsJh10PwpnK8Y
9H+Wz2MLJr/XjsBB9KmkdsLzl+ZJn2yB0LQkx0p2xfgpZx+EPy1f8XJbWqKyWXRX
GsrpcFnAfBQvxyOtORNfleyIqRzyzx/uXbCMF2pR44zoF/hE8HJsfgHogYdyYev2
FAU6NgxvJdQ7RuvrqdW73bcDPsbTRHzIVhvkixwsx+Wk0PGKhumuKsisUS3jrxmY
wvOS3ZIKcdaBZVGzPeW1YOUWppq8Uf4mLMR9SjwiLWmdABJm3XY6PwJbiSKDp5dr
RZ9lZm5kmxFBb5WLXuFLVaSkf+vAZKeNoUkz5J0heGqBn4+t23DDvWX8MD+6uaA4
tDz9P1+zHHIVYsgh+4LLSxR4XOevUdJcCfqVUQ7h574baE49Vq1jcwyASMTvvDVV
EvMSr5DEUgtVy1I1IIJ4
=N9sV
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
