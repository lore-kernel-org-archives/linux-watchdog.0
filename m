Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59775 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab1FPNKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Jun 2011 09:10:07 -0400
MIME-Version: 1.0
In-Reply-To: <20110223204108.GA6327@infomag.iguana.be>
References: <20110223204108.GA6327@infomag.iguana.be>
Date: Thu, 16 Jun 2011 15:10:06 +0200
Message-ID: <BANLkTimM+9__P4jpvuEL0zDFCyzPX=MrmA@mail.gmail.com>
Subject: Re: [RFC] [PATCH 0/10] Generic Watchdog Timer Driver
From: Andrea Galbusera <gizero@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Wed, Feb 23, 2011 at 9:41 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
> To reduce copying the same code over and over in each watchdog device d=
river, Alan Cox and myself constructed a new framework/API that consolida=
tes the common watchdog timer driver functions.
>
> This framework/API consists of the following patches:
> part =A01: Introduction of the WatchDog Timer Driver Core
> part =A02: Add the basic ioctl functionality
> part =A03: Add the WDIOC_KEEPALIVE ioctl
> part =A04: Add the WDIOC_SETOPTIONS ioctl
> part =A05: Add the WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT ioctl
> part =A06: Add orphan control
> part =A07: Add the Magic Close feature
> part =A08: Add the nowayout feature
> part =A09: Add support for a miscdev parent device
> part 10: Add support for extra ioctl calls

While looking for efforts to provide a generic driver for gpio driven
watchdog devices, like some simple hardware supervisors, I came into
this patchset RFC, which turned out to be very interesting to me.
Maybe I'm looking into the wrong places, but I could not find any
upstream commit after this RFC.
Since I don't see any real critic from commenters to the approach you
are suggesting, I'd like to know if there still is some
work-in-progress on this.

TIA
Kind regards,

Andrea
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
