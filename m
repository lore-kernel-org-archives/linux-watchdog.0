Return-path: <panand@redhat.com>
Date: Wed, 4 May 2016 21:29:32 +0530
From: Pratyush Anand <panand@redhat.com>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
Message-ID: <20160504155932.GH13045@dhcppc6.redhat.com>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com>
 <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com>
 <572A0577.1070000@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572A0577.1070000@codeaurora.org>
List-ID: <linux-watchdog@vger.kernel.org>

+Dave

Hi Timur,

On 04/05/2016:09:21:43 AM, Timur Tabi wrote:
> Pratyush Anand wrote:
> >static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
> >{
> >+    struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
> >+    struct watchdog_device *wdd = &gwdt->wdd;
> >+    u64 timeout = (u64)gwdt->clk * wdd->timeout;
> >+
> >+    writeq(timeout + arch_counter_get_cntvct(),
> >+                    gwdt->control_base + SBSA_GWDT_WCV);
> >+
> >      panic(WATCHDOG_NAME " timeout");
> 
> I'm on the fence about this.
> 
> On one hand, I have always opposed the idea that the interrupt handler needs
> to function properly in order for the timeout to be correct.  Fu's original
> patch required this for every timeout.
> 
> The current code, however, only uses the interrupt when action=1.  In this
> case, WCV is only reprogrammed in order to prevent the system from resetting
> during the kexec.  Technically, the watchdog timeout has already been
> handled.

Yes.

> 
> However, this should be unnecessary, because it can't be a problem that's
> unique to the SBSA watchdog.  Every system that kexecs another kernel needs
> to be able to handle a watchdog timeout.  Shouldn't the kexec code already
> ping or disable the watchdog?  We need a cross-platform solution.  Drivers
> should not need to do this.

Its unique to SBSA because you have very little timeout here. kexec-tools
upstream does not have any mechanism to handle watchdog timeout. Lets say even
if we implement a framework there, the best it can do is to ping the watchdog
again. Disabling should not be an option in kexec-tools, because in that case if
kexec-tools or secondary kernel stuck, we won't have a way out.
Now, even if we ping it once in kexec tools, we will have to make sure that
watchdog driver's probe is called before timeout. Therefore, user must have a
way to specify this timeout, so that if a particular kernel take more time to
boot then he can increase the timeout. Given, these variable conditions I do not
see much advantage of implementing it in kexec-tools.

However fedora/rhel kedumpctl mechanism does some  best case correction. It
makes sure that watchdog module is loaded in second kernel if watchdog was
active during first kernel, and loaded as early as possible [1].

~Pratyush

[1] https://github.com/pratyushanand/kexec-tools/commits/watchdog_fmaster
