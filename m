Return-path: <thierry.reding@gmail.com>
Date: Tue, 14 Oct 2014 12:42:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] clocksource: tegra: Register watchdog device
Message-ID: <20141014104218.GG18993@ulmo>
References: <1413201922-4210-1-git-send-email-thierry.reding@gmail.com>
 <1413201922-4210-2-git-send-email-thierry.reding@gmail.com>
 <543C00E2.2090806@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <543C00E2.2090806@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2014 at 09:42:10AM -0700, Guenter Roeck wrote:
> On 10/13/2014 05:05 AM, Thierry Reding wrote:
> >From: Thierry Reding <treding@nvidia.com>
> >
> >The watchdog timer is part of the timer controller block on Tegra. In
> >order to avoid access to the same registers from two drivers, register
> >the watchdog device from the clocksource driver.
> >
> >Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Does that really make sense ?
>=20
> A couple of callbacks into the clock driver to implement register accesses
> might be a better approach.

I guess that would be a valid approach as well. It has the downside of
requiring the addition of at least two globally visible symbols to the
kernel. It also means that we'd need to somehow pass around a struct
device for diagnostic messages and so on. Dealing with all of that seems
like much more of a burden than this.

Also if you look at the diffstat this approach allows us to get rid of
80 lines of code. Adding a custom mechanism to share the register space
would be more likely to result in a positive diffstat.

Thierry

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUPP4KAAoJEN0jrNd/PrOhcbQP/0X9TngYYVU84Yr20761X/oL
3/fwr5r3quRwmikOOqhxzTSRvHJS9nfcq1oMTI3nQ8tvlGahGKZ5bDdhfJHQHt3d
mw2DF4l1YwuIqlyhkeqSs3QZy8zudOcb+NWrFhTy5HuXZ9aRfpUFaS5Tcl0fGm+X
oQsjCdmfKy6IC7p+end2Cj/XxL0En1PsmrfCr2rYj0djfj/LfjIPLjvWvKBGhJrW
ojTp2mhNaSrSoDSl3XGQXOz+SJyoB7p6lrErp8EKjDddWoyaOrjptz6JMtug+P1/
pxK7ij2dadm7+1qIKbwFkdxfM1QZrUbcub8ge6v6GsXFy4PsFJlaZ+Qem8drY4Zb
Qj0sU/Z/+9hpoGS1FiPPCb9/FzmO/tRYAj44FqzfkTTmprPbv8hKkY59jrFAwRW1
uvApOyrU7oSa6fR3RfhLMJJQ8BNECUdB+Q1CzMIaRrkCAVw1bFy9aQCxRuWQJ8AZ
9NBA1RUDUyLuj3mL5dGMSNNYYv/RnsfY+xQxLoz929Indg8Ctw4LEl1hyBKA1tR4
IagPanX+tTUlj+PrdoeRM/7cm+6fV2mUD+s5MfKVmLVqzOVBsx/ucmsA6B1JQE2O
25EgU/LuiFgFj/O4sv/qdtrPIiD2ku5+hv+G7/1C5V/N25loQ7jm9Oaq0wvaBLyw
7AX45LERBfS/5kepfAy6
=xjyA
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
