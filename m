Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38214 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbbG3LIo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jul 2015 07:08:44 -0400
Received: by wibxm9 with SMTP id xm9so63680847wib.1
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2015 04:08:43 -0700 (PDT)
Date: Thu, 30 Jul 2015 12:08:38 +0100
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
Message-ID: <20150730110838.GE14642@x1>
References: <1438171844-24861-1-git-send-email-matt@codeblueprint.co.uk>
 <1438171844-24861-2-git-send-email-matt@codeblueprint.co.uk>
 <20150729153556.GC9319@x1>
 <20150729163953.GI2773@codeblueprint.co.uk>
 <20150730085347.GF9319@x1>
 <20150730091458.GB2704@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150730091458.GB2704@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 30 Jul 2015, Matt Fleming wrote:

> On Thu, 30 Jul, at 09:53:47AM, Lee Jones wrote:
> > On Wed, 29 Jul 2015, Matt Fleming wrote:
> >=20
> > > On Wed, 29 Jul, at 04:35:56PM, Lee Jones wrote:
> > > >=20
> > > > For my own reference (I assume this will go through the MFD tre=
e):
> > > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > >=20
> > > Great, thanks Lee!
> > >=20
> > > I've no strong opinion on which tree these 3 patches go through b=
ut at
> > > the very least patches 1 and 2 need to go through the same tree t=
o avoid
> > > build breakage (since PATCH 1 introduces 'struct itco_wdt_platfor=
m_data'
> > > which is used in PATCH 2).
> > >=20
> > > For reference, the other patches are here,
> > >=20
> > >   https://lkml.kernel.org/r/1438171844-24861-3-git-send-email-mat=
t@codeblueprint.co.uk
> > >   https://lkml.kernel.org/r/1438171844-24861-4-git-send-email-mat=
t@codeblueprint.co.uk
> >=20
> > Obviously this makes things more difficult.  Once you have the othe=
r
> > Acks you need, I suggest you re-submit the set using --threaded, so=
 we
> > can all see what's going on.
> =20
> Umm... I submitted *this* version using --threaded. In fact, that's
> plain to see from the Message-Id format in the links above. It's just
> that I only Cc'd you on the patch that touched the mfd code.

Ah yes, similar result.  Again, unless the set is particularlly large
or touches many subsystems, I tend to Cc all affected Maintainers (if
I'm sending, or like to be Cc'ed if I'm the recipient) on all of the
patches.  Set status is much easier to track that way and issues which
might be relevant to more than one patch in the set can be seen by
all.

> I can resubmit with the Ack/Review tags and copy you on the whole ser=
ies
> if you'd like.

That would be perfect.

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
