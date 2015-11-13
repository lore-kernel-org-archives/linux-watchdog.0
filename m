Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55190 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbbKMAX4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Nov 2015 19:23:56 -0500
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
To: Al Stone <al.stone@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
	Fu Wei <fu.wei@linaro.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-6-git-send-email-fu.wei@linaro.org>
 <CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
 <563AE588.1080009@roeck-us.net> <563B5DF9.6080102@codeaurora.org>
 <CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
 <563B62F7.3050307@codeaurora.org>
 <CADyBb7vDf+KRi8gUGEt+iu-GpqVQgVq7nKTVt7O=3x78KCi+RQ@mail.gmail.com>
 <563B6A4B.7090400@codeaurora.org>
 <CADyBb7t6ovfrz1b3ZZykKq22HkZi1W0PWg7-wXihEjM9ciTgGg@mail.gmail.com>
 <563B869F.2010004@roeck-us.net> <56452970.4070209@linaro.org>
Cc: Pratyush Anand <panand@redhat.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-doc@vger.kernel.org, Jon Masters <jcm@redhat.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	lkml <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robherring2@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Young <dyoung@redhat.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56452D98.80704@codeaurora.org>
Date: Thu, 12 Nov 2015 18:23:52 -0600
MIME-Version: 1.0
In-Reply-To: <56452970.4070209@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/12/2015 06:06 PM, Al Stone wrote:
> If it is a NAK, that's fine, but I also want to be sure I understand what the
> objections are.  Based on my understanding of the discussion so far over the
> multiple versions, I think the primary objection is that the use of pretimeout
> makes this driver too complex, and indeed complex enough that there is some
> concern that it could destabilize a running system.  Do I have that right?

I don't have a problem with the concept of pre-timeout per se.  My 
primary objection is this code:

 > +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
 > +{
 > +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
 > +       struct watchdog_device *wdd = &gwdt->wdd;
 > +
 > +       /* We don't use pretimeout, trigger WS1 now */
 > +       if (!wdd->pretimeout)
 > +               sbsa_gwdt_set_wcv(wdd, 0);

This driver depends on an interrupt handler in order to properly program 
the hardware.  Unlike some other devices, the SBSA watchdog does not 
need assistance to reset on a timeout -- it is a "fire and forget" 
device.  What happens if there is a hard lockup, and interrupts no 
longer work?

The reason why Fu does this is because he wants to support a pre-timeout 
value that's independent of the timeout value.  The SBSA watchdog is 
normally programmed where real timeout equals twice the pre-timeout.  I 
would prefer that the driver adhere to this limitation.  That would 
eliminate the need to pre-program the hardware in the interrupt handler.

> And finally, a simpler, single stage timeout watchdog driver would be a
> reasonable thing to accept, yes?  I can see where that would make sense.

I would be okay with merging such a driver, and then enhancing it later 
to add pre-timeout support.

> The issue for me in that case is that the SBSA requires a two stage timeout,
> so a single stage driver has no real value for me.

There are plenty of existing watchdog devices that have a two-stage 
timeout but the driver treats it as a single stage.  The PowerPC 
watchdog driver is like that.  The hardware is programmed for the second 
stage to cause a hardware reset, and the interrupt handler is typically 
a no-op or just a printk().

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
