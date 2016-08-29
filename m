Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37723 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbcH2Ssq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 14:48:46 -0400
Date: Mon, 29 Aug 2016 20:48:36 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 4/7] watchdog: pretimeout: add panic pretimeout
 governor
Message-ID: <20160829184835.GB1610@katana>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1472227681-1405-5-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <1472227681-1405-5-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +
> +#include <watchdog_pretimeout.h>

This include must be in "" to compile.


--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxIODAAoJEBQN5MwUoCm2Ha8P/A917n7Cvat6hgii7u53L2Fo
3o+ht9ktCjAa9RvAfLzCYhKUJfvYT/4aNN2dGboY7Cd2E6fyLkN8t3+hzYcZYte3
jAvqXQqzQDRvKJ67GlBThHcjyHRmJwH+/6NDJTDjeDdQZt0BYE+rFmi4u2cTHSqf
u7K/S462hXMMCaX4JJp2gCiss0xUIRHXuyGwiDynGTQF8wTndaAU+w9aOLVLBYbv
IAtxaADuiYKV0PFNXBZbP38osfChcc1d8DAWTWcwTmrt8byEVwMcm79uHRgqAms5
7NMeaU+ZIM+fdwGFYWccKoUwjxb/C/3824O9PDrXjiBZJxuDaD6HO02XQGDXbU9N
1phfLCqkEPMTuuIdyjtbucrb+QmM56Va3iTuiihhcdqfCBZAv53rLvBAJAralhgU
GvGs+R46X449nlNPj6SdwPbEvf4yVJ1DU0AMs0MHr2qR0VOiQLp6zeAyXXJl8n7g
TOzSraP2dToeCD+1JAWRL2zFAhUzZ2k/xWWt0nUUFup7UA3dCkHzpr6h6bRlv+v5
XG+mxPm30M8wJHTixnauw8zIbxxokHaIRtCGDx+9ziVHxu7oQgsVkbfmfL1R7DfY
FF98VHZi6vLan+pfqgfmOZqzCq592UDbb/ajCILwskqLjXn+j/QHm7CJ2ULKgcog
7W7nbXXwUHRHRrW/+d/7
=GYw3
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
