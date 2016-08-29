Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37769 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbcH2Syt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 14:54:49 -0400
Date: Mon, 29 Aug 2016 20:54:42 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 6/7] watchdog: pretimeout: add option to select a
 pretimeout governor in runtime
Message-ID: <20160829185441.GE1610@katana>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1472227681-1405-7-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <1472227681-1405-7-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static struct governor_priv *find_governor_by_name(const char *gov_name)
> +{
> +	struct governor_priv *priv;
> +
> +	list_for_each_entry(priv, &governor_list, entry)
> +		if (!strncmp(gov_name, priv->gov->name,

strncmp forces to use 'echo -n' in userspace which can cause confusion
when if '-n' is forgotten. The cpufreq code pre-parses the buffer with
sscanf() to eliminate the terminating newline. There is also
sysfs_streq() which seems the a tad better solution to me.


--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxITxAAoJEBQN5MwUoCm29VYP/10UUvRQ3junntgMW+PrTNif
DkuA1AtRqXjk+6ThbWmBUBmME9cKOLouR1kyE0zjmM0GYJo3UiC4WcB/h1+gKDdm
VNUROzRsKJunkTJPDZyQNNVBDWRiJAprr1ga1dnQD0H7485JmEKq3EKWqsMIylsZ
FbYagkJDl/jHeRnucJC0RlDtoAQkzN++PYgPZVAc+k+hK6LB0kSxsFxNct971KWL
v5axZFrSFdxxgbw+cj+zSN2cZhHXtr8O+XSlnRLtCPkTcQ08tRdki/uR3q0bOd8V
uVYnmWXipjr3MtkLB0EXZFXJtc0/x7z1sLHVUMgPhUioeIOV4RW8ri0zMHIQv0Dl
xHhTibZbJmJ6vdTAxsYRVr18pTm0r6F9eRqZDLTqpVkCjBLtKat1KDgag261dQ/U
2V63C5ecX40Z4nJqJ4okQWw8lbvAEGd4/mjsxYwK0ZoZ3ItpyburoJBDeDZc0t0o
JaTu2tSgkM0jAbube+QFl1eW1lDVAZeT1W3Sd+Z6YM6GDzHbPYjqPV7L2exAN8gE
lynNiGBNbuh5pDUdiINQwNDrVD/8jBxHEnEuFKNtMBnOnpQUrC6dxXkK+ef7lnQZ
2yC1SAKo9bmwtSI2z0h7oBB2JTQkhU+9dWOivsuRjZQhJry9hNHyhNPAPWgYHYRU
3vcyThf2WMd0Rmq2ZgZk
=7/bu
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
