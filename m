Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33652 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422Ab3A3Pkm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Jan 2013 10:40:42 -0500
Date: Wed, 30 Jan 2013 10:40:33 -0500
From: Don Zickus <dzickus@redhat.com>
To: Mike Lykov <combr@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	kirill@shutemov.name
Subject: Re: [BUG?] false positive in soft lockup detector while unlzma
 initramfs on slow cpu
Message-ID: <20130130154033.GE98867@redhat.com>
References: <5107D1D3.6040105@yandex.ru>
 <20130129153348.GR98867@redhat.com>
 <5108EA4B.7030003@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5108EA4B.7030003@yandex.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2013 at 01:39:23PM +0400, Mike Lykov wrote:
> 29.01.2013 19:33, Don Zickus =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
> >The softlockup mechanism works scheduling a high priority task that ki=
cks
> >the softlockups.  If the unzip thread is taking too long, it could
> >accidentally trip the detection.
>=20
> Inyerestingly, that a decompress of lzma -4 takes longer time than
> decompress lzma -9, and it stated in man lzma(1):
> "  On  the  same hardware, the decompression speed is approximately
> a constant number of bytes of compressed data per second.  In other
> words, the better the compression, the faster the  decompression
> will  usually  be. "
>=20
> I tested it on target computer by hand:
>=20
> lzma -4 compressed: time unlzma initram-alt-p6rel3-4.cpio.lzma
> 20.94user 1.47system 0:22:45elapsed 99%CPU (...19424maxresidents)k
>=20
> lzma -9 compressed: time unlzma initram-alt-p6rel3-9.cpio.lzma
> 19.49user 1.92system 0:21:44elapsed 99%CPU (...241488maxresidents)k
>=20
> So, it cannot "take too long" because not-working faster than working.
> Apparently time not matter, but algorithm complexity?
>=20
> >>2. How to change watchdog_thresh parameter at boot without patching
> >>sources? If it necessary (with it side effects) maybe implement it
> >>as commandline parameter or config compile time parameter?
> >
> >I attached a patch below that allows you to set it a boot time.  Let m=
e
> >know if this works for you, then I can clean it up and post it properl=
y.
>=20
> It not works for me. I apply this patch, build, use ("int
> __read_mostly watchdog_thresh =3D 10;"  as in original)
> command line:
>=20
> [    0.000000] Kernel command line:
> initrd=3Dinitram-alt-p6rel3-9.cpio.lzma console=3Duart,io,0x240,115200n=
8
> kernel.watchdog_thresh=3D30

I have never seen usage like 'kernel.watchdog_thresh=3D30'.  Could you tr=
y
'watchdog_thresh=3D30' instead?

I also attached another patch as suggested by Andrew to add a
touch_softlockup_watchdog in the unlzma routine.  Probably makes things
run a little slower.  Compiled tested only.

Cheers,
Don

diff --git a/lib/decompress_unlzma.c b/lib/decompress_unlzma.c
index 32adb73..313f4fa 100644
--- a/lib/decompress_unlzma.c
+++ b/lib/decompress_unlzma.c
@@ -36,6 +36,7 @@
 #endif /* STATIC */
=20
 #include <linux/decompress/mm.h>
+#include <linux/nmi.h>
=20
 #define	MIN(a, b) (((a) < (b)) ? (a) : (b))
=20
@@ -648,6 +649,7 @@ STATIC inline int INIT unlzma(unsigned char *buf, int=
 in_len,
 		}
 		if (rc.buffer_size <=3D 0)
 			goto exit_3;
+		touch_softlockup_watchdog();
 	}
=20
 	if (posp)
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
