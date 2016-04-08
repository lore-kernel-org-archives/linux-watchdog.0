Return-path: <vilhelm.gray@gmail.com>
Date: Fri, 8 Apr 2016 15:27:23 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
	linus.walleij@linaro.org, gnurou@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 04/10] iio: stx104: Change STX104 dependency to ISA_BUS
Message-ID: <20160408192723.GA31687@sophia>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
 <783be62acf68b35f3fe4785a2cedfe017624688b.1460040201.git.vilhelm.gray@gmail.com>
 <20160408004503.GB10211@roeck-us.net>
 <20160408123158.GB18202@sophia>
 <5707AF91.5010704@roeck-us.net>
 <20160408150922.GA28058@sophia>
 <20160408182801.GB7083@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160408182801.GB7083@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Apr 08, 2016 at 11:28:01AM -0700, Guenter Roeck wrote:
>On Fri, Apr 08, 2016 at 11:09:22AM -0400, William Breathitt Gray wrote:
>> I feel now that the introduction of the ISA_BUS option may the wrong
>> approach to resolve lack of ISA support for the X86_64 architecture;
>> adding ISA_BUS depends or selects through various Kconfigs would simply
>> obfuscate the ISA option. The true issue is that various driver
>> configs are assuming X86_32 architecture when they depend on the ISA
>> option, but the ISA bus does not require an X86_32 architecture.
>> 
>> The proper resolution then is to remove the misguided ISA_BUS option and
>> move the X86_32 dependency to the relevant drivers configs explicitly.
>> A grep for isa_register_driver calls within the kernel reveals that only
>> a few drivers explicitly use it. It should be trivial to create a patch
>> to add the explicit X86_32 dependency to the relevant drivers, so I will
>> submit one soon when I get the time to decouple X86_32 from the ISA
>> config option.
>> 
>
>That might be tricky: At least some if not many of those drivers are expected
>to run on non-X86 architectures, and thus don't really depend on X86_32
>(possibly some depend on 32 bit - I didn't check).
>
>I count 44 calls to isa_register_driver() in the current mainline.
>Not sure if this counts as "only a few drivers".
>
>Thanks,
>Guenter

You're right, I there are more drivers that call isa_register_driver
than I had estimated. I think a different approach may work however.

When I initially proposed a patch to decouple the X86_32 dependency from
the ISA config option, I received a reply from the 0-DAY kernel test
auto-build indicating the errors from the drivers assuming a X86_32
architecture
(http://www.gossamer-threads.com/lists/linux/kernel/2350122#2350122).
After reviewing the debug messages, I realized there are only four main
issues:

 1. sound/isa/sscape.c:594:14:
     snd_printk format uses '%d' but a size_t is passed in
 2. arch/x86/mm/extable.c:23:15:
     'SEGMENT_IS_PNP_CODE' is undeclared
 3. drivers/pnp/pnpbios/bioscall.c:
     a slew of undeclared symbols and casting type mismatches
 4. drivers/scsi/ultrastor.c:674:29:
     sprintf format uses '%05X' but a kernel pointer is passed in

Both issue 1 and issue 4 are easily fixed by patching the respective
lines to match the format string with the variable type and vice-versa.

Issue 2 and 3 are the actual X86_32 assumption I had suspected: these
files depend on symbols declared in the include/asm/segment.h file; the
declaration of these symbols is conditional: #ifdef CONFIG_X86_32.

I believe this is the source of the issues I encountered on my initial
attempt to decouple the X86_32 dependency from the ISA option. I suspect
if I add an explicit X86_32 dependency to the PNPBIOS driver, I will be
able to remove the X86_32 dependency from the ISA option without
incident from the other drivers.

William Breathitt Gray
