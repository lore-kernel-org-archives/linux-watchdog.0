Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4616 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933866Ab2HWRUP (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Aug 2012 13:20:15 -0400
Date: Thu, 23 Aug 2012 19:18:15 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: Peter Tyser <ptyser@xes-inc.com>, Wim Van Sebroeck <wim@iguana.be>,
	Aaron Sierra <asierra@xes-inc.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	Tobias Powalowski <tpowa@archlinux.org>
Subject: Re: Serious regression in 3.5's iTCO_wdt, does anyone care?
Message-ID: <20120823171815.GE9889@sortiz-mobl>
References: <50363B12.4060009@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <50363B12.4060009@archlinux.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Thu, Aug 23, 2012 at 04:15:46PM +0200, Thomas B=E4chler wrote:
> This regards the following commit in the Linus tree:
>=20
> commit 887c8ec7219fc8eba78bb8f44a74c660934e9b98
> Author: Aaron Sierra <asierra@xes-inc.com>
> Date:   Fri Apr 20 14:14:11 2012 -0500
>=20
>     watchdog: Convert iTCO_wdt driver to mfd model
>=20
> Ever since the Linux 3.5 update, the iTCO_wdt driver has been completel=
y
> non-functional on every machine I encountered due to the above
> conversion. A bug report for this problem has been open at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D44991 for over a month.
Cc'ing the relevant maintainers usually helps...


> Yet, neither the author of the commit, nor the people who signed off on
> it have reacted to the bug report.
>=20
> At this point, I believe that none of you are actually aware of the
> problem and I write you to change that unfortunate situation.
I applied Feng's patch to my for-linus branch and I'll send a pull reques=
t
soon. It should be part of the 3.6 kernel.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
