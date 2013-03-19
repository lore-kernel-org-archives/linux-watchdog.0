Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:63275 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab3CSUCL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Mar 2013 16:02:11 -0400
Date: Tue, 19 Mar 2013 13:02:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] watchdog: w83627hf: Enable watchdog only once
Message-ID: <20130319200209.GA16827@roeck-us.net>
References: <1362957300-18223-1-git-send-email-linux@roeck-us.net>
 <1362957300-18223-3-git-send-email-linux@roeck-us.net>
 <51489FC2.40806@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <51489FC2.40806@draigBrady.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2013 at 05:26:26PM +0000, P=E1draig Brady wrote:
> On 03/10/2013 11:14 PM, Guenter Roeck wrote:
> > It is unnecessary to enable the logical device and WDT0 each time
> > the watchdog is accessed. Do it only once during initialization.
>=20
> Is this also the case on systems where the superio
> chip is used for other things? I've the impression
> that this may break some systems (though I no longer
> have the hardware to test). Arbitration of multiple
> users of the superio device may be managed be a central
> user space app, or by a kernel level arbitrator.
>=20
Not sure if I understand you correctly.

You mean some entity might actually disable the watchdog between accesses
to it by the watchdog driver ? That would make it pretty useless.
Might as well turn it off entirely if that is the case.

Or do you refer to _selecting_ the hwmon logical device ? If so, this pat=
ch
is about enabling it only once, not about selecting it only once.

Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
