Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF139C4332F
	for <linux-watchdog@archiver.kernel.org>; Tue,  8 Feb 2022 13:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350255AbiBHNQN (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349864AbiBHMpA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 8 Feb 2022 07:45:00 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41303C03FEC0
        for <linux-watchdog@vger.kernel.org>; Tue,  8 Feb 2022 04:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=mblPKvsTR+I38VBuTL3AMx3pOcg6
        Ef8IgRkhKBFuNgU=; b=qMBmciIXgm9mIqfnNnuy1GxVTBCm9tAO5J0INHCm1qRK
        ai5Am6gaNi2jpsyZoL7/l+u3C4p6vXaC1/hcsqzv2J7ywpwfbbKw5JPbPP8rA8VO
        2YUUZZ0kPN8raQwnbfrRuB3Rq5dlXQPBcS289NUEHWeL7p/+i9yzEIHoOeEAqCA=
Received: (qmail 251182 invoked from network); 8 Feb 2022 13:38:17 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Feb 2022 13:38:17 +0100
X-UD-Smtp-Session: l3s3148p1@0J7M/YDXYMkgAQnoAF1FAEKPHF9sYOFO
Date:   Tue, 8 Feb 2022 13:38:17 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        LUU HOAI <hoai.luu.ub@renesas.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/5] clk: renesas: r8a779f0: Add WDT clock
Message-ID: <YgJkOVpdZdMWj0m6@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        LUU HOAI <hoai.luu.ub@renesas.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1642525158.git.geert+renesas@glider.be>
 <8d9b280065a663f2cf31db7b21a010aa781a0af1.1642525158.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CuXxExDNR0gwWf+V"
Content-Disposition: inline
In-Reply-To: <8d9b280065a663f2cf31db7b21a010aa781a0af1.1642525158.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


--CuXxExDNR0gwWf+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 18, 2022 at 06:09:01PM +0100, Geert Uytterhoeven wrote:
> Add the module clock used by the RCLK Watchdog Timer (RWDT) on the
> Renesas R-Car S4-8 (r8a779f0) SoC.  Mark it as a critical clock, to
> ensure uninterrupted watchdog operation.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--CuXxExDNR0gwWf+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmICZDkACgkQFA3kzBSg
KbYRxQ//UzcAb6CurhSVTJgjpRYr3RCkJdwUUJ5icYWg8tinwKd2litbjZFFJgp4
+VCbypK2gK3a2hfdZZpelee9hCFGpd95sfFQUm12HPJ2wIsj+pBW0Feuem0lCQbT
JqYTt259nxMudemRt1JZz3oYKC4NUdYXuzIPF8Bm50p8AL+ANNJThbc4tEXjQbUc
txaP3dbbv4nNDlf2NCYPQQne+k6zyYnMqoi1a8UMD8wxZARnsnH/HwsyjF5Yg/a7
YhynhkpeaLDIo7VsFYZbEQCjGLY560lwVzzUo8a+suzKCqFGarb70z4vCIs589Bb
qHdRhCCTf3qWNRt2ziO1lxVWrRRpXA9MstfL+CP36WZqVSwqfFWn0tOwHaITweKD
wqN9Zcygz4kZDQzaSpoZTLnfcfYNjr/leXrgn+oX5pVM8J7axQDBe74uA9myPylE
IoUbtc+qRrRQ4FATKWVGW9tQFh9aBquawg0Sf75/P01f4us2RdnxXZhkHJQNs35P
QQhxjzkH5WU+S3vfecU/hyM6m4HL74xakN+un6vghWHAy514hd+f+9SQEKlBvGGc
rNHRNACIQdZUvxcBtPtJyqfYL/1GOjVSNlYl4/KhFM0TgsOwGZZSD9KrtsxyXTX7
9yZImUJf0r+7vEkwQQYiN3t22C4gk93u9AHhiZ8nSWftK/fIkwk=
=akA/
-----END PGP SIGNATURE-----

--CuXxExDNR0gwWf+V--
