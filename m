Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41597 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbcEABNH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 30 Apr 2016 21:13:07 -0400
Date: Sat, 30 Apr 2016 18:13:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kernel-testers@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH] watchdog: dw_wdt: dont build for avr32
Message-ID: <20160501011301.GA30144@roeck-us.net>
References: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>
 <570CF2CB.2050200@roeck-us.net>
 <570CFA90.4060100@gmail.com>
 <CAHp75VcrmiP0GWR-zCBmqc7zA6uiC4dD8-HDikmWZxyEwXkRLw@mail.gmail.com>
 <20160412180128.GA6965@roeck-us.net>
 <20160430183828.GC25043@sudip-laptop>
 <20160501003651.GA28804@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160501003651.GA28804@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 30, 2016 at 05:36:51PM -0700, Guenter Roeck wrote:
> On Sat, Apr 30, 2016 at 07:38:28PM +0100, Sudip Mukherjee wrote:
> > On Tue, Apr 12, 2016 at 11:01:28AM -0700, Guenter Roeck wrote:
> > > On Tue, Apr 12, 2016 at 05:58:20PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Apr 12, 2016 at 4:39 PM, Sudip Mukherjee
> > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > > On Tuesday 12 April 2016 06:36 PM, Guenter Roeck wrote:
> > > > >>
> > > > >> On 04/11/2016 10:51 PM, Sudip Mukherjee wrote:
> > > > >>>
> > > > >>> The build of avr32 allmodconfig fails with the error:
> > > > >>> ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!
> > > > >>>
> > > > >> This means there is a direct 64 bit divide operation in the driver,
> > > > >> which we should identify and fix.
> > > > 
> > > > This driver will quite likely never be used on AVR32. Do we need to
> > > > fix this due to some other architectures?
> > > > 
> > > > > yes, there is.
> > > > >
> > > > > in function: kempld_wdt_set_stage_timeout()
> > > > > remainder = do_div(stage_timeout64, prescaler);
> > > > 
> > > > > Any idea how to fix it?
> > > > 
> > > > Not easy, however, prescaler value is ((1 << 21) - 1) which someone
> > > > might consider as (1 << 21) with lost in precision.
> > > > 
> > > > Thus, shift on 20 bits right, add last bit to the value and shift on 1
> > > > bit right more.
> > > > 
> > > Sorry, I am missing something. do_div() should work fine with any 32 bit value
> > > as divisor, no matter what that value is. Why does it fail here ? And why does
> > > it work if I pass 0x1fffff as second parameter to do_div() directly ?
> > 
> > Please let me know what i can do here to help solve the problem.
> > linux-next continues to fail for avr32, and to make matters worse we
> > also have the similar problem in btrfs.
> > 
> > ERROR: "__avr32_udiv64" [fs/btrfs/btrfs.ko] undefined!
> > ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!
> > 
> > Adding Chris to CC if he has some idea how to solve this error for btrfs.
> > Build log for next-20160429 is at:
> > https://travis-ci.org/sudipm-mukherjee/parport/jobs/126581065
> > 
> 
> Try the patch below.
> 
> Guenter
> 
Sorry, patch wasn't complete.

Guenter

---
>From c684f2cf54ecb256007288af23c24bfcdb2bbace Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 Apr 2016 17:29:14 -0700
Subject: [PATCH] avr32: __div64_const32 is not ok

Building avr32 images may fail with errors such as

ERROR: "__avr32_udiv64" [fs/btrfs/btrfs.ko] undefined!
ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!

gcc for avr32 generates those symbols for certain constants used
as divisor in do_div(). The problem can be avoided by setting
__div64_const32_is_OK to false for the architecture.

Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/avr32/include/asm/Kbuild  | 1 -
 arch/avr32/include/asm/div64.h | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 arch/avr32/include/asm/div64.h

diff --git a/arch/avr32/include/asm/Kbuild b/arch/avr32/include/asm/Kbuild
index 241b9b9729d8..d2be4688ac7b 100644
--- a/arch/avr32/include/asm/Kbuild
+++ b/arch/avr32/include/asm/Kbuild
@@ -3,7 +3,6 @@ generic-y += clkdev.h
 generic-y += cputime.h
 generic-y += delay.h
 generic-y += device.h
-generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += futex.h
diff --git a/arch/avr32/include/asm/div64.h b/arch/avr32/include/asm/div64.h
new file mode 100644
index 000000000000..1f3328e178df
--- /dev/null
+++ b/arch/avr32/include/asm/div64.h
@@ -0,0 +1,3 @@
+#define __div64_const32_is_OK	false
+
+#include <asm-generic/div64.h>
-- 
2.5.0

