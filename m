Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56256 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbcFHG5h (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 02:57:37 -0400
Date: Wed, 8 Jun 2016 08:57:29 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] watchdog: add pretimeout read-only device
 attribute to sysfs
Message-ID: <20160608065728.GC1521@katana>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-4-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <1465321127-19522-4-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	else if (attr == &dev_attr_pretimeout.attr &&
> +		 !(wdd->info->options & WDIOF_PRETIMEOUT))
> +		mode = 0;

Good catch, this one.


--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXV8HYAAoJEBQN5MwUoCm2UVgQAI4ODtWZ/HfZD6lk7OK5pXEf
p8jzmOYnKEw+bxZa30mWhi1GFq8LC0vXTBlETqq9ZQRuqZHmEAH+c/diYX+DBqyI
cDpOF8VlsaR0xx7FGZccZCk7G6C/HPaBsEBaJp+K0kleAI8Q0LM7ZFYjedvROFId
LcfgWTJ25pEB/ZUdbOJxV6jkq5lXgP0pYS6Xz6YOPzSGiS7w4VMFkqDL1wFfkEUR
taLxNlINaSnOFK94e/F6Y39Ctsv4pCq+nDTUfRak4GrmWFZ86/u+UKWQhqzO5TbA
jkZfm5onDsqpUCus37KqrqiI7xNI0SXKwIha79Cq00yKqmnjDUlv64CLdCsIMOgw
fP/DkQNoAm3r73UswDZ44/XFLXGvSXdt5pMrh5lDOBY/D49o87DZSXx1swz1lbyF
a/v67ghje+P70rFOrD+WkqWXjG26RYAo9+IIum8Yy8SYs3Yymlw7REHVjLg2cIm2
Ur/2NJ9D7EzTAek6iFYCrajwtioRyZmDixdGomTdq03YhxKsGyaatQvB/Q2Tu8XV
pFdCPxczobbcJIlKX/x2xJhAX00ZeYLqo+S4+NYlq7AI8nij7ivKoSHUOPxm7HLU
pIgzgc/MR7pv4ZR4BSmFGc9pUblF4nfa8awBKCsMKWZ//swZpm1//qDcvo8RrdQF
Cui4Me8spIb7B+NCBgDv
=PfZf
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
