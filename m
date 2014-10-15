Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:59802 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbaJOIEa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Oct 2014 04:04:30 -0400
Date: Wed, 15 Oct 2014 10:04:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] clocksource: tegra: Register watchdog device
Message-ID: <20141015080425.GB12807@ulmo>
References: <1413201922-4210-1-git-send-email-thierry.reding@gmail.com>
 <1413201922-4210-2-git-send-email-thierry.reding@gmail.com>
 <543C00E2.2090806@roeck-us.net>
 <20141014104218.GG18993@ulmo>
 <543D72DD.4000501@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <543D72DD.4000501@wwwdotorg.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 01:00:45PM -0600, Stephen Warren wrote:
> On 10/14/2014 04:42 AM, Thierry Reding wrote:
> >On Mon, Oct 13, 2014 at 09:42:10AM -0700, Guenter Roeck wrote:
> >>On 10/13/2014 05:05 AM, Thierry Reding wrote:
> >>>From: Thierry Reding <treding@nvidia.com>
> >>>
> >>>The watchdog timer is part of the timer controller block on Tegra. In
> >>>order to avoid access to the same registers from two drivers, register
> >>>the watchdog device from the clocksource driver.
> >>>
> >>>Signed-off-by: Thierry Reding <treding@nvidia.com>
> >>
> >>Does that really make sense ?
> >>
> >>A couple of callbacks into the clock driver to implement register acces=
ses
> >>might be a better approach.
> >
> >I guess that would be a valid approach as well. It has the downside of
> >requiring the addition of at least two globally visible symbols to the
> >kernel. It also means that we'd need to somehow pass around a struct
> >device for diagnostic messages and so on. Dealing with all of that seems
> >like much more of a burden than this.
> >
> >Also if you look at the diffstat this approach allows us to get rid of
> >80 lines of code. Adding a custom mechanism to share the register space
> >would be more likely to result in a positive diffstat.
>=20
> FWIW, (although I haven't read the patches), the general idea of register=
ing
> a single driver for each HW block makes sense to me. While we've split up=
 HW
> blocks into separate drivers in the past, I think that's just made things
> more complex without much benefit, so I think those decisions were a mist=
ake
> in retrospect. If we do actually need to split things up into separate
> drivers, we should use MFD rather than multiple unrelated top-level drive=
rs.
> That way, we will have a single top-level driver that gets instantiated f=
rom
> a single DT node (or platform device in a board file or ACPI thing or ...)

MFD isn't fundamentally different from what Guenter proposed. While it
gives us a framework to work with rather than having to roll our own, it
comes with its own set of problems. One of the bigger problems that I
can imagine is that if we rigorously apply this split to every device
that exposes more than one subsystem interface, drivers/mfd is going to
explode.

Obviously the downside of exposing multiple interfaces in one driver is
that we spread drivers all over the kernel, so it becomes harder to deal
with API changes and such. On the other hand we do have good tools
available for that (coccinelle) and we already have that situation right
now at least for things that are in drivers/staging.

One other problem with having one driver expose multiple interfaces is
how to choose which tree to merge it through. Often I guess the logical
choice would be the primary functionality of the block. Usually this
would be the one that occupies the majority of the code. One recent
example is a display controller that contains registers to control a PWM
output typically used for backlight.

Thierry

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUPiqJAAoJEN0jrNd/PrOhtjgP/02/a799aIs+w3v+jbpAd7fq
dp3N70uhDVxHaRTVuF8XSIWpHJwFmmp9KszYyFtu6g84Ard7sJIS6H+Hhf7vUZ94
zoN+C5wW6FOXSulEzbpUCB+d6XlI0pxuc0pJCJ6C4fnbBIB5Eg3uDhGsHmKPwhFW
A1njTEvIOnI6+H3LoJSirw78/U8j490AlMnOqshK4aDHNTIOIHsqBGggUdBGUvLQ
40UfLtFrqlHWxYauz9ZgCl6OgG2PG62cS4HNY8PBcDWhwB4rFpG9rrFtyCItyaXK
yQPQgpd7FPOlUbg4UJ+FmljPAXiuh3nmwLNaHFbRJtZ37gbhdc6W1X5Qtoz/Dba2
shKKF3LKHLd36hJtezG2MmcrbjDJYF/hukAH8+BuAD78yVF8G6NUGa/fEeEqVRnx
ZGdebgwgSXNIjd2KrhOa+zAV5VshTbve8R18iorLYCFptpKOUZYhYdjwkLKCS0W8
D7CIgthTnmE9gmbFTHzB/keyqt5JHtlAL9CChCQfKSRZx27e2j+ocBc5IMLsgBMg
5HY/9E3sqlmwC2gU7MGBiSYq7h8/ZUJHBRbYpYMtMSkt6JMIwSQmOMZl7pu+Ghug
AIcqbCRPc3z7c05C3/dsapFFdLbmWExEaNTqXjM4Tof47kaaq5OjaPERWZiDM1Ef
15aHgTc1wMOjNNXJML18
=1J3P
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
