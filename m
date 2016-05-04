Return-path: <panand@redhat.com>
Date: Wed, 4 May 2016 19:44:49 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
Message-ID: <20160504141449.GG13045@dhcppc6.redhat.com>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com>
 <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160503171602.GA2518@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 03/05/2016:10:16:02 AM, Guenter Roeck wrote:
> On Tue, May 03, 2016 at 09:21:41PM +0530, Pratyush Anand wrote:
> > On 03/05/2016:10:07:48 AM, Timur Tabi wrote:
> > > Pratyush Anand wrote:
> > > >In fact after supporting max_hw_heartbeat_ms, there should be no change for
> > > >action=0 functionally. However, we would still need some changes for action=1.
> > > 
> > > IMHO, action=1 is more of a debugging option, and not something that would
> > > be used normally.  I would need to see some evidence that real users want to
> > > have action=1 and a longer timeout.
> > > 
> > If action=1 need to be used effectively, then we should have something which
> > would help to increase timeout values.
> > 
> > Currently you have only 10 second to execute secondary kernel, which might not
> > be sufficient.
> > 
> Previously the argument was that the 10 seconds (assuming the clock runs at
> maximum speed) would not be sufficient to load the watchdog application. Now it

May be you meant "would be sufficient". OK..let me clarify on it.

Currently it takes 7-8 second from the point 1st kernel panics to the point
second kernel boots. (Given, we have D-cache enabled in kexec-tools, for which
community is not yet agreed), anyway..so, it is safe for me as of now. But,
there is only 2-3 second margin. So, I am not sure if all sort of secondary
kernel will be able to make it in that time.

Following minimal code will be able to extend timeout for secondary kernel, and
I do not see anything wrong in it. We are anyway, panicking in ISR, so what
could be disadvantage if we write a wdt register just before panicking?

--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -221,6 +221,13 @@ static int sbsa_gwdt_stop(struct watchdog_device *wdd)
 
static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
{
+    struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
+    struct watchdog_device *wdd = &gwdt->wdd;
+    u64 timeout = (u64)gwdt->clk * wdd->timeout;
+
+    writeq(timeout + arch_counter_get_cntvct(),
+                    gwdt->control_base + SBSA_GWDT_WCV);
+
     panic(WATCHDOG_NAME " timeout");
      
             return IRQ_HANDLED;

~Pratyush
