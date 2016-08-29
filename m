Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37736 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754362AbcH2SuN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 14:50:13 -0400
Date: Mon, 29 Aug 2016 20:50:05 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Robin Gong <b38343@freescale.com>
Subject: Re: [PATCH v4 1/7] watchdog: add pretimeout support to the core
Message-ID: <20160829185005.GD1610@katana>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1472227681-1405-2-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <1472227681-1405-2-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +	} else {
>  		wdd->timeout = timeout;
> +		/* Disable pretimeout if it doesn't fit the new timeout */
> +		if (wdd->pretimeout >= wdd->timeout)
> +			wdd->pretimeout = 0;

I wonder if we should add a warning here? What do you think?


--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxIPdAAoJEBQN5MwUoCm28PsP/193KdZH/HIBkz25JLE0Jcku
NXCIZcxErDLD27kplfMY7XsNpDKN7fX1/Ri9YqYNYxm/Cq1Iau1dwcRccbd3zxS3
Bs/jmje8AGblPrpaUtyJbDIwXlPHEzMvogXT5Mq/tI8SgcqhlaKPEYDS5BxmjCOE
uQ9T0GasdkNNfTeNdVJUmRMzWIEaPQLIUhVGxlqOTALvWNZNYmF+pEWhiiyGmbN2
TpJAToU37GTLqYus7uHZEaaZJCeSekXdApYQZj2sQvkDbYlQTAOeSkUNR6TMpRia
0X4XnMtr1kahkSIu7CahscPCuCgNxRZgeJCfcQ9Z5FK7Nn5MI8BHO9PHW1pkMHzS
l6I6Wp4P2K34eJxstlUa2TYB8oLZ7B1hNjum/Ts50x9L3Fr//YkNmoFBkfSJ5vm0
60w1xKu3UuOK1sdJdw/dKyt4ZCZ/3Dw8JmE43jLNLDN6x+mF7lEJ9fLVPf6hJ0gK
uJxyK7EFBHr71xkkrJn9pSUNegV1E9Or1AT8QC16ABGUU8jo3rxJW4IY94MFjKYS
MDfKrbZL2QSpjsnn8wDUjh+e2a/LLkFlnD8gBB0GdtNnZk6worRHDPsbht9SjSeI
hQ82XT6xYFriKBu0sHVALJa316FcVAWA0tkhxTRdhDvlC2oglm6Wz2EcbhuZzUbg
bjxBsNJEAC1SMPFW6Ui/
=2x8/
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
