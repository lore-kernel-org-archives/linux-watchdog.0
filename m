Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tryphon.debian.net ([109.190.112.8]:51612 "EHLO mailhost.home"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932336AbcHZXPM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 Aug 2016 19:15:12 -0400
Date: Sat, 27 Aug 2016 01:14:52 +0200
From: Nicolas Boullis <nboullis@debian.org>
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: Linux-compatible watchdog add-on?
Message-ID: <20160826231452.GA3890@haddock.home>
References: <20160825163149.GB3636@haddock.home>
 <7ad22fc1-02c1-7d99-657f-770d16c3aa92@rempel-privat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ad22fc1-02c1-7d99-657f-770d16c3aa92@rempel-privat.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 26, 2016 at 06:58:15AM +0200, Oleksij Rempel wrote:
>=20
> How about SPI?
> If yes, you can try this project:
> https://plus.google.com/102032716864870215256/posts/PwMMKYP5PKR
> https://plus.google.com/102032716864870215256/posts/QJqPxSi1Str
>=20
> Linux side is configured as watchdog, MCU side currently do only demo
> blinking, but watchdog should be a main future.

Thanks for telling me about this project.

But, to be honnest, I don=E2=80=99t really understand what this project i=
s=20
about. I never hearded about the SSI32 protocol (while I know the SPI=20
protocol)=E2=80=A6

Anyway, as far as I know, my motherboard has no SPI bus=E2=80=A6 I guess =
I might=20
buy or design an USB-SPI interface, but I wonder if designing an USB=20
watchdog wouldn=E2=80=99t be easier=E2=80=A6

Anyway, I would still be interested to understand a little more what=20
that project is about; it might at least be a good source for=20
inspiration=E2=80=A6


Cheers,

--=20
Nicolas Boullis
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
