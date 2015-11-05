Return-path: <timur@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1445961999-9506-6-git-send-email-fu.wei@linaro.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-6-git-send-email-fu.wei@linaro.org>
Date: Wed, 4 Nov 2015 19:59:07 -0600
Message-ID: <CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
From: Timur Tabi <timur@codeaurora.org>
To: Fu Wei <fu.wei@linaro.org>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Pratyush Anand <panand@redhat.com>, Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>, Rob Herring <robherring2@gmail.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>, Dave Young <dyoung@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Oct 27, 2015 at 11:06 AM,  <fu.wei@linaro.org> wrote:
> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
> +{
> +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
> +       struct watchdog_device *wdd = &gwdt->wdd;
> +
> +       /* We don't use pretimeout, trigger WS1 now */
> +       if (!wdd->pretimeout)
> +               sbsa_gwdt_set_wcv(wdd, 0);

So I'm still concerned about the fact this driver depends on an
interrupt handler in order to properly program the hardware.  Unlike
some other devices, the SBSA watchdog does not need assistance to
reset on a timeout -- it is a "fire and forget" device.  What happens
if there is a hard lockup, and interrupts no longer work?

Keep in mind that 99% of watchdog daemons will not enable the
pre-timeout feature because it's new.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
