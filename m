Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC1C10F14
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D67A218FC
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbfDNKa7 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:30:59 -0400
Received: from sauhun.de ([88.99.104.3]:32954 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfDNKa7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 06:30:59 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id 5D9992CF687;
        Sun, 14 Apr 2019 12:30:57 +0200 (CEST)
Date:   Sun, 14 Apr 2019 12:30:57 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 00/16] watchdog: refactor init_timeout and update users
Message-ID: <20190414103056.xp3fgj4at3ze656g@ninjato>
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c4deemzkae32ddte"
Content-Disposition: inline
In-Reply-To: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


--c4deemzkae32ddte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2019 at 12:26:11PM +0200, Wolfram Sang wrote:
> When trying to add DT support to the DA9063 WDT, I didn't want to add yet
> another error message when watchdog_init_timeout fails. The core could do this
> with more detail, and also much more consistent. So, I refactored this routine
> and removed error strings from its callers. Note that DA9063 support is not
> added here because I still need to think about another issue. But this series
> has been tested using the renesas_wdt driver on a Renesas Salvator-XS board
> (R-Car M3N) and build bot is happy, too.

Sorry, I forgot to CC the (although few) driver maintainers. I suggest
to wait for review comments about the general apprach and I will make
sure to CC them for V2 then.


--c4deemzkae32ddte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyzC9wACgkQFA3kzBSg
KbadCw/9GWDoYHFqp2O279zpl5EdFlMK4s5e4S+G+pyujR2gQHmVrzR4erjEbO6f
ECnuswKfxR5vvOaHUnZMiyDgOy2msuNceeCDuhAx7ihWfESZQ6Asq36zpP7kknvK
xW7PqQFvWvRczhrjeZOswE+KLkx1xRvJ8OiT6rY7WHCY8JhA5XJHj26a8aIZq7pT
iOlfzHy6TJj19tTzj/I8QQGOVPDPFBdOBBLXgYjSKuO9Nr8POC/sDsTOn9tuXoJT
VLAyqIJPCkJ/A4Txaqp7ykeTbe+bhr0i4y9elNbnZHScjVHd7rJAOF93PfmK/+fT
0X1IJcKG9xhoMZgb6EmsSdRVqfEGwfa5U3S8VmvEk6Tdq2zVu1fHPl3ZNYUCnvI6
Lu5dkiBKKoZWRluH0AP3vnc6qIvggaLedVBpHIMSqRjX0ZkCLuXrPRmUf8XNnjf5
hbEmkPmyFQfa2WrSR880i5bTLyUsh9z8HfOmXrasrnLR8Nt+qWeDeqYGgrkPLsYS
LP4sfQYsZgawOS5VQM9WeimR2WWrTEV25Cw89SZPPaXjiGHolY1y3/0IikPWG3AA
3CHx1uqfq+ipKb4W+c1NwmbKDp4WijqVnFfYV3puMWn8OH6fYyuBBMlTVPpOc/d5
KGP1oMsAXjwzvwxjhEGTZ3wbzEwYLfuPyfRrRApttAlnkLR26Z4=
=ji5Z
-----END PGP SIGNATURE-----

--c4deemzkae32ddte--
