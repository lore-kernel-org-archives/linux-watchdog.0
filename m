Return-path: <wsa@the-dreams.de>
Date: Mon, 27 Jun 2016 17:33:56 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robin Gong <b38343@freescale.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: add pretimeout support to the core
Message-ID: <20160627153356.GA3505@katana>
References: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1466902865-14354-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <576F3E2E.7060606@roeck-us.net>
 <20160627093707.GD1602@katana>
 <57712AF4.80104@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <57712AF4.80104@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >I liked the is_visible() change right away, so these patches are fine.
> >Guenter, what is your take on upstreaming the softdog pretimeout
> >support? I'd think it would be good to have for testing purposes. It
> >would also help me to upstream the busybox patch for the watchdog
> >applet.
> >
>=20
> Sure, but the current patch series doesn't include watchdog_notify_pretim=
eout(),
> or am I missing something ?

It would be hardcoded to "panic" for now and later converted.


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcUdkAAoJEBQN5MwUoCm2uREP/1c2hkkjGfLyo/Wv/2rhsmUE
35krLEbzbBWMGplW/l/uiPh1A91latTUwdKMJjOzJOw/ic4BX3NIKLzn+rb/PNlc
CTvhY6seYqYEhRU91Y1nQICOb0huFRzHE2AaSWoS9cgPaEMIjBEwSM9EaClOwSzh
K1Jqsz4e60RmEZlzviSLBA1hxcWIoBADzt15cdTd4TjnWpD1pWfTXyEu7pIeH3hb
Rh7MkG6C3vLkU4YEu4EvauIv6dYlYYJcJIZkGxvtBLzSvaTFj0BV0ySemTJLI3Pk
LLEhbsqjS8Q6bjzeVhxN/yyfbFCxxcvI0vabVXnf7OVp6woKfjMVqC9JhdCRENUe
G1vxzLucuOTCy6K0EMvB/IGsC734JdU4Tb8pBxNzRNInaalz64cnRS5dOZ+hlQAG
eZPG08XJDsXp1kkXWSG5+UN/HReXZueMjmlKx7D3wk4KZmT8W85uIzM++dL3z5Jr
68woWbbEhToRVfc2Sq4eN+PnABOSwFVv11ad3/KcCJgiHHfWqv/mpWjciUEOmUN6
f6minLd/RyhKYafyVBGspG2K5pJdu2gVqTQKZFvFgCYmszD9Vfq7PhZX67bd3rzk
xw8NCldOgHy5UYy8xT40uAyRwGbmnr6NERpaH5c3XFRT3V2T9ClKCpVQCoVH9rY8
guZUT0TPw7DObxizto3B
=79NU
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
