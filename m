Return-path: <wsa@the-dreams.de>
Date: Thu, 26 May 2016 18:41:36 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>
Subject: Re: [PATCH 1/7] watchdog: add watchdog pretimeout framework
Message-ID: <20160526164136.GB1631@katana>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
 <1464183151-4912-2-git-send-email-wsa@the-dreams.de>
 <5747041B.2050707@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <5747041B.2050707@mentor.com>
List-ID: <linux-watchdog@vger.kernel.org>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

great to see you still have capacity for this series :)

> The thing is that I'm particularly interested in
>=20
> 1) sleeping governors,
> 2) userspace notification of any appropriate kind, but preferably not by
>    adding a clumsy .poll callback, uevent is the best IMHO.

I am totally open that poll might not be a good idea, but why do you
think uevent is best? (Disclaimer: I don't do much userspace code)

> The userspace sleeping governor is the only one proposed for a mainline,
> however the whole idea of having a framework is to allow users to write
> their own private governors, and that's exactly what we need and use.

One reason I decided to drop 'can_sleep' is that I guessed 98% of users
will be happy with the panic, noop, and userspace governers. 2% might
need custom governors from which maybe not even all need to sleep.
Chances are high IMO that these govenors will be out-of-tree code, so
having all this additional complexity for some out-of-tree govenors was
questionable to me. I wondered if it would make sense to let those
govenors do the bottom half handling themselves.

There was also a technical reason: The dev pointer was first moved to
watchdog_device private data before it was ultimately removed. So, while
trying to fix this, the code got more and more complicated which led me
to the decision to go the other way around: make the code simpler so it
will be easier maintainable in the future.

> So the original complexity has its state-of-the-art grounds, and for
> sake of getting a solid picture for reviewers and users it is better to
> introduce sleeping functionality right from the beginning.

I still wonder if bottom half handling shouldn't be put to the governors
which need that.

> I know it is quite complex, probably it might be better to add it to
> the series as a separate patch?

That might help the initial review.

> Thanks for pushing it, but do you think that the authorship of the
> code can be preserved?

I changed the authorship because I did one fundamental change to your
original design. Not knowing if you'd approve of that, I didn't want to
put your sticker on something you might not even like.

> Feel free to ask me to rebase the change and so on, patch review procedure
> is well established and I'm pretty sure I can cope with it.

No doubt about that. I had some ideas and thought it is easier to talk
over code. If you want to rebase it, too, I'd be happy to check what you
came up with to solve the problems. I might still argue that I prefer
the less-code approach, but it will be Guenter's / Wim's decision, of
course.

And I apologize for not contacting you beforehand which would have been
friendly. I got a rush on hacking it and wanted to show what I came up
with. No offence, sorry!

Thanks,

   Wolfram


--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXRydAAAoJEBQN5MwUoCm2sF4P/1dThZKRTux1oHeu9LGOSJxm
6PgyyPGy5cUTlQkXrq+koV0C9g5J/6X4gsHEdoGeMgEo3cEbnIu2wS0htonW/H89
zLBpiFd9FLxDdOOizwU4WwnKHhTmkpUwwCDJUGOGblFo3MJ1gkMPlYqVt9kYtdVA
r8CJzvJA+SjN4CnFjt9ByHdipXaSVrEXP+82NKsWisj8vZQ2i5xvsMP6hPLYY0Xf
a1clckW5d3G/nm+Yr7OtwNCfh3JSjiCRUOjkrNBXRJ6pmHwHBqJ0GZvh9uwoWtPh
PDoCNcxQbhL7S7DSe9njx3WMzKnuMuqlO7AZBEJUhr7Oc7j5p629HFor7jvEAOWS
rVO8KeDrCt6PdtCxtOhEDiUJkYzfaxYG76pOlfJSPV3Svvhvp43XwpNN2RgJhRQX
vgHQ9qB4cCYjRms3H78zrS4U4Y1SpeHKD/cEw4n9LsmvGpwNZPnkTvTlWcQoNQ07
3scJ2oFek8xGDPrvBlqUElqutovdLNIIebABiV7CxDClm4zygFaO4VE7M72qtI/L
q7Gf2PT8CRGSkJm6ubhLyorspiQSaAvsKTLvCEqbnqfGPJENupCVHFp9uODrwIbJ
xHD6qcfv30E2z935UZWQ7O2/LZUikCIc89JrCW6nzfJUlFGHd5jSekD3bahZ2J5W
4CsPTaaE+KPusfdo2nDs
=tD21
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
