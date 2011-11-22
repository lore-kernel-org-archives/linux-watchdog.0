Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48990 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1KVM5K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Nov 2011 07:57:10 -0500
MIME-Version: 1.0
In-Reply-To: <20111122112212.GD2734@pengutronix.de>
References: <4ecb84b9.48rmEWqC3D6x18iE%marc.vertes@sigfox.com> <20111122112212.GD2734@pengutronix.de>
From: Rahul Bedarkar <rpal143@gmail.com>
Date: Tue, 22 Nov 2011 18:26:44 +0530
Message-ID: <CA+NV+VkBXzjDWLigLyuXaHyRfvwt5d=NBczbFYt0qYnZKHn+AA@mail.gmail.com>
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Marc Vertes <marc.vertes@sigfox.com>, wim@iguana.be,
	Sebroeck@vger.kernel.org, Van@vger.kernel.org, Wim@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	HaraldWelte@viatech.com, Welte@vger.kernel.org,
	Harald@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2011 at 4:52 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> On Tue, Nov 22, 2011 at 12:17:13PM +0100, Marc Vertes wrote:
>> Add a new driver for the hardware watchdog timer on VIA chipsets.
>> Tested on a Artigo A1100, VX855 chipset.
>>
>> Signed-off-by: Marc Vertes <marc.vertes@sigfox.com>
>
> New watchdog drivers should use the framework. Have a look at
> Documentation/watchdog/convert_drivers_to_kernel_api.txt for a guide. I=
t
> is mainly removing code, though.
I will take care of this.

Thanks,
Rahul Bedarkar
>
> Thanks,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www=
.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk7LheQACgkQD27XaX1/VRutYACdEU7AXPGKVZ9fV6SaT2B010iK
> LhAAoMBk4btczZxmA/0iXTLQQwqq0Jqt
> =3Dbziw
> -----END PGP SIGNATURE-----
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
