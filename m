Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:45984 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdANG1f (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 14 Jan 2017 01:27:35 -0500
From: Eric Anholt <eric@anholt.net>
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 05/62] watchdog: bcm2835_wdt: Convert to use device managed functions and other improvements
In-Reply-To: <1484091325-9199-6-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net> <1484091325-9199-6-git-send-email-linux@roeck-us.net>
Date: Fri, 13 Jan 2017 22:27:32 -0800
Message-ID: <87fukmi2az.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--=-=-=
Content-Type: text/plain

Guenter Roeck <linux@roeck-us.net> writes:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Drop assignments to otherwise unused variables
> - Replace of_iomap() with platform_get_resource() followed by
>   devm_ioremap_resource()

Every time I see this pattern I wish we had a
devm_ioremap_platform_resource().

> - Replace &pdev->dev with dev if 'struct device *dev' is a declared
>   variable
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()

I'm trusting you here that this last change is right.  All the rest of
it looks good:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlh5xNQACgkQtdYpNtH8
nujMqQ//Vqu4eQo3DzCOo7vCZtmf5733+jLLDLLeSYSdJKiOd7TmxmRcSp25fwhm
vUUjRWeEmVdkyEUXNtU2HJsgTUA3WXFAwckdjqP9WbxXHDk/6w5I3Z/LDuZMzCoD
wq7le3WosUft5ICwR6KqgLwPaKfEBG5L23dVitrvMkubgDw21pPrsTRGizFk5k+U
Sne8ctlHfTuroKP1P8DGq0B2woxlVbFoqTmzsonspNXZxvPgNmRyEbNb18M1D2kN
mMaaSbwPMrksHgCqqlwkEHu4qvxx6WT8XftiCPxV41TRHGHRORLSmL/GUyb2O63z
3x67euf/Th50HujzibibJ8U2ddoAJoG9lRS9S35K884h3lfssagXNOnWG9vpZqMY
486gvxd1d9DhLedUwfPpc5yO16vjCjV+VVp5sTLWSM4DHRyUYzrxjDrM9opKcZxR
AZwflKe4oeRjRUSYaBGgBh2kF8k/9rR/Ab4RsccNIv6AN5Cf8NpKhHn/V+3HkURp
JicCGMLLtt/IikErq2M2XgvGtbvC7Vlaty6OjecnSMmP22DwMEYncMdGBqkb8ChR
f8ZCs629AAQV4vj6cEYM0FkNerhtVjoqOcNSDxcHtNM1gBEgTHUbbMa3jKLgKj02
YqXXV4oF5mhH21GUoWqwf/0BDsq1h9hUMl3TdnR7eNCmmUMHGVE=
=asW8
-----END PGP SIGNATURE-----
--=-=-=--
