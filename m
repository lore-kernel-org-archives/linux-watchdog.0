Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from forward10.mail.yandex.net ([77.88.61.49]:47440 "EHLO
	forward10.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab3AaL31 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Jan 2013 06:29:27 -0500
Message-ID: <510A539E.7020105@yandex.ru>
Date: Thu, 31 Jan 2013 15:21:02 +0400
From: Mike Lykov <combr@yandex.ru>
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	kirill@shutemov.name
Subject: Re: [BUG?] false positive in soft lockup detector while unlzma initramfs
 on slow cpu
References: <5107D1D3.6040105@yandex.ru> <20130129153348.GR98867@redhat.com> <5108EA4B.7030003@yandex.ru> <20130130154033.GE98867@redhat.com>
In-Reply-To: <20130130154033.GE98867@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable


30.01.2013 19:40, Don Zickus =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
 > I have never seen usage like 'kernel.watchdog_thresh=3D30'.  Could you=
 try
 > 'watchdog_thresh=3D30' instead?

Ok. "kernel.watchdog_thresh=3D30" is a sysctl presentation, i mixed them=20
wrongly.

Your patch about cmd support for 'watchdog_thresh=3D30' working. I tested=
=20
it: parameter applies and lzma -9 initramfs loading successfully.
If I delete parameter from cmdline - same kernel not boot.

 > I also attached another patch as suggested by Andrew to add a
 > touch_softlockup_watchdog in the unlzma routine.  Probably makes thing=
s
 > run a little slower.  Compiled tested only.

In my case (3.2.32) it cannot compile:

   LD      arch/x86/boot/compressed/vmlinux
arch/x86/boot/compressed/misc.o: In function `decompress_kernel':
misc.c:(.text+0x993): undefined reference to `touch_softlockup_watchdog'

---
Mike



 >
 > Cheers,
 > Don
 >
 > diff --git a/lib/decompress_unlzma.c b/lib/decompress_unlzma.c
 > index 32adb73..313f4fa 100644
 > --- a/lib/decompress_unlzma.c
 > +++ b/lib/decompress_unlzma.c
 > @@ -36,6 +36,7 @@
 >   #endif /* STATIC */
 >
 >   #include<linux/decompress/mm.h>
 > +#include<linux/nmi.h>
 >
 >   #define	MIN(a, b) (((a)<  (b)) ? (a) : (b))
 >
 > @@ -648,6 +649,7 @@ STATIC inline int INIT unlzma(unsigned char *buf,=20
int in_len,
 >   		}
 >   		if (rc.buffer_size<=3D 0)
 >   			goto exit_3;
 > +		touch_softlockup_watchdog();
 >   	}
 >
 >   	if (posp)
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
