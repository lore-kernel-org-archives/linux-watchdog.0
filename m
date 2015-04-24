Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33713 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbbDXPZL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 11:25:11 -0400
Date: Fri, 24 Apr 2015 16:24:45 +0100
From: Mark Brown <broonie@kernel.org>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Message-ID: <20150424152445.GR22845@sirena.org.uk>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <7acb2e683450a608adf81e6b820e62b523429101.1429280614.git.stwiss.opensource@diasemi.com>
 <20150418114828.GG26185@sirena.org.uk>
 <6ED8E3B22081A4459DAC7699F3695FB7014B2175E5@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PeBQ4doskhxk04X/"
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B2175E5@SW-EX-MBX02.diasemi.com>
Subject: Re: [PATCH V1 2/6] regulator: da9062: DA9062 regulator driver
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--PeBQ4doskhxk04X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 02:47:06PM +0000, Opensource [Steve Twiss] wrote:
> On 18 April 2015 12:48 Mark Brown wrote:

> Okay. I think I am getting this.
> As of v3.18 there are  newer parts to regulator_desc from the commit=20
> a0c7b16 "regulator: of: Provide simplified DT parsing method"
> The search function is now in the core.=20

> Am I on on the right track with this one?

Yes.

--PeBQ4doskhxk04X/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOmA8AAoJECTWi3JdVIfQoU0H/1d6VpxbZu02WyPC4lLH7equ
l9ntoiG1Sbb+xhBQN/tci3wqw2tAIqt5NzgM2bOj51qutEN5Wd8+zVGGQDkYsLOW
vziBRlhwsLEhR/F2c/t9teKwzpfNSpJquVFqi5gXSmaagWr+fb4oBK4O9oCCHKjn
LGNV9C4328KqgUrSm4od6283oLSvXgU5OueH0wjcRQVKyr+6I36QZOMy9cRD8mra
rqBKS3GNFNMlWbtr7upOviksH6YmgVuUg8I3kdThYaz+JknNpWoMXFo6SMW66KGE
xNWcXawiDShyHlvZCjFOHhVGwWHldoiMLqxk4NeHOzlxSfUT32sXYlYEEh5N6Ho=
=e1Qu
-----END PGP SIGNATURE-----

--PeBQ4doskhxk04X/--
