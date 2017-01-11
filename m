Return-path: <maxime.ripard@free-electrons.com>
Date: Wed, 11 Jan 2017 13:15:28 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 55/62] watchdog: sunxi_wdt: Convert to use device managed
 functions and other improvements
Message-ID: <20170111121528.lyp6dx2pm7ejd5bx@lukather>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n36lsbvnwopx4ppx"
Content-Disposition: inline
In-Reply-To: <1484100561-17638-4-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--n36lsbvnwopx4ppx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 06:09:09PM -0800, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
>=20
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>=20
> - Drop assignments to otherwise unused variables
> - Drop remove function
> - Drop platform_set_drvdata()
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()
>=20
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--n36lsbvnwopx4ppx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYdiHcAAoJEBx+YmzsjxAgf5oQAIQUO5t+8BK7hVLLFbwL8w0q
QAk6H0hHelYFbRqCXVxHERWkOe5x0fuGYZXowx4R96WTQ7qGSmSPp8s/8j0OpVad
j7dxP3PIV/R4eaofbbx087tRriIovOeYbOZ57DiKYfANXzl7mZxcQF5mXOUtq/5o
Pf+LHHCLhQhPyzBejl4zC6T2ISqOKi7uyYParPZ0v+3SAbU4ch5NUzVmIbhyc10Z
swgPtqhgMvqN3UAU3g3fPacEfy8fPSaylJJjRMs1aA5MpZcsJaw5pBrMqUFX24v4
Isbitk5WH8uW43wMQu0l2VwP9KbTaeQ7kcJZwF1XKhRX+n+0vzxzEL6nCoOLz7cg
JhLDqGSTxzT0ZBP58ncT93htLq049wrgEEMlw61OgWvKENzqMjNmxX+dpS1Oxp5Q
biaUzSJ0GLAguEUXvRZwCqhFBBxDrGPFChz1bT4+qj0L+B5aBJ2Jc1jXKTh7nYNQ
K7CvJGczInh77Wx4cLRnK1I/Iyr+Jswi9W2rftvIOn0WASrVcSYjkIo9NXY2RoYv
FGYzCgzBq/H5qdjw6TUcaleDgi8hl5QBuFV9AM+neZZgKNjAQRQiUB1K2Iggctl5
UqJWNKzLgiPiw75xgNOaZZ/+opfXCFrF4myVjnF6JAHgPm/Gxs7gpXgdNDD3DaOQ
Vipr6TnIuIwY2ptsy2r6
=WCnH
-----END PGP SIGNATURE-----

--n36lsbvnwopx4ppx--
