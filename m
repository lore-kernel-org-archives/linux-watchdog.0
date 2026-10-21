Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581534;
	b=2LYq6rVew8oEuS02vBE6t5vhz2nAiZGMtK5E+GK4+kmp1w4kg6n9VFp3P7/iD1xxwzli
	 iKB238f7qnJW0/Qu54n5CHMCa6FihpzEHdftnvwO/oA6CegIm29KYV/Ww1Z3kAgCqVZ66
	 zf32wwHXSDMLleFwY2KKmJyTivjZ7lxXzYdnl3DDu/+YEJgbDgu80vpTF53+Vbpipiwsl
	 hwxjU2tSy55f1d8KCjdW6Ccl1tNYjEa5dE9v1zad+JALHFVpgHwchYImVNEuVDExNqm/n
	 RbJ6SiROGGcHoTe/rb/tXK3SY5LgfTf7bf7IMEnIK+tQDXc3IexVPlKOMvF0gBRqCFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581534;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RUVSPvOusEPDcxbKoxUzwI+i0SOx4REoavCHaUCGKS8=;
	b=4Q1AU68bx+6QPWQzo4dIYCCj3JdgvKxe3kCB8FxU7AAr6IW7cvqAeiKB+xR8t9EQeIL5
	 zZtzZydHZzSaLBemD8QbNhXsQNNwklMV76N0tWdAzao48jmL70tnHisVIFdYxLgy3Nh6M
	 DkP8n5g/ynTTLz269URO93L4VXMFbvDRDYRmWpJras+gFimJmfBm3V1rr+/EP55uHerws
	 aXd8oiogDjn8d+VRz+sSUzsne8Jr5l8dBCIlkPEjdf6J2Ay2NEfk2q1vIltYdWP8W+YDv
	 YDiGqQnvJlckJtoLBirrpJhY3YUsgzoQqsH5dz1Uep863PrhOk1zViC5ITSNxOEyEkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Nzihi9PT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF8606A319;
	Wed, 21 Oct 2026 11:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28AF8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Nzihi9PT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C926016F8;
	Wed, 21 Oct 2026 04:18:48 -0700 (PDT)
Received: from [10.57.78.129] (unknown [10.57.78.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1324E3F7D8;
	Wed, 21 Oct 2026 04:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792581532; bh=9asrnmphDtRD/Xpr13UrW46SqE+vWmkJ5y1evI5+R6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nzihi9PT0ig+89d5JTsqKKaFfSwnuT/hEwWjYN5I8yaqpIgMwHjjgbhJm55Chfqix
	 1vaBGhJmt3z21nuaXtVGMXVIgVWgAl4bF5AqWGryVVwQ9WkLuPx6vwy/G6aOG/wN1/
	 Gv4eo9vyvP8GpUA46s9cC5wD742tzJPBBdAN+jxc=
Message-ID: <7f077fd3-9c67-409a-b46f-7f28a55c180b@arm.com>
Date: Wed, 21 Oct 2026 12:18:39 +0100
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
 linux-watchdog@vger.kernel.org
References: <arZNL9BnTGK0Klwc@red-moon> <arZS4vwxps01dGb7@ashevche-desk.local>
 <arqSqcoWAkhy-8do@red-moon> <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
 <asieTvinZ7c2QpQm@red-moon>
 <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon>
 <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon> <athimRqtDvQu1ZzA@ashevche-desk.local>
 <atiAmZSPiRNBAO5O@red-moon>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <atiAmZSPiRNBAO5O@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-21 10:06 am, Lorenzo Pieralisi wrote:
> On Wed, Oct 21, 2026 at 09:58:33AM +0300, Andy Shevchenko wrote:
>> On Tue, Oct 20, 2026 at 05:30:00PM +0200, Lorenzo Pieralisi wrote:
>>> On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (Intel) wrote:
>>>> On Mon, Oct 19, 2026 at 12:34 PM Lorenzo Pieralisi
>>>> <lpieralisi@kernel.org> wrote:
>>
>> [...]
>>
>>>> Basically, yes, the idea is to defer the creation of the platform
>>>> device until the dependency is met.
>>>>
>>>>> till the dependencies are cleared but then, without a _CRS, where will
>>>>> the consumer driver find the platform device resources ?
>>>>
>>>> Well, good question.
>>>>
>>>>> There are multiple facets in this issue and possibly some of them have
>>>>> been already solved but I need to pull them together.
>>>>>
>>>>>> Note that the dependencies can be added to acpi_dep_list after
>>>>>> creating a struct acpi_device with acpi_add_single_object() and
>>>>>> acpi_scan_add_dep() is not really suitable for that, but it should be
>>>>>> doable if the dependencies can be found.
>>>>>>
>>>>>>> I need to have a deeper look into this next week but I wanted to ask first
>>>>>>> whether there was something I missed - most likely.
>>>>>>
>>>>>> Well, it is not really straightforward.
>>>>>
>>>>> Yes it is getting messy. This RFC, with all its flaws, does not transparently
>>>>> prevents enumeration but rather relies on -EPROBE_DEFER to sort out
>>>>> dependencies - though it does so by adding more stuff into ACPI static fwnode
>>>>> that to be honest I'd rather see gone.
>>>>
>>>> I think what you need is a notification mechanism that will trigger
>>>> when a specific device (enumerated via the ACPI Namespace) becomes
>>>> operational.  It doesn't look like any of the existing ones (platform
>>>> device probe deferral or ACPI device dependencies tracking) is really
>>>> suitable for your use case.
>>>
>>> Yes. It might just be a notification from ACPI core to say "the driver for
>>> this ACPI device probed, go create platform devices that depends on it".
>>>
>>> We can check and track the dependency in code that does create those
>>> devices today.
>>>
>>> I will think about this to see how bad this might look like.
>>
>> Don't we do something similar in drivers/acpi/x86/lpss.c?
> 
> I suppose I can add a notifier that checks whether the device whose
> companion represents the ACPI device a given platform device IRQ depends
> on was bound to its driver and then map the IRQ and add the platform device
> _then_ - after all that's what acpi_dev_clear_dependencies() does (similar
> at least).
> 
> There is still the question - where the GSI number, flags should be
> stashed so that the notifier can grab them in a uniform way. We
> could simply attach platform data storing those values to a pdev, either on
> a per static table basis or generalize the data so that a single notifier
> would be able to deal with it.
> 
> That or I can just piggyback on acpi_dev_clear_dependencies() and add
> a separate dep mechanism to acpi_dep_data that instead of being acpi_handle
> based the consumer is fwnode based (something Rafael mentioned before).
> 
> I will have a stab at this and see what's the least bad solution I can
> come up with.
> 
> I suppose we are scrapping the -EPROBE_DEFER solution (ie this set),
> what we are talking about above won't need to defer anything other
> than the time when platform devices are added.

I dunno, that seems pretty drastic for some use-cases - the fact that a 
GSI is described in a table doesn't necessarily mean it is critical to 
device operation. If we don't even create the device until all possible 
resources are available, then its driver never has any chance to decide 
whether it's happy to ignore the deferral and just use MSIs or polling 
instead...

Thanks,
Robin.
