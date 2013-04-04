Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:34738 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765160Ab3DDWXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Apr 2013 18:23:34 -0400
From: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: 3.8.3 and 3.9git occasional watchdog oops
Date: Fri, 5 Apr 2013 00:23:30 +0200
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201303142154.20501.arekm@maven.pl>
In-Reply-To: <201303142154.20501.arekm@maven.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201304050023.31143.a.miskiewicz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thursday 14 of March 2013, Arkadiusz Mi=C5=9Bkiewicz wrote:
> Hi.
>=20
> Just hit watchdog related oops in 3.8.3 kernel. Unfortunately photos on=
ly.
>=20
> http://ixion.pld-linux.org/~arekm/watchdog-oops-3.8.3/IMG_8942.JPG
> http://ixion.pld-linux.org/~arekm/watchdog-oops-3.8.3/IMG_8941.JPG

3.9git from today isn't any better unfortunately:

http://ixion.pld-linux.org/~arekm/watchdog-oops-3.9git.jpg

>=20
> oops started after I enabled systemd watchdog functionality. Cannot
> reproduce easily.
>=20
> watchdog here (thinkpad t400) is:
>  iTCO_wdt: Found a ICH9M-E TCO device (Version=3D2, TCOBASE=3D0x1060)


--=20
Arkadiusz Mi=C5=9Bkiewicz, arekm / maven.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
