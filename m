Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43852 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbKEFNt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 00:13:49 -0500
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
To: Timur Tabi <timur@codeaurora.org>, Fu Wei <fu.wei@linaro.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-6-git-send-email-fu.wei@linaro.org>
 <CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>,
	Rob Herring <robherring2@gmail.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Dave Young <dyoung@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <563AE588.1080009@roeck-us.net>
Date: Wed, 4 Nov 2015 21:13:44 -0800
MIME-Version: 1.0
In-Reply-To: <CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/04/2015 05:59 PM, Timur Tabi wrote:
> On Tue, Oct 27, 2015 at 11:06 AM,  <fu.wei@linaro.org> wrote:
>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>> +{
>> +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>> +       struct watchdog_device *wdd = &gwdt->wdd;
>> +
>> +       /* We don't use pretimeout, trigger WS1 now */
>> +       if (!wdd->pretimeout)
>> +               sbsa_gwdt_set_wcv(wdd, 0);
>
> So I'm still concerned about the fact this driver depends on an
> interrupt handler in order to properly program the hardware.  Unlike
> some other devices, the SBSA watchdog does not need assistance to
> reset on a timeout -- it is a "fire and forget" device.  What happens
> if there is a hard lockup, and interrupts no longer work?
>
> Keep in mind that 99% of watchdog daemons will not enable the
> pre-timeout feature because it's new.
>
Same here, really.

I would feel much more comfortable if the driver would just use the standard
watchdog timeout and live with (worst case) 20 seconds timeout for now.
This limitation will be gone once the infrastructure is in place to handle
such short timeouts in the watchdog core. Until then, I would argue that the
system designers asked for it if they really select the highest possible
clock rate.

Guenter

