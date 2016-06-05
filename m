Return-path: <wsa@the-dreams.de>
Date: Sun, 5 Jun 2016 11:48:23 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Robin Gong <b38343@freescale.com>
Subject: Re: [PATCH 1/7] watchdog: add watchdog pretimeout framework
Message-ID: <20160605094823.GB1497@katana>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
 <1464183151-4912-2-git-send-email-wsa@the-dreams.de>
 <5747041B.2050707@mentor.com>
 <20160526164136.GB1631@katana>
 <20160526223717.GA6659@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20160526223717.GA6659@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2016 at 03:37:17PM -0700, Guenter Roeck wrote:
> On Thu, May 26, 2016 at 06:41:36PM +0200, Wolfram Sang wrote:
> [ ... ]
> >=20
> > No doubt about that. I had some ideas and thought it is easier to talk
> > over code. If you want to rebase it, too, I'd be happy to check what you
> > came up with to solve the problems. I might still argue that I prefer
> > the less-code approach, but it will be Guenter's / Wim's decision, of
> > course.
> >=20
> I have a large back-log of patches to review. Simple patches with less co=
de
> will get preferential treating. The more complex, the higher the likelyho=
od
> that the patches get pushed to the end of the queue.
>=20
> Giving a quick glance, I liked Wolfram's patches because they seemed to
> be simple and straightforward. I hope the next version won't add too much
> additional complexity.

Vladimir, did you have time to look into this?

I can offer to resend this series on-top of v4.7-rc1 with the core patch
re-attributed to Vladimir. Then we can review the basic stuff now, and
can discuss/deal with the bottom half handling incrementally.

Sounds good?


--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXU/VnAAoJEBQN5MwUoCm2rUMP/j4Qduipn3DYN0XWDI8OOeT7
8S+gVrr8fblUFZpUtpEj7kBQDX2otOqlWYZptDUQcKqhfNcjaExq7PjoZsZ9t3ud
f17Tq1QllNGSPAKBpNio9+ou3FblmGFYuLrg5Ic2bD6r5wVlE3LKLyiDtYk6tIbq
V5wuuIGh0oHWrBQ7zzrOcrqKy4BHDtQqfkIS3luBe/+AOXMRFTMGifZ7UOm7i/qf
SWhPe0hafFIyzkklAqtLGkbKSQ9y6wJyPy22NrAjNqtQ0WgXV7pKA6Ijl+ziRM3F
bDBDBwLyg/sR7lGc4axjdWM9It32Uqy/YN4M9Xp3MIpANq4YuP+CjvtEUQw0e/Mj
QmflosgIK83QKDg2JW1Z8BVJzvkQ+W6Qyv3pp8ZS0YrEIRqqjmmmS64kAQOs8C2e
ogAG+lhLyTiOgPoogN7TBfaGC26cAf6YDtTJok2pg+s27RSZdqAY7mmolbeSnsrS
ya8DboyTmm7L7KXyF8CnGvc05dmpIFASOvu+GhymlasqFz2V0TdGEjPMfga41627
DYa8Ug7mukemymVM6AdPxgCwaMNbn63/RB585u6jL2Hd6Rth2f3A8AF6xQdSHZXC
mKz9iiww/OjQn3vKfVWVdlluKozy4Vjbc6PMCw1utxs/ACpF/g18gxVonayZyUc4
MBIJgpk3w5a9610kS3Av
=t/3i
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
