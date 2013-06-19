Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:49372 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756422Ab3FSH4S (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Jun 2013 03:56:18 -0400
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 01/14] =?UTF-8?Q?watchdog/mpcore=5Fwdt=3A=20Mark=20it=20as?=
 =?UTF-8?Q?=20BROKEN?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Jun 2013 09:56:03 +0200
From: Marc Zyngier <marc.zyngier@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Olof Johansson <olof@lixom.net>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@nvidia.com>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
In-Reply-To: <CAKohpom3S3NMhxbhbmyC6bceS51727CnWRWmWDGxwDcRJkHFyQ@mail.gmail.com>
References: <cover.1371535241.git.viresh.kumar@linaro.org> <22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org> <20130618154236.GA9022@roeck-us.net> <51C086A8.3070601@arm.com> <CAOesGMia0OZz5dcDooRHG9EAnaLimRL5_Gku2rm_fVDNxrxEEA@mail.gmail.com> <CAKohpom3S3NMhxbhbmyC6bceS51727CnWRWmWDGxwDcRJkHFyQ@mail.gmail.com>
Message-ID: <319bb53672a5fa97b7aa603392b6a2fa@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Jun 2013 08:40:25 +0530, Viresh Kumar <viresh.kumar@linaro.org=
>
wrote:
> Wow!! So many replies, let me reply to everyone in this chain.
>=20
> On 18 June 2013 22:05, Olof Johansson <olof@lixom.net> wrote:
>> On Tue, Jun 18, 2013 at 9:11 AM, Marc Zyngier <marc.zyngier@arm.com>
>> wrote:
>>> On 18/06/13 16:42, Guenter Roeck wrote:
>>>> On Tue, Jun 18, 2013 at 08:50:25PM +0530, Viresh Kumar wrote:
>=20
>>>>> Lets mark it broken until somebody with this hardware gets up and
>>>>> fixes it.
>>>>>
>>>> I must be missing something. What is the point of the remaining
>>>> patches in this
>>>> case ?
>=20
> In case somebody wakes up and tries to fix this driver, he doesn't have
to
> write stuff which I already wrote. That's it. This stuff was pending in
my
> tree
> for more than a year now and I wanted to get rid of it (without deletin=
g
> it) :)
>=20
>>> Indeed. This looks like pointless churn to me, unless someone actuall=
y
>>> picks up the driver and fixes it for good.
>>>
>>> If nobody cares enough about it, then maybe it should be moved into
>>> staging and eventually retired...
>>
>>
>> That was a year ago, and nobody has done anything to the driver. Just
>> remove it -- if someone wants to do the work later on it's easy to
>> revert the commit and start over.
>>
>> Keeping code in the kernel but marking it BROKEN is only useful if we
>> think someone will fix it soon. It seems very unlikely in this case.
>=20
> I believed that this is the driver which will be used by all cortex
> family, i.e.
> all ARM SMP platforms, isn't it? I am sure atleast the A9 family had
this.

ARM11, A5 and A9 in their MP configurations only.

> If no, then which ones are the real users of this driver/hardware?
> If yes, Why isn't anybody using this?

Because, as Russell mentioned, the piece of IP doesn't fit our watchdog
model at all (per-CPU watchdog???), and most SoCs/boards have a separate
watchdog anyway.

> I will send a patch that will delete this driver and will provide link
to
> my
> patches, in case somebody wants it back in future.

Thanks.

        M.
--=20
Fast, cheap, reliable. Pick two.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
