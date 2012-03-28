Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39347 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab2C1HDA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Mar 2012 03:03:00 -0400
Received: by qcqw6 with SMTP id w6so490406qcq.19
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Mar 2012 00:02:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120327185854.GC9602@spo001.leaseweb.com>
References: <20120327185854.GC9602@spo001.leaseweb.com>
Date: Wed, 28 Mar 2012 09:02:58 +0200
Message-ID: <CA+i0qc5OJGFyvtqiEgWJd9O3mY+xkTYxZntZu+mPisa+39okfQ@mail.gmail.com>
Subject: Re: List of patches for this merge window (v3.3 -> v3.4-rc1)
From: Tomas Winkler <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>, Alan Cox <alan@linux.intel.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2012 at 8:58 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
> All,
>
> These are the patches that I will sent over for inclusion in Linus his =
tree tomorrow evening.

I was looking for the 'Add multiple device support' patch series
(http://www.spinics.net/lists/linux-watchdog/msg01071.html)
to be included as our driver under drivers/staging/mei required them
to work properly.
We expose additional interface

Thanks
Tomas


>
> Kind regards,
> Wim.
>
> commit b92c803ec61de59e6e4ab9b2748d8e633cec3f08
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date: =C2=A0 Fri Mar 23 11:48:22 2012 +0100
>
> =C2=A0 =C2=A0watchdog: txx9wdt: fix timeout
>
> =C2=A0 =C2=A0timeout should be an unsigned int.
> =C2=A0 =C2=A0Set the timeout value properly in the watchdog_device stru=
ct so that
> =C2=A0 =C2=A0we don't get an faulty values for the WDIOC_GETTIMEOUT ioc=
tl call.
> =C2=A0 =C2=A0Add check to see that timeout is a valid parameter after i=
t is loaded
> =C2=A0 =C2=A0as a module.
>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> =C2=A0 =C2=A0Acked-by: Wolfram Sang <w.sang@pengutronix.de>
>
> commit d6245842384c9289d4f778555fd8be729e0b0306
> Author: Axel Lin <axel.lin@gmail.com>
> Date: =C2=A0 Fri Mar 16 11:53:53 2012 +0800
>
> =C2=A0 =C2=A0watchdog: Convert txx9wdt driver to watchdog framework
>
> =C2=A0 =C2=A0This patch converts txx9wdt driver to watchdog framework.
> =C2=A0 =C2=A0Also use devm_* APIs to save a few error handling code.
>
> =C2=A0 =C2=A0Signed-off-by: Axel Lin <axel.lin@gmail.com>
> =C2=A0 =C2=A0Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit dddbc6a0513b25c80e73e14ee704186deedc0d00
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date: =C2=A0 Thu Mar 22 20:42:16 2012 +0100
>
> =C2=A0 =C2=A0watchdog: coh901327_wdt.c: fix timeout
>
> =C2=A0 =C2=A0Set the timeout value properly so that we don't get faulty=
 values
> =C2=A0 =C2=A0for the WDIOC_GETTIMEOUT iotcl. 'margin' should be an unsi=
gned int.
> =C2=A0 =C2=A0Also add a check to see if margin is a valid parameter aft=
er it is
> =C2=A0 =C2=A0loaded as a module.
>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> =C2=A0 =C2=A0Acked-by: Linus Walleij <linus.walleij@linaro.org>
> =C2=A0 =C2=A0Acked-by: Wolfram Sang <w.sang@pengutronix.de>
>
> commit 15b25701b282bd761a82c6508529b2145744075f
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date: =C2=A0 Fri Mar 16 09:14:12 2012 +0100
>
> =C2=A0 =C2=A0watchdog: coh901327: convert to use watchdog core
>
> =C2=A0 =C2=A0This converts the COH901327 watchdog to use the watchdog c=
ore.
> =C2=A0 =C2=A0I followed Wolframs document, looked at some other drivers=
 and
> =C2=A0 =C2=A0tested it on the U300.
>
> =C2=A0 =C2=A0Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> =C2=A0 =C2=A0Cc: Wolfram Sang <w.sang@pengutronix.de>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit fd7b673c92731fc6c0b1e999adfd87b6762ee797
> Author: Viresh Kumar <viresh.kumar@st.com>
> Date: =C2=A0 Fri Mar 16 09:14:00 2012 +0100
>
> =C2=A0 =C2=A0watchdog: Add support for WDIOC_GETTIMELEFT IOCTL in watch=
dog core
>
> =C2=A0 =C2=A0This patch adds support for WDIOC_GETTIMELEFT IOCTL in wat=
chdog core. So, there
> =C2=A0 =C2=A0is another function pointer added to struct watchdog_ops, =
which can be passed by
> =C2=A0 =C2=A0drivers to support this IOCTL.
>
> =C2=A0 =C2=A0Related documentation is updated too.
>
> =C2=A0 =C2=A0Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> =C2=A0 =C2=A0Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 2ca1606359695cc7ce371c7829c4082d9095fc06
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date: =C2=A0 Thu Mar 22 09:37:10 2012 +0100
>
> =C2=A0 =C2=A0watchdog: ep93xx_wdt: timeout is an unsigned int value.
>
> =C2=A0 =C2=A0the timeout is a positive thus unsigned int value.
> =C2=A0 =C2=A0Also re-add the comment about the actual heartbeat.
>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 59dcf1eb1a4b15610c68a4dbb7430d61a65f4af3
> Author: Mika Westerberg <mika.westerberg@iki.fi>
> Date: =C2=A0 Sun Mar 18 13:09:52 2012 +0200
>
> =C2=A0 =C2=A0watchdog: ep93xx_wdt: Fix timeout after conversion to watc=
hdog core
>
> =C2=A0 =C2=A0After the conversion of this driver to the watchdog core, =
I noticed that we
> =C2=A0 =C2=A0miss setting the initial timeout of the wdt device.
> =C2=A0 =C2=A0This results in a failure of the WDIOC_GETTIMEOUT ioctl ca=
ll.
>
> =C2=A0 =C2=A0Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
> =C2=A0 =C2=A0Tested-by: Mika Westerberg <mika.westerberg@iki.fi>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit e12a679ddee4eb5ab2f99f7cf129355461e142c0
> Author: H Hartley Sweeten <hartleys@visionengravers.com>
> Date: =C2=A0 Wed Mar 14 10:31:50 2012 -0700
>
> =C2=A0 =C2=A0watchdog: Convert ep93xx driver to watchdog core
>
> =C2=A0 =C2=A0Convert the ep93xx_wdt driver to the watchdog framework AP=
I.
>
> =C2=A0 =C2=A0Also, use the dev_<fmt> functions instead of pr_<fmt> for =
logging.
>
> =C2=A0 =C2=A0Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers=
.com>
> =C2=A0 =C2=A0Cc: Ryan Mallon <rmallon@gmail.com>
> =C2=A0 =C2=A0Cc: Mika Westerberg <mika.westerberg@iki.fi>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit fb35a5ad5b4b2c3806b52b0159f4d5a0ad205c0f
> Author: Viresh Kumar <viresh.kumar@st.com>
> Date: =C2=A0 Mon Mar 12 09:52:15 2012 +0530
>
> =C2=A0 =C2=A0watchdog: sp805: Use devm routines
>
> =C2=A0 =C2=A0sp805 driver currently uses normal kzalloc, ioremap, etc r=
outines. This patch
> =C2=A0 =C2=A0replaces these routines with devm_kzalloc and devm_request=
_mem_region etc, so
> =C2=A0 =C2=A0that we don't need to handle freeing of resources for erro=
r cases and module
> =C2=A0 =C2=A0removal routine.
>
> =C2=A0 =C2=A0Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit d2e8919bcfb63b662945d0e5cb9338f0f2229d10
> Author: Viresh Kumar <viresh.kumar@st.com>
> Date: =C2=A0 Mon Mar 12 09:52:14 2012 +0530
>
> =C2=A0 =C2=A0watchdog: sp805: replace readl/writel with lighter _relaxe=
d variants
>
> =C2=A0 =C2=A0readl/writel versions for ARM contain memory barrier instr=
uction for
> =C2=A0 =C2=A0synchronizing DMA buffers. =C2=A0These are not required at=
 least on this
> =C2=A0 =C2=A0module. =C2=A0So use lighter _relaxed variants.
>
> =C2=A0 =C2=A0Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit bfae14b679063d85f10579bbfd532db58b122e29
> Author: Viresh Kumar <viresh.kumar@st.com>
> Date: =C2=A0 Mon Mar 12 09:52:13 2012 +0530
>
> =C2=A0 =C2=A0watchdog: sp805: Fix documentation style comment
>
> =C2=A0 =C2=A0@ was missing before variables names, in their description=
. Also adev is
> =C2=A0 =C2=A0mentioned as dev in comment. Fix both these issues.
>
> =C2=A0 =C2=A0Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 60a1aa50b2ca142a91455203ca2aa09502eddd20
> Author: Viresh Kumar <viresh.kumar@st.com>
> Date: =C2=A0 Mon Mar 12 09:52:00 2012 +0530
>
> =C2=A0 =C2=A0watchdog: mpcore_wdt: Allow platform_get_irq() to fail
>
> =C2=A0 =C2=A0irq is not necessary for mpcore wdt. Don't return error if=
 it is not passed. But
> =C2=A0 =C2=A0if it is passed, then request_irq must pass.
>
> =C2=A0 =C2=A0Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 75f5a536c0b605b9b8406325f51f62f67141973e
> Author: Viresh Kumar <viresh.kumar@st.com>
> Date: =C2=A0 Mon Mar 12 09:51:59 2012 +0530
>
> =C2=A0 =C2=A0watchdog: mpcore_wdt: Use devm routines
>
> =C2=A0 =C2=A0mpcore_wdt driver currently uses normal kzalloc, request_i=
rq, ioremap, etc
> =C2=A0 =C2=A0routines. This patch replaces these routines with devm_kza=
lloc and
> =C2=A0 =C2=A0devm_request_mem_region etc, so that we don't need to hand=
le freeing of
> =C2=A0 =C2=A0resources for error cases and module removal routine.
>
> =C2=A0 =C2=A0Also, request_irq is moved before registering misc device,=
 so that we are ready
> =C2=A0 =C2=A0for irq as soon as device is registered.
>
> =C2=A0 =C2=A0Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit aa065770f55f44ed24f0a9b76ec6e2135264d43b
> Author: Viresh Kumar <viresh.kumar@st.com>
> Date: =C2=A0 Mon Mar 12 09:51:58 2012 +0530
>
> =C2=A0 =C2=A0watchdog: mpcore_wdt: Rename dev to pdev for pointing to s=
truct platform_device
>
> =C2=A0 =C2=A0Pointer to struct platform_device is named as dev, which m=
akes it confusing when
> =C2=A0 =C2=A0we write statements like dev->dev to access struct device =
within it.
>
> =C2=A0 =C2=A0This patch renames such names to pdev.
>
> =C2=A0 =C2=A0Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 38c484fa136f66224694af298f80e96bf4072700
> Author: Jan Beulich <JBeulich@suse.com>
> Date: =C2=A0 Mon Mar 19 09:32:28 2012 +0000
>
> =C2=A0 =C2=A0watchdog: xen: don't clear is_active when xen_wdt_stop() f=
ailed
>
> =C2=A0 =C2=A0xen_wdt_release() shouldn't clear is_active even when the =
watchdog
> =C2=A0 =C2=A0didn't get stopped (which by itself shouldn't happen, but =
let's return
> =C2=A0 =C2=A0a proper error in this case rather than adding a BUG() upo=
n hypercall
> =C2=A0 =C2=A0failure).
>
> =C2=A0 =C2=A0Signed-off-by: Jan Beulich <jbeulich@suse.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 83448bf7867917d5fd104e65275d8e153f3293a8
> Author: Jan Beulich <JBeulich@suse.com>
> Date: =C2=A0 Mon Mar 19 09:30:33 2012 +0000
>
> =C2=A0 =C2=A0watchdog: xen: don't unconditionally enable the watchdog d=
uring resume
>
> =C2=A0 =C2=A0This was found to be a problem particularly after guest mi=
gration.
>
> =C2=A0 =C2=A0Signed-off-by: Jan Beulich <jbeulich@suse.com>
> =C2=A0 =C2=A0Reported-by: Wouter de Geus <benv-xensource.com@junerules.=
com>
> =C2=A0 =C2=A0Reported-by: Ian Campbell <Ian.Campbell@citrix.com>
> =C2=A0 =C2=A0Tested-by: Wouter de Geus <benv-xensource.com@junerules.co=
m>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit ccd4144dd41c32a284a5b040f87aaefed0361a21
> Author: Jaehoon Chung <jh80.chung@samsung.com>
> Date: =C2=A0 Fri Mar 16 15:27:21 2012 +0900
>
> =C2=A0 =C2=A0watchdog: fix compiler error for missing parenthesis
>
> =C2=A0 =C2=A0Joe's patch(watchdog: Use pr_<fmt> and pr_<level>) missed =
parenthesis in s3c2410_wdt.c.
>
> =C2=A0 =C2=A0Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> =C2=A0 =C2=A0Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 697b41e4d4b20b8d8564f5501927b0ed07153990
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date: =C2=A0 Tue Mar 13 09:06:12 2012 +0100
>
> =C2=A0 =C2=A0watchdog: ep93xx_wdt.c: fix platform probe
>
> =C2=A0 =C2=A0Fix the device/driver init so that the misc_register
> =C2=A0 =C2=A0happens as last (since this opens userspace access to
> =C2=A0 =C2=A0the device).
>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 3e0113a896803f792ffdf19b016578420824573f
> Author: H Hartley Sweeten <hsweeten@visionengravers.com>
> Date: =C2=A0 Tue Mar 13 09:48:16 2012 +1100
>
> =C2=A0 =C2=A0watchdog: ep93xx: Convert the watchdog driver into a platf=
orm device.
>
> =C2=A0 =C2=A0Convert the ep93xx watchdog driver into a platform device =
and
> =C2=A0 =C2=A0remove it's dependency on <mach/hardware.h>.
>
> =C2=A0 =C2=A0Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers=
.com>
> =C2=A0 =C2=A0Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> =C2=A0 =C2=A0Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
> =C2=A0 =C2=A0Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> commit 0197c1c49ef1ff386b2ebb6d3b0fc85a8e174b5c
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date: =C2=A0 Wed Feb 29 20:20:58 2012 +0100
>
> =C2=A0 =C2=A0watchdog: fix set_timeout operations
>
> =C2=A0 =C2=A0Since we changed the behaviour of the set_timeout operatio=
n in the
> =C2=A0 =C2=A0watchdog API, we need to change the allready converted dri=
vers so
> =C2=A0 =C2=A0that they update the timeout field at the end of the set_t=
imeout
> =C2=A0 =C2=A0operation.
>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit b10f7c12e051762b84457f6d38d4b71acbf76a02
> Author: Hans de Goede <hdegoede@redhat.com>
> Date: =C2=A0 Mon Sep 12 11:56:59 2011 +0200
>
> =C2=A0 =C2=A0watchdog: watchdog_dev: Let the driver update the timeout =
field on set_timeout success
>
> =C2=A0 =C2=A0When a set_timeout operation succeeds this does not necess=
arily mean that
> =C2=A0 =C2=A0the exact timeout requested has been achieved, because the=
 watchdog does not
> =C2=A0 =C2=A0necessarily have a 1 second resolution. So rather then hav=
e the core set
> =C2=A0 =C2=A0the timeout member of the watchdog_device struct to the ex=
act requested
> =C2=A0 =C2=A0value, instead the driver should set it to the actually ac=
hieved timeout value.
>
> =C2=A0 =C2=A0Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit a5132cafc0a739107e51494b9054c0066802b8cd
> Author: Alan Cox <alan@linux.intel.com>
> Date: =C2=A0 Tue Feb 28 22:48:11 2012 +0000
>
> =C2=A0 =C2=A0watchdog: softdog: convert to watchdog core
>
> =C2=A0 =C2=A0Convert softdog.c to the new watchdog API.
>
> =C2=A0 =C2=A0Signed-off-by: Alan Cox <alan@linux.intel.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit a0f3683365513c052d21991fe75eccd95aba9d34
> Author: Axel Lin <axel.lin@gmail.com>
> Date: =C2=A0 Wed Feb 8 14:24:10 2012 +0800
>
> =C2=A0 =C2=A0watchdog: Convert max63xx_wdt driver to watchdog framework
>
> =C2=A0 =C2=A0This patch converts max63xx_wdt driver to watchdog framewo=
rk.
> =C2=A0 =C2=A0Also use devm_* APIs to save a few error handling code.
>
> =C2=A0 =C2=A0Signed-off-by: Axel Lin <axel.lin@gmail.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 6b1e83869d13a6b5ce9ceb4b8f79a7538d467dee
> Author: Wolfram Sang <w.sang@pengutronix.de>
> Date: =C2=A0 Thu Feb 2 18:48:11 2012 +0100
>
> =C2=A0 =C2=A0watchdog: pnx4008: convert driver to use the watchdog fram=
ework
>
> =C2=A0 =C2=A0Make this driver a user of the watchdog framework and remo=
ve parts now handled
> =C2=A0 =C2=A0by the core. Tested on a custom lpc32xx-board.
>
> =C2=A0 =C2=A0[wim@iguana.be: Added set_timeout operation]
> =C2=A0 =C2=A0Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 2e51d90f4db6c94bc75c6ff22e959237f3cc27ba
> Author: Axel Lin <axel.lin@gmail.com>
> Date: =C2=A0 Mon Jan 23 15:26:59 2012 +0800
>
> =C2=A0 =C2=A0watchdog: Convert wm8350_wdt driver to watchdog core
>
> =C2=A0 =C2=A0This patch converts wm8350_wdt driver to use watchdog core=
 APIs.
>
> =C2=A0 =C2=A0Signed-off-by: Axel Lin <axel.lin@gmail.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 85f6df1492ff8b620cf601a1509520d2b89858dd
> Author: Axel Lin <axel.lin@gmail.com>
> Date: =C2=A0 Thu Jan 26 18:10:45 2012 +0800
>
> =C2=A0 =C2=A0watchdog: Convert jz4740_wdt driver to watchdog core
>
> =C2=A0 =C2=A0This patch converts jz4740_wdt driver to use watchdog core=
 APIs.
> =C2=A0 =C2=A0Also use devm_* APIs to save a few error handling code.
>
> =C2=A0 =C2=A0Signed-off-by: Axel Lin <axel.lin@gmail.com>
> =C2=A0 =C2=A0Acked-by: Paul Cercueil <paul@crapouillou.net>
> =C2=A0 =C2=A0Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 86a1e1896c2710402e29a875d8d830244274244d
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date: =C2=A0 Mon Mar 5 16:51:11 2012 +0100
>
> =C2=A0 =C2=A0watchdog: nowayout is bool
>
> =C2=A0 =C2=A0nowayout is actually a boolean value.
> =C2=A0 =C2=A0So make it bool for all watchdog device drivers.
>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 27c766aaacb265d625dc634bf7903f7f9fd0c697
> Author: Joe Perches <joe@perches.com>
> Date: =C2=A0 Wed Feb 15 15:06:19 2012 -0800
>
> =C2=A0 =C2=A0watchdog: Use pr_<fmt> and pr_<level>
>
> =C2=A0 =C2=A0Use the current logging styles.
>
> =C2=A0 =C2=A0Make sure all output has a prefix.
> =C2=A0 =C2=A0Add missing newlines.
> =C2=A0 =C2=A0Remove now unnecessary PFX, NAME, and miscellaneous other =
#defines.
> =C2=A0 =C2=A0Coalesce formats.
>
> =C2=A0 =C2=A0Signed-off-by: Joe Perches <joe@perches.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 7cbc353540c31ffaf65ad44d89b955be0f1d04dc
> Author: Wolfram Sang <w.sang@pengutronix.de>
> Date: =C2=A0 Thu Feb 2 18:48:09 2012 +0100
>
> =C2=A0 =C2=A0watchdog: pnx4008: don't use __raw_-accessors
>
> =C2=A0 =C2=A0__raw_readl/__raw_writel are not meant for drivers [1].
>
> =C2=A0 =C2=A0[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/1=
17626
>
> =C2=A0 =C2=A0Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 19f505f09c60d637c695a8e8c4768570e2309631
> Author: Wolfram Sang <w.sang@pengutronix.de>
> Date: =C2=A0 Thu Feb 2 18:48:08 2012 +0100
>
> =C2=A0 =C2=A0watchdog: pnx4008: cleanup resource handling using managed=
 devices
>
> =C2=A0 =C2=A0The resource handling in this driver was flaky: IO_ADDRESS=
 instead of
> =C2=A0 =C2=A0ioremap (and no unmapping), an unneeded static resource, n=
o central exit
> =C2=A0 =C2=A0path for error cases. Fix this by converting the driver to=
 use managed
> =C2=A0 =C2=A0resources. Also use dev_*-messages instead of pr_* while w=
e are here.
>
> =C2=A0 =C2=A0Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 16ac4abe0d0ea0a8d42d6a2a7de2a4a00bbf5b40
> Author: Viresh Kumar <viresh.kumar@st.com>
> Date: =C2=A0 Fri Feb 24 15:12:37 2012 +0530
>
> =C2=A0 =C2=A0watchdog: sp805_wdt: add pm callbacks to support standby/S=
2R/hibernation
>
> =C2=A0 =C2=A0Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 474ef121008a2992bcc496930166ced89bda23d2
> Author: Oskar Schirmer <oskar@scara.com>
> Date: =C2=A0 Thu Feb 16 12:17:45 2012 +0000
>
> =C2=A0 =C2=A0watchdog: make imx2_wdt report boot status correctly
>
> =C2=A0 =C2=A0Ioctl WDIOC_GETBOOTSTATUS is supposed to return some infor=
mation
> =C2=A0 =C2=A0on why the system did (re)boot recently, value WDIOF_CARDR=
ESET
> =C2=A0 =C2=A0being used to indicate watchdog induced reboot.
>
> =C2=A0 =C2=A0Up to now, imx2_wdt did not provide a value here, always r=
eturning
> =C2=A0 =C2=A0zero to indicate normal boot.
>
> =C2=A0 =C2=A0Do evaluate the IMX Watchdog Reset Status Register and
> =C2=A0 =C2=A0produce WDIOF_CARDRESET with WDIOC_GETBOOTSTATUS in case
> =C2=A0 =C2=A0of a watchdog induced reset.
>
> =C2=A0 =C2=A0Signed-off-by: Oskar Schirmer <oskar@scara.com>
> =C2=A0 =C2=A0Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
> commit 5ba927e8ca3f73acb98f417d126652e26ab40a57
> Author: Wolfram Sang <w.sang@pengutronix.de>
> Date: =C2=A0 Mon Jan 23 20:17:38 2012 +0100
>
> =C2=A0 =C2=A0watchdog: documentation: remove index-file
>
> =C2=A0 =C2=A0The 00-index file in the watchdog directory is, like many =
others,
> =C2=A0 =C2=A0outdated (conversion-howto is missing) and doesn't contain=
 worthwhile
> =C2=A0 =C2=A0additional information. As it seems to be a maintenance bu=
rden without
> =C2=A0 =C2=A0much gain, simply remove it.
>
> =C2=A0 =C2=A0Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> =C2=A0 =C2=A0Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>
>
> Diffstat:
> =C2=A0Documentation/watchdog/00-INDEX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 1=
9
> =C2=A0b/Documentation/watchdog/convert_drivers_to_kernel_api.txt | =C2=A0=
 =C2=A04
> =C2=A0b/Documentation/watchdog/watchdog-kernel-api.txt =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 11
> =C2=A0b/arch/arm/mach-ep93xx/core.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 15
> =C2=A0b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01
> =C2=A0b/drivers/char/ipmi/ipmi_watchdog.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04
> =C2=A0b/drivers/hwmon/fschmd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A04
> =C2=A0b/drivers/hwmon/w83793.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A04
> =C2=A0b/drivers/staging/mei/wd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A01
> =C2=A0b/drivers/watchdog/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A08
> =C2=A0b/drivers/watchdog/acquirewdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 2=
8 -
> =C2=A0b/drivers/watchdog/advantechwdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 34 -
> =C2=A0b/drivers/watchdog/alim1535_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 25 -
> =C2=A0b/drivers/watchdog/alim7101_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 55 --
> =C2=A0b/drivers/watchdog/ar7_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 38 -
> =C2=A0b/drivers/watchdog/at32ap700x_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04
> =C2=A0b/drivers/watchdog/at91rm9200_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 14
> =C2=A0b/drivers/watchdog/at91sam9_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 12
> =C2=A0b/drivers/watchdog/ath79_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A09
> =C2=A0b/drivers/watchdog/bcm47xx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 18
> =C2=A0b/drivers/watchdog/bcm63xx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11
> =C2=A0b/drivers/watchdog/bfin_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 31 -
> =C2=A0b/drivers/watchdog/booke_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
14
> =C2=A0b/drivers/watchdog/coh901327_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0206 +++-----=
--
> =C2=A0b/drivers/watchdog/cpu5wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 19
> =C2=A0b/drivers/watchdog/cpwd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 20
> =C2=A0b/drivers/watchdog/dw_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A07
> =C2=A0b/drivers/watchdog/ep93xx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A025=
1 ++++--------
> =C2=A0b/drivers/watchdog/eurotechwdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 32 -
> =C2=A0b/drivers/watchdog/f71808e_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 40 -
> =C2=A0b/drivers/watchdog/gef_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 15
> =C2=A0b/drivers/watchdog/geodewdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A09
> =C2=A0b/drivers/watchdog/hpwdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 31 -
> =C2=A0b/drivers/watchdog/i6300esb.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 39 -
> =C2=A0b/drivers/watchdog/iTCO_vendor_support.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07
> =C2=A0b/drivers/watchdog/iTCO_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 59 +-
> =C2=A0b/drivers/watchdog/ib700wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 26 -
> =C2=A0b/drivers/watchdog/ibmasr.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 18
> =C2=A0b/drivers/watchdog/imx2_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 14
> =C2=A0b/drivers/watchdog/indydog.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 24 -
> =C2=A0b/drivers/watchdog/intel_scu_watchdog.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 71 +--
> =C2=A0b/drivers/watchdog/intel_scu_watchdog.h =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01
> =C2=A0b/drivers/watchdog/iop_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 15
> =C2=A0b/drivers/watchdog/it8712f_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 39 -
> =C2=A0b/drivers/watchdog/it87_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 46 --
> =C2=A0b/drivers/watchdog/ixp2000_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11
> =C2=A0b/drivers/watchdog/ixp4xx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 1=
5
> =C2=A0b/drivers/watchdog/jz4740_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A026=
5 ++++---------
> =C2=A0b/drivers/watchdog/ks8695_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 1=
0
> =C2=A0b/drivers/watchdog/lantiq_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A08
> =C2=A0b/drivers/watchdog/m54xx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
14
> =C2=A0b/drivers/watchdog/machzwd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 37 -
> =C2=A0b/drivers/watchdog/max63xx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0194 +---=
-----
> =C2=A0b/drivers/watchdog/mixcomwd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 29 -
> =C2=A0b/drivers/watchdog/mpc8xxx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 17
> =C2=A0b/drivers/watchdog/mpcore_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A011=
1 ++---
> =C2=A0b/drivers/watchdog/mv64x60_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 15
> =C2=A0b/drivers/watchdog/nuc900_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A04
> =C2=A0b/drivers/watchdog/nv_tco.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 46 +-
> =C2=A0b/drivers/watchdog/octeon-wdt-main.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 16
> =C2=A0b/drivers/watchdog/of_xilinx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 41 --
> =C2=A0b/drivers/watchdog/omap_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A04
> =C2=A0b/drivers/watchdog/orion_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
15
> =C2=A0b/drivers/watchdog/pc87413_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 57 +-
> =C2=A0b/drivers/watchdog/pcwd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0127 ++----
> =C2=A0b/drivers/watchdog/pcwd_pci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0113 ++---
> =C2=A0b/drivers/watchdog/pcwd_usb.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 78 +--
> =C2=A0b/drivers/watchdog/pika_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 23 -
> =C2=A0b/drivers/watchdog/pnx4008_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0263 +++-=
--------
> =C2=A0b/drivers/watchdog/pnx833x_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 30 -
> =C2=A0b/drivers/watchdog/rc32434_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 33 -
> =C2=A0b/drivers/watchdog/riowd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 10
> =C2=A0b/drivers/watchdog/s3c2410_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 31 -
> =C2=A0b/drivers/watchdog/sa1100_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 1=
0
> =C2=A0b/drivers/watchdog/sb_wdog.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 28 -
> =C2=A0b/drivers/watchdog/sbc60xxwdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 4=
1 --
> =C2=A0b/drivers/watchdog/sbc7240_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 44 --
> =C2=A0b/drivers/watchdog/sbc8360.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 24 -
> =C2=A0b/drivers/watchdog/sbc_epx_c3.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 2=
3 -
> =C2=A0b/drivers/watchdog/sbc_fitpc2_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 13
> =C2=A0b/drivers/watchdog/sc1200wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
34 -
> =C2=A0b/drivers/watchdog/sc520_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
39 -
> =C2=A0b/drivers/watchdog/sch311x_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 17
> =C2=A0b/drivers/watchdog/scx200_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 2=
5 -
> =C2=A0b/drivers/watchdog/shwdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 19
> =C2=A0b/drivers/watchdog/smsc37b787_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 42 --
> =C2=A0b/drivers/watchdog/softdog.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
211 ++--------
> =C2=A0b/drivers/watchdog/sp5100_tco.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 3=
5 -
> =C2=A0b/drivers/watchdog/sp805_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01=
11 +++--
> =C2=A0b/drivers/watchdog/stmp3xxx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
8
> =C2=A0b/drivers/watchdog/ts72xx_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A04
> =C2=A0b/drivers/watchdog/twl4030_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04
> =C2=A0b/drivers/watchdog/txx9wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
184 ++-------
> =C2=A0b/drivers/watchdog/via_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 13
> =C2=A0b/drivers/watchdog/w83627hf_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 38 -
> =C2=A0b/drivers/watchdog/w83697hf_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 43 --
> =C2=A0b/drivers/watchdog/w83697ug_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 38 -
> =C2=A0b/drivers/watchdog/w83877f_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 40 -
> =C2=A0b/drivers/watchdog/w83977f_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 38 -
> =C2=A0b/drivers/watchdog/wafer5823wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 34 -
> =C2=A0b/drivers/watchdog/watchdog_core.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04
> =C2=A0b/drivers/watchdog/watchdog_dev.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 16
> =C2=A0b/drivers/watchdog/wdrtas.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 71 +--
> =C2=A0b/drivers/watchdog/wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 55 +-
> =C2=A0b/drivers/watchdog/wdt285.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 12
> =C2=A0b/drivers/watchdog/wdt977.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 40 -
> =C2=A0b/drivers/watchdog/wdt_pci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 70 +--
> =C2=A0b/drivers/watchdog/wm831x_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A06
> =C2=A0b/drivers/watchdog/wm8350_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A022=
3 ++--------
> =C2=A0b/drivers/watchdog/xen_wdt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 42 +-
> =C2=A0b/include/linux/watchdog.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A04
> =C2=A0111 files changed, 1829 insertions(+), 2844 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
