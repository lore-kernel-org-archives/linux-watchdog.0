Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33990 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbG3Ixv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jul 2015 04:53:51 -0400
Received: by wibud3 with SMTP id ud3so12042247wib.1
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2015 01:53:50 -0700 (PDT)
Date: Thu, 30 Jul 2015 09:53:47 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Zha Qipeng <qipeng.zha@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] iTCO_wdt: Expose watchdog properties using
 platform data
Message-ID: <20150730085347.GF9319@x1>
References: <1438171844-24861-1-git-send-email-matt@codeblueprint.co.uk>
 <1438171844-24861-2-git-send-email-matt@codeblueprint.co.uk>
 <20150729153556.GC9319@x1>
 <20150729163953.GI2773@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150729163953.GI2773@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 29 Jul 2015, Matt Fleming wrote:

> On Wed, 29 Jul, at 04:35:56PM, Lee Jones wrote:
> >=20
> > For my own reference (I assume this will go through the MFD tree):
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> Great, thanks Lee!
>=20
> I've no strong opinion on which tree these 3 patches go through but a=
t
> the very least patches 1 and 2 need to go through the same tree to av=
oid
> build breakage (since PATCH 1 introduces 'struct itco_wdt_platform_da=
ta'
> which is used in PATCH 2).
>=20
> For reference, the other patches are here,
>=20
>   https://lkml.kernel.org/r/1438171844-24861-3-git-send-email-matt@co=
deblueprint.co.uk
>   https://lkml.kernel.org/r/1438171844-24861-4-git-send-email-matt@co=
deblueprint.co.uk

Obviously this makes things more difficult.  Once you have the other
Acks you need, I suggest you re-submit the set using --threaded, so we
can all see what's going on.

=46YI: I usually do this as a matter of course, as separated patches ar=
e
a pain to manage, particularly if there are dependencies between them.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
