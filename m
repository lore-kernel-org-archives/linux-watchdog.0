Return-path: <dyoung@redhat.com>
Date: Wed, 16 Sep 2015 09:57:41 +0800
From: Dave Young <dyoung@redhat.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Wei Fu <tekkamanninja@gmail.com>,
        G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Vipul Gandhi <vgandhi@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>, Jon Masters <jcm@redhat.com>,
        Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>,
        Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v7 5/8] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150916015741.GA6699@dhcp-128-62.nay.redhat.com>
References: <=fu.wei@linaro.org>
 <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
 <1440435683-7343-6-git-send-email-fu.wei@linaro.org>
 <20150915083823.GB5767@localhost.localdomain>
 <CADyBb7sDPgFU3Hb_f_iMtF7TYU0xoBnuLCDUihufdOShO5uOkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7sDPgFU3Hb_f_iMtF7TYU0xoBnuLCDUihufdOShO5uOkg@mail.gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

> >> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> >> new file mode 100644
> >> index 0000000..7ae45cc
> >> --- /dev/null
> >> +++ b/drivers/watchdog/sbsa_gwdt.c
> >> @@ -0,0 +1,459 @@
> >> +/*
> >> + * SBSA(Server Base System Architecture) Generic Watchdog driver
> >> + *
> >> + * Copyright (c) 2015, Linaro Ltd.
> >> + * Author: Fu Wei <fu.wei@linaro.org>
> >> + *         Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License 2 as published
> >> + * by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * The SBSA Generic watchdog driver is compatible with the pretimeout
> >> + * concept of Linux kernel.
> >> + * The timeout and pretimeout are determined by WCV or WOR.
> >> + * The first watch period is set by writing WCV directly, that can
> >> + * support more than 10s timeout at the maximum system counter
> >> + * frequency (400MHz).
> >> + * When WS0 is triggered, the second watch period (pretimeout) is
> >> + * determined by one of these registers:
> >> + * (1)WOR: 32bit register, this gives a maximum watch period of
> >> + * around 10s at the maximum system counter frequency. It's loaded
> >> + * automatically by hardware.
> >> + * (2)WCV: If the pretimeout value is greater then "max_wor_timeout",
> >> + * it will be loaded in WS0 interrupt routine. If system is in
> >> + * ws0_mode (reboot by kexec/kdump in panic with watchdog enabled
> >> + * and WS0 == true), the ping operation will only reload WCV.
> >
> > Below is the field comment about ws0_mode, it says ws0_mode is only
> > for rebooting in second stage timeout, but kexec/kdump can reboot in
> > either first or second stage
> 
> Great thanks for your feedback.
> 
> yes, if kexec/kdump reboot the system before the WS0, ws0_mode may not be set.
> in this case, if WS0 is triggered during the reboot(AFAIK, panic will
> disable irq, and in the early boot stage of system, irq is disabled,
> too.), ws0_mode will be set at the next "open" in kdump kernel
> if WS0 haven't triggered until the watchdog is opened again in kdump
> kernel , ws0_mode won't  be set.
> 
> ws0_mode doesn't indicate if the system is in the kdump kernel, it
> indicates that if WS0 is triggered, when the watchdog is initialized.
> 
> Do I answer your question?

Yes, thanks for explanation. So it sounds better to change the comment like below?
from
(reboot by kexec/kdump in panic with watchdog enabled and WS0 == true)
to
(reboot in the pre-timeout stage and WS0 == true)

Thanks
Dave
