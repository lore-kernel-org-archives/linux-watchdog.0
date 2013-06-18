Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:46250 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933051Ab3FRQfW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 12:35:22 -0400
Received: by mail-qc0-f172.google.com with SMTP id j10so2458916qcx.31
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 09:35:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51C086A8.3070601@arm.com>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
	<22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org>
	<20130618154236.GA9022@roeck-us.net>
	<51C086A8.3070601@arm.com>
Date: Tue, 18 Jun 2013 09:35:20 -0700
Message-ID: <CAOesGMia0OZz5dcDooRHG9EAnaLimRL5_Gku2rm_fVDNxrxEEA@mail.gmail.com>
Subject: Re: [PATCH V3 01/14] watchdog/mpcore_wdt: Mark it as BROKEN
From: Olof Johansson <olof@lixom.net>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 18, 2013 at 9:11 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 18/06/13 16:42, Guenter Roeck wrote:
>> On Tue, Jun 18, 2013 at 08:50:25PM +0530, Viresh Kumar wrote:
>>> This driver was broken since ever.
>>>
>>> - Interrupt request doesn't use the right API: The TWD watchdog uses a per-cpu
>>>   interrupt (usually interrupt #30), and the GIC configuration should flag it as
>>>   such. With this setup, request_irq() should fail, and the right API is
>>>   request_percpu_irq(), together with enable_percpu_irq()/disable_percpu_irq().
>>>
>>> - Nothing ensures the userspace ioctl() will end-up kicking the watchdog on the
>>>   right CPU.
>>>
>>> Was last discussed here:
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/095960.html
>>>
>>> Lets mark it broken until somebody with this hardware gets up and fixes it.
>>>
>> I must be missing something. What is the point of the remaining patches in this
>> case ?
>
> Indeed. This looks like pointless churn to me, unless someone actually
> picks up the driver and fixes it for good.
>
> If nobody cares enough about it, then maybe it should be moved into
> staging and eventually retired...


That was a year ago, and nobody has done anything to the driver. Just
remove it -- if someone wants to do the work later on it's easy to
revert the commit and start over.

Keeping code in the kernel but marking it BROKEN is only useful if we
think someone will fix it soon. It seems very unlikely in this case.


-Olof
