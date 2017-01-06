Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:37994 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030967AbdAFSPD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Jan 2017 13:15:03 -0500
From: Eric Anholt <eric@anholt.net>
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] watchdog: bcm2835_wdt: Use watchdog core to install restart handler
In-Reply-To: <1483674720-4870-2-git-send-email-linux@roeck-us.net>
References: <1483674720-4870-1-git-send-email-linux@roeck-us.net> <1483674720-4870-2-git-send-email-linux@roeck-us.net>
Date: Fri, 06 Jan 2017 10:15:00 -0800
Message-ID: <87a8b4njh7.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--=-=-=
Content-Type: text/plain

Guenter Roeck <linux@roeck-us.net> writes:

> Use the infrastructure provided by the watchdog core to install
> the restart handler.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Need to call watchdog_set_restart_priority()

Seems fine.

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlhv3qQACgkQtdYpNtH8
nuhhAQ/+Lv7YchYECmuhOMH+87uQrUyo//Ch/A8Dfwg5ajAXFDxjzikhGwNby1zM
s8iOk3nT2qX4j5k04eZqOEV/6XxxPJHz6F+liEz/eeGYYY+BWnaT5ElBM3nPgmTX
ZzP1sOV0rR1dvdESvUrH2KWdBosg+bxbCTIXSaQS9Dxn82m7+0lPencfeTsFpL2c
6ch6h5R5VAY/ncTFxe2vPyLW5VnonXgcdfY0GfDYoSLygfubGGBoGHL8yCt9Mc5u
YTGpc91KCW4Y5zSKgCuZvp8NTftVnkcM3xZq8cLrSdO3COynlmi8eSysQ1XJJAWy
FDWnIOtC7GlJ/PKiYxAc6txC8W9HdLBIhsFh/VAid1cCWRMOKH6WJKtBv28uM9hP
0vLVGL0/bf3rL6yCD2YPzSSW00u08XtoUB3hrHPTIXugnYKD7oNwLTWnz56B2PH4
4VN9GtqBT6SIHPyb0MZ/xQ8MOD5tNBTvV6N6oWY9ft/xlTBwZZ9NkS1PDAvYC38I
VBPYsGiPKgzhVsclPJpiHzBN6Vp6EzYvgyWBz6YQaUw4KBPJE66rx0NlYCA35KXK
RCKI56z36PbcZoZXEs09DKo92xPFI/6Jpej8/Ma8Qvbd8IyFdNkhnsBJv1Zyys18
vuhFAnwRBe4UbRiB38UlXlH7xvYMzvRH6hbTUoBGLMGFochhw8c=
=PzmE
-----END PGP SIGNATURE-----
--=-=-=--
