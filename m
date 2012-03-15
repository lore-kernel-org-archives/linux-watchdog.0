Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail3.vodafone.ie ([213.233.128.45]:13968 "EHLO
	mail3.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759976Ab2COMtW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Mar 2012 08:49:22 -0400
Message-ID: <4F61E312.90209@draigBrady.com>
Date: Thu, 15 Mar 2012 12:39:46 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Hans de Goede <hdegoede@redhat.com>
CC: linux-watchdog@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>
Subject: Re: Watchdog timer core enhancements
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 03/15/2012 11:59 AM, Hans de Goede wrote:
> Hi,
>=20
> Short selfintro for the watchdog people: I'm a FOSS developer / enthusi=
ast
> for close to 15 years now. I've written Linux kernel drivers for a ton
> of webcams and various hwmon IC's.
>=20
> Three of the hwmon drivers I maintain are IC's which also include a wat=
chdog
> part in their hwmon solution.
>=20
> This is a resend of a series of watchdog_dev patches which I initially =
send
> on Sep 12 2011:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2011-September/033707.=
html
> And which unfortunately has seen 0 reviews / feedback since then.
>=20
> This resend is re-based on top of v3.3-rc7
>=20
> Currently the hwmon drivers I maintain are implementing the watchdog AP=
I
> all by themselves, I would very much like to switch them over to
> watchdog_dev to remove a lot of code duplication, but there currently
> are 2 things stopping me from moving them over:
>=20
> 1) The driver core only works for 1 watchdog, but both my fschmd and my=
 sch5636
> test systems also have an iTCO watchdog and that tends to load first. T=
hus when
> writing the fschmd watchdog code I made it support loading either on th=
e
> default watchdog minor, or on one of the additional reserved watchdog m=
inors
> (212-215). The first patch in this series adds support for this to the
> watchdog timer driver core (which was quite straightforward to add).

I noticed Alan Cox recently proposed multiple watchdog device support
https://lkml.org/lkml/2012/2/28/473

cheers,
P=E1draig.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
