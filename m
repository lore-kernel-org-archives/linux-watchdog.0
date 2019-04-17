Return-Path: <SRS0=uGyo=ST=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B11C282DD
	for <linux-watchdog@archiver.kernel.org>; Wed, 17 Apr 2019 19:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F3821773
	for <linux-watchdog@archiver.kernel.org>; Wed, 17 Apr 2019 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfDQTBK (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:01:10 -0400
Received: from sauhun.de ([88.99.104.3]:33656 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfDQTBJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 17 Apr 2019 15:01:09 -0400
Received: from localhost (p5486CD54.dip0.t-ipconnect.de [84.134.205.84])
        by pokefinder.org (Postfix) with ESMTPSA id 37A772C088A;
        Wed, 17 Apr 2019 21:01:07 +0200 (CEST)
Date:   Wed, 17 Apr 2019 21:01:06 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH] watchdog: renesas_wdt: support handover from
 bootloader
Message-ID: <20190417190106.GA15544@kunai>
References: <20190415105201.2078-1-wsa+renesas@sang-engineering.com>
 <20190417180556.GA18401@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20190417180556.GA18401@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guenter,

> > driver takes over. If the system hangs in this window, bad luck. So, I'd think
> > it makes sense to have this clock either always-on or to keep the state which
> > came from the firmware.

I wrote this paragraph...

> Is handover even possible if the clock is controlled by clock management ?
> Seems to me the clock would then be turned off through pm, which effectively
> turns off the watchdog. So it will be off between clock/pm initialization
> and the above code, meaning wdt handover from the boot loader is for all
> practical purposes useless if the kernel gets stuck in between.

... because I fully agree with you :)


--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly3d+4ACgkQFA3kzBSg
Kbbp/A//Xbhactcjej2DCp4xVWl5rNs6Ce1tUDDkhgima908MKgxh1zA7ZUh2mth
rJ7DnafdWxtIgAYUEo258g3rca/Jbv/FZN6opbC11SV2WJgnRwiOLid7EGiWtSKN
5hCIvT4X1ZBj7v3uAp2MKP0YrKM2zjYw7MNM+37Twq3fYX9BTsAjzCW6hcKfWDhl
lnww4spyyxWEulC0x0+asjrOwfGyigDg1PxP5lrzaK/3/gfo9tLVQZsVv8fytX8U
I32swvc5hFNQlQt+HonAq+fxKtB3Exj5jHGJ8DeC95pc6lddJtJXtig+FgR5SLy5
ngwGukpQN0X1ZCGASJVD9pM7jmE4PYsRJmuBSaufcXKlayQmrMGNR7kCI34H7vsL
tHLr4mT4QSfjS9l8ZyoWJH5g5jzMGqa7D3dK2OBOsfJ/1EBTgtW0iJ120NCHQn1L
Cik4K54F2K9oX6YmSeKxsdkJQ6z1uhM8cNjpdsSAyCoPUG1922aatcSndIRZ/yM/
HOHHH5Z+Zux4vf6usHGCckIfl7LcMD8JJN6wkzLoEZ+PEcG2eXEjCf/yL4jbS3mY
nwIFygCX7maZMz1dQm3U4le3WKdwPlwGFsXgYbxvbEYQ39554N7MloXIDLbUdhP7
gD79ZyHAj8fSgxq7DF5rn2ST1SdoGIQtrDs1SW1nakRSc0gfMmI=
=AwrI
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
