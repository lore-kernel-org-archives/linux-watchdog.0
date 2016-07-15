Return-path: <anholt@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, linux-watchdog@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: bcm2835_wdt: remove redundant ->set_timeout callback
In-Reply-To: <1468570524-18222-2-git-send-email-rasmus.villemoes@prevas.dk>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk> <1468570524-18222-2-git-send-email-rasmus.villemoes@prevas.dk>
Date: Fri, 15 Jul 2016 11:58:32 -0700
Message-ID: <87shva919j.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-watchdog@vger.kernel.org>

--=-=-=
Content-Type: text/plain

Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:

> bcm2835_wdt_set_timeout does exactly what the watchdog framework does
> in the absence of a ->set_timeout callback (see watchdog_set_timeout
> in watchdog_dev.c), so remove it.

These first two patches are:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXiTJZAAoJELXWKTbR/J7oLfoP/3PyY7j8c1dSTcnFmO4m2dFF
ThjDlAWPLNEFx7mNeVUmUD5i9w91mPPOXaNpWoKB9DXWESUPbZ7B8jLkhKC7jiuL
6GY7aYzd71+pj8bBjEOOIUgxWMqQB/ijIlfSJqyNn8KB+uRlLy4HWsGwUIgaDThh
gStFnN2q35y1GLUA8gtDesFsPxrVfQ1v2BDQLtlKxRuqKrXjuToe0ExtB9VvJjeF
mcA2ioCvUWGfV1B1fRfkNnQ3uX651by+ft1/5eUyHSYineL8pXVnl9kpFEg80oob
w24pUft9KuLCIuSFCUCfh4owLNTBBlcI7LvaGgA0v/5WZZKcpCAPEYIutIigRXhp
hhcAb4zr/KVnOW2DUDz4L7byblqOtyU3y5vnrj5I3X25DxvvMm7RXPIn+EW/Ye2N
rjU5wlqb3eAswXuqyPF4BdSJQNA/jK58nFv4vmxO7fww6h2u2FOoQ3LPAgcgV57h
xrfP8LNc595JtSLTJrWHPNA39ZjH9Kf2N6AqLbnILWnhyexYdjnz9nOc8VF/WDAb
p7DdQ4hfwAOb/eupXwbNASH0scOodOzK+rfuoTaenSeCHQeOnzS6XIiiSQK0g26O
TuzYZwVVBHO2NGihyXQCWn3zwB5/4pCpeXDwnFfEzQMU8nhJVxsSyM+SQXVrG3gb
4iBnVgSJxgzysRknhzQS
=zHK4
-----END PGP SIGNATURE-----
--=-=-=--
