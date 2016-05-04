Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Pratyush Anand <panand@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, wim@iguana.be,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net> <20160503143856.GE13045@dhcppc6.redhat.com>
 <5728BEC4.6050603@codeaurora.org> <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <572A0577.1070000@codeaurora.org>
Date: Wed, 4 May 2016 09:21:43 -0500
MIME-Version: 1.0
In-Reply-To: <20160504141449.GG13045@dhcppc6.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Pratyush Anand wrote:
> static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
> {
> +    struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
> +    struct watchdog_device *wdd = &gwdt->wdd;
> +    u64 timeout = (u64)gwdt->clk * wdd->timeout;
> +
> +    writeq(timeout + arch_counter_get_cntvct(),
> +                    gwdt->control_base + SBSA_GWDT_WCV);
> +
>       panic(WATCHDOG_NAME " timeout");

I'm on the fence about this.

On one hand, I have always opposed the idea that the interrupt handler 
needs to function properly in order for the timeout to be correct.  Fu's 
original patch required this for every timeout.

The current code, however, only uses the interrupt when action=1.  In 
this case, WCV is only reprogrammed in order to prevent the system from 
resetting during the kexec.  Technically, the watchdog timeout has 
already been handled.

However, this should be unnecessary, because it can't be a problem 
that's unique to the SBSA watchdog.  Every system that kexecs another 
kernel needs to be able to handle a watchdog timeout.  Shouldn't the 
kexec code already ping or disable the watchdog?  We need a 
cross-platform solution.  Drivers should not need to do this.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
