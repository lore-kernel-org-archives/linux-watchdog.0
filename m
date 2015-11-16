Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4985 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbbKPKsy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 Nov 2015 05:48:54 -0500
Date: Mon, 16 Nov 2015 11:48:43 +0100
From: Thierry Reding <treding@nvidia.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Andrew Chew <achew@nvidia.com>, <linux-watchdog@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<abrestic@chromium.org>, <swarren@nvidia.com>,
	<jimmzhang@nvidia.com>, <wim@iguana.be>
Subject: Re: [PATCH] watchdog: tegra: Stop watchdog first if restarting
Message-ID: <20151116104841.GA31033@ulmo.nvidia.com>
References: <1447114298-5516-1-git-send-email-achew@nvidia.com>
 <56463F7E.8040008@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <56463F7E.8040008@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2015 at 11:52:30AM -0800, Guenter Roeck wrote:
> On 11/09/2015 04:11 PM, Andrew Chew wrote:
> >If we need to restart the watchdog due to someone changing the timeout
> >interval, stop the watchdog before restarting it.  Otherwise, the new
> >timeout doesn't seem to take.
> >
> >Signed-off-by: Andrew Chew <achew@nvidia.com>
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>=20
> Some feedback from the maintainers would be helpful, though,
> especially if there is some other means to change the timeout
> without stopping the watchdog.

I don't think there is. The TIMER_WDT<w>_COMMAND_0 register has this
description:

	"The StartCounter bit enables watchdog counter operation, loads
	the watchdog counter, starts the watchdog timer to count down,
	resets the expiration count to 0, and clears all flags. Also
	used as restart.
=09
	..."

The way I read this is that the watchdog period (the field that the
wdd->timeout value gets written to) is latched when the StartCounter
bit transitions from 0 to 1. So this change looks correct to me:

Reviewed-by: Thierry Reding <treding@nvidia.com>

Andrew, it might be worthwhile to file an internal bug report to see if
we can get the TRM updated with a more explicit programming sequence or
at least get confirmation from one of the hardware designers whether or
not this is the correct sequence when changing the period.

Thierry

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWSbSHAAoJEN0jrNd/PrOhvzMP/RTwkcp/xAmEd96jSU4U84oE
7rs7/PNq7x7xmLMiUJWpSGzn3ptuFIko0gpZ5Rtoa2y/rGjio2bGwedGFKF4LDX4
hcisBkbo1RMkOLMZ2zvJpZ/AwaVLFAWX/z1HM+5ghsHJoNYsEn6gwCGCoPKKp6wx
WrUM8zfix1JmrVMoF4biGb7tCw4gJ2dnz+mAhpKHRPezb0Ylnq1wUUgg5N9Xfsfm
kTxLUITvGqGYue0CJ0Wi4ImTSnCWJ1SbTX66ilLjW18RZEjumW0R9pBWwA7Gt0MG
BAFEvhK29M3JOL8pFV5Id90J0cpCvgnw7DMXge/XVts1UxMIudkiuvYIQpiziyJn
BYKyuKJqiB32Ah6b0CiDzlV4f1zZda1ujneWkomm23PtlmyRAAVgLSvI1R0mjjdL
zj7eNSgn2dKh6IMdV05oYEdjhP44UZQOhyQZJhyr3OKzbwaeQh0hxgEXJal7GjH7
XwNJWk4yhwKZO4isP05YjcjCizccJsQpbLMaFPX+nO9O6EbiFkgmMYBzpJnRy+oZ
EebOPOFQb5KVxyRZFbS3klJ98wOKxNk3hpTlYGgQRz6ZRhf9LgcTCC3RnOOzlrDL
1ckd3xt/3SQi3HqrtmD5vPH/4jhD7TFhvQAllx1oRtuta5Mu9IRvbWm1C/ubmFRK
w1GHp1KiuSRgJpPzw5D4
=PTai
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
