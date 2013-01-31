Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22520 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab3AaOqk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Jan 2013 09:46:40 -0500
Date: Thu, 31 Jan 2013 09:46:27 -0500
From: Don Zickus <dzickus@redhat.com>
To: Mike Lykov <combr@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	kirill@shutemov.name
Subject: Re: [BUG?] false positive in soft lockup detector while unlzma
 initramfs on slow cpu
Message-ID: <20130131144627.GL98867@redhat.com>
References: <5107D1D3.6040105@yandex.ru>
 <20130129153348.GR98867@redhat.com>
 <5108EA4B.7030003@yandex.ru>
 <20130130154033.GE98867@redhat.com>
 <510A539E.7020105@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <510A539E.7020105@yandex.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2013 at 03:21:02PM +0400, Mike Lykov wrote:
>=20
> 30.01.2013 19:40, Don Zickus =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I have never seen usage like 'kernel.watchdog_thresh=3D30'.  Could yo=
u try
> > 'watchdog_thresh=3D30' instead?
>=20
> Ok. "kernel.watchdog_thresh=3D30" is a sysctl presentation, i mixed
> them wrongly.
>=20
> Your patch about cmd support for 'watchdog_thresh=3D30' working. I
> tested it: parameter applies and lzma -9 initramfs loading
> successfully.
> If I delete parameter from cmdline - same kernel not boot.

Good to know.

>=20
> > I also attached another patch as suggested by Andrew to add a
> > touch_softlockup_watchdog in the unlzma routine.  Probably makes thin=
gs
> > run a little slower.  Compiled tested only.
>=20
> In my case (3.2.32) it cannot compile:
>=20
>   LD      arch/x86/boot/compressed/vmlinux
> arch/x86/boot/compressed/misc.o: In function `decompress_kernel':
> misc.c:(.text+0x993): undefined reference to `touch_softlockup_watchdog=
'

I think Andrew's suggestion is a better approach which is add the
touch_softlockup_watchdog.  So I would have to see you .config file to
understand the compile warning.

Cheers,
Don
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
