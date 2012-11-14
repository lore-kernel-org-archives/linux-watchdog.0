Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:45298 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161012Ab2KNKnX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Nov 2012 05:43:23 -0500
Message-ID: <50A375C9.6000405@openwrt.org>
Date: Wed, 14 Nov 2012 11:43:21 +0100
From: Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To: Gabor Juhos <juhosg@openwrt.org>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ath79_wdt: convert to use module_platform_driver
References: <1344951319-13821-1-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1344951319-13821-1-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-2
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

2012.08.14. 15:35 keltez=E9ssel, Gabor Juhos =EDrta:
> This makes the code a bit smaller by getting rid of
> some boilerplate code.
>=20
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

Ping?
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
