Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:55764 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbcH0Lil (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 27 Aug 2016 07:38:41 -0400
Subject: Re: Linux-compatible watchdog add-on?
To: Nicolas Boullis <nboullis@debian.org>
References: <20160825163149.GB3636@haddock.home>
 <7ad22fc1-02c1-7d99-657f-770d16c3aa92@rempel-privat.de>
 <20160826231452.GA3890@haddock.home>
Cc: linux-watchdog@vger.kernel.org
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <457b754b-e8cd-4292-58f4-a5ef032899c1@rempel-privat.de>
Date: Sat, 27 Aug 2016 13:38:25 +0200
MIME-Version: 1.0
In-Reply-To: <20160826231452.GA3890@haddock.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7qMh51avX14LRtfbJM1ThuqXGIO7EBoCg"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7qMh51avX14LRtfbJM1ThuqXGIO7EBoCg
Content-Type: multipart/mixed; boundary="THIBQBUdvDNtnUIVnPjdhBNuKSK9xBFO9"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Nicolas Boullis <nboullis@debian.org>
Cc: linux-watchdog@vger.kernel.org
Message-ID: <457b754b-e8cd-4292-58f4-a5ef032899c1@rempel-privat.de>
Subject: Re: Linux-compatible watchdog add-on?
References: <20160825163149.GB3636@haddock.home>
 <7ad22fc1-02c1-7d99-657f-770d16c3aa92@rempel-privat.de>
 <20160826231452.GA3890@haddock.home>
In-Reply-To: <20160826231452.GA3890@haddock.home>

--THIBQBUdvDNtnUIVnPjdhBNuKSK9xBFO9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

Am 27.08.2016 um 01:14 schrieb Nicolas Boullis:
> Hi,
>=20
> On Fri, Aug 26, 2016 at 06:58:15AM +0200, Oleksij Rempel wrote:
>>
>> How about SPI?
>> If yes, you can try this project:
>> https://plus.google.com/102032716864870215256/posts/PwMMKYP5PKR
>> https://plus.google.com/102032716864870215256/posts/QJqPxSi1Str
>>
>> Linux side is configured as watchdog, MCU side currently do only demo
>> blinking, but watchdog should be a main future.
>=20
> Thanks for telling me about this project.
>=20
> But, to be honnest, I don=E2=80=99t really understand what this project=
 is=20
> about. I never hearded about the SSI32 protocol (while I know the SPI=20
> protocol)=E2=80=A6
>=20
> Anyway, as far as I know, my motherboard has no SPI bus=E2=80=A6 I gues=
s I might=20
> buy or design an USB-SPI interface, but I wonder if designing an USB=20
> watchdog wouldn=E2=80=99t be easier=E2=80=A6
>=20
> Anyway, I would still be interested to understand a little more what=20
> that project is about; it might at least be a good source for=20
> inspiration=E2=80=A6
>
This project have different components levels:
1. SPI - it is cheap any mostly available on all SoCs and MCUs. IMO same
can be implemented on UART.
2. Flow control line. SPI don't have it and if we use  MCU with many
tasks on other end, there is no way to predict where we can start our
transfer. The are many ways to implement flow control on SPI, some of
them implemented directly to IPcore which is not really portable.
3. Request/Interrupt line is muxed with Flow Control, it means by using
5 wire we still able to do slave to master transfer and flow control.
4. on transport level it has 4 byte header with some control
information, size and checksumming. Practice has show that even on
stable products we can get some weard DMA or FIFO related bugs so the
transfer got corrupted.
4. LUN or Endpoint number, so one MCU can provide different functions at
same time. For example watchdog, rtc clock, package filter, gpio
extender. At same time since it all done in software we can use unified
linux drivers.
5. App to App acknowledgement, so each side knows if package was
actually delivered.
6. linux side bus implementation, so on linux we create a device tree
with MCU capabilities and drivers are loaded automatically.

In my link i provided a example watchdog driver, but in this case MCU is
only toggling LEDs. Need more time to finish it.

--=20
Regards,
Oleksij


--THIBQBUdvDNtnUIVnPjdhBNuKSK9xBFO9--

--7qMh51avX14LRtfbJM1ThuqXGIO7EBoCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlfBe7YACgkQHwImuRkmbWkaAgD/VfI+ZmvunugJN8tdJBuKbd+o
RYSFOnleCm6QJAatNX4A+QHjCRKeUeFQI2JiwlPrXEkbpYMdtfuVFh8fZqnrGTcv
=yOHn
-----END PGP SIGNATURE-----

--7qMh51avX14LRtfbJM1ThuqXGIO7EBoCg--
