Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJST4H (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 19 Oct 2018 15:56:07 -0400
Date: Fri, 19 Oct 2018 12:50:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Message-ID: <20181019115015.GC5895@sirena.org.uk>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <1539853324-29051-5-git-send-email-p.paillet@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 18, 2018 at 09:02:12AM +0000, Pascal PAILLET-LME wrote:

> +	for (i = 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
> +		/* Parse DT & find regulators to register */
> +		init_data = stpmic1_regulators_matches[i].init_data;
> +		if (init_data)
> +			init_data->regulator_init = &stpmic1_regulator_parse_dt;
> +
> +		rdev = stpmic1_regulator_register(pdev, i, init_data, regul);
> +		if (IS_ERR(rdev))
> +			return PTR_ERR(rdev);

This looks mostly good, the only big thing is this - the default is to
just unconditionally register all the regulators that exist rather than
only those that are configured on that particular platform.  This is a
bit simpler and means that all the readback of the configuration for the
unconfigured regulators is available for diagnostics.  Is there a reason
not to do that?

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJxPYACgkQJNaLcl1U
h9AVFwf9HuCK1nKd89bM5cuVWMEtrJN5wwS0dwfV9NJNvZ8H5h6NdUcTYb8JASZo
c2MckaIg5ZWdFkVtQseoT85lrBAtbROJWGrSks44FXy+fmQM6SBosll+LKRavA2b
1VPuCiyqBHPTUz6+dVUeAQRidxERF+dZdfK2FrJGaw7G96WKeHfg7zQXy4cRNJJ0
kcfl9qNCYjF7I4FKDqugM0gKnEARpRPThYY0agxvSnJvjsR9HAcEKDNh2BBIrDQG
acGQE+u8/nDkD6a0Wo8NgQ+V2GsJeSjMgBVUgl+gUFaoEcogr8t0wuAlnG+kvxtX
/pYld58dINQUYBa8+hAqgvDZK9V+iQ==
=W0oL
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
