Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:55994 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933861Ab3FSDK0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 23:10:26 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so5350108obc.40
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 20:10:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOesGMia0OZz5dcDooRHG9EAnaLimRL5_Gku2rm_fVDNxrxEEA@mail.gmail.com>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
	<22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org>
	<20130618154236.GA9022@roeck-us.net>
	<51C086A8.3070601@arm.com>
	<CAOesGMia0OZz5dcDooRHG9EAnaLimRL5_Gku2rm_fVDNxrxEEA@mail.gmail.com>
Date: Wed, 19 Jun 2013 08:40:25 +0530
Message-ID: <CAKohpom3S3NMhxbhbmyC6bceS51727CnWRWmWDGxwDcRJkHFyQ@mail.gmail.com>
Subject: Re: [PATCH V3 01/14] watchdog/mpcore_wdt: Mark it as BROKEN
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Olof Johansson <olof@lixom.net>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@nvidia.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wow!! So many replies, let me reply to everyone in this chain.

On 18 June 2013 22:05, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Jun 18, 2013 at 9:11 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 18/06/13 16:42, Guenter Roeck wrote:
>>> On Tue, Jun 18, 2013 at 08:50:25PM +0530, Viresh Kumar wrote:

>>>> Lets mark it broken until somebody with this hardware gets up and fixes it.
>>>>
>>> I must be missing something. What is the point of the remaining patches in this
>>> case ?

In case somebody wakes up and tries to fix this driver, he doesn't have to
write stuff which I already wrote. That's it. This stuff was pending in my tree
for more than a year now and I wanted to get rid of it (without deleting it) :)

>> Indeed. This looks like pointless churn to me, unless someone actually
>> picks up the driver and fixes it for good.
>>
>> If nobody cares enough about it, then maybe it should be moved into
>> staging and eventually retired...
>
>
> That was a year ago, and nobody has done anything to the driver. Just
> remove it -- if someone wants to do the work later on it's easy to
> revert the commit and start over.
>
> Keeping code in the kernel but marking it BROKEN is only useful if we
> think someone will fix it soon. It seems very unlikely in this case.

I believed that this is the driver which will be used by all cortex family, i.e.
all ARM SMP platforms, isn't it? I am sure atleast the A9 family had this.

If no, then which ones are the real users of this driver/hardware?
If yes, Why isn't anybody using this?

I will send a patch that will delete this driver and will provide link to my
patches, in case somebody wants it back in future.

--
Viresh
