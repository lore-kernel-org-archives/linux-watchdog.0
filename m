Return-path: <zboszor@pr.hu>
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
To: Guenter Roeck <linux@roeck-us.net>
References: <1485728348.3220.10.camel@googlemail.com>
 <1488530782.2457.41.camel@users.sourceforge.net>
 <20170303101702.GA1669@katana>
 <1490944639.2653.182.camel@users.sourceforge.net>
 <585a27fb-be15-df9f-00a9-bd4c3a654142@roeck-us.net>
 <d1152062-77c5-f1b7-6be9-d24ee221ada9@pr.hu>
 <20170331150524.GA31555@roeck-us.net>
 <efce69fc-3899-43f4-c8ee-12b78a571e5a@pr.hu>
 <0b32728a-f545-be43-2870-94688f1f9da5@roeck-us.net>
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
 Wolfram Sang <wsa@the-dreams.de>, Christian Fetzer <fetzer.ch@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org, 853122@bugs.debian.org,
 Wim Van Sebroeck <wim@iguana.be>, Tim Small <tim@seoss.co.uk>,
 Nehal Shah <nehal-bakulchandra.shah@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>,
 linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
 Alan Stern <stern@rowland.harvard.edu>
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <14472f36-3c8d-e77d-4077-bd0db3587281@pr.hu>
Date: Sat, 1 Apr 2017 18:20:52 +0200
MIME-Version: 1.0
In-Reply-To: <0b32728a-f545-be43-2870-94688f1f9da5@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

2017-04-01 15:32 keltezéssel, Guenter Roeck írta:
> On 04/01/2017 03:13 AM, Boszormenyi Zoltan wrote:
>> 2017-03-31 17:05 keltezéssel, Guenter Roeck írta:
>>> On Fri, Mar 31, 2017 at 04:46:02PM +0200, Boszormenyi Zoltan wrote:
>>>> 2017-03-31 14:49 keltezéssel, Guenter Roeck írta:
>>>>> request_muxed_region() can fail, and literally every other driver
>>>>> using it checks for that failure. Please do the same.
>>>>
>>>> In what circumstances can request_muxed_region() fail? As far as
>>>> I can see, only if two drivers use the same I/O port base and the
>>>> already present region did not use IORESOURCE_MUXED which is
>>>> not the case here. When request_muxed_region() is used consistently,
>>>> subsequent requests are put on a wait queue and the first one is
>>>> woken up when the region is released. So, it's basically a mutex.
>>>> Am I missing something here?
>>>>
>>>
>>> Yes. failure to allocate the resource is one.
>>
>> So, a common mutex should be used.
>>
>
> Just because you don't want to check for errors ?
>
> I am not on favor of your new solution. I think it violates layering all over
> the place, and I dislike the idea of having a global mutex as you propose.
> I won't shut it down, but I'll let others provide feedback on your new series
> of patches.

It's not because I don't want to check for errors, it's about avoiding them.

It's not my favourite either but there is a lot of weight in existing code.

You cannot avoid layering violations if multiple driver subsystems use
their respective functionality in devices in multiplexed way.

The biggest problem is that quirk functions, including usb_amd_quirk_pll()
has the "void" return type so there is no way to indicate errors to the
callers in case of an error.

The best clean alternative would be add new resource handling infrastructure.
* Expose the currently static alloc_resource() in kernel/resource.c
   With this, driver initialization can allocate the resource once
   for the lifetime of the driver and it it fails,
* Add a new insert_muxed_region() / __insert_muxed_region() function with
   different semantics from request_muxed_region() / __request_region():
   1 Accept a pointer to already allocated resource.
   2 If the conflicting resource doesn't have IORESOURCE_MUXED set,
     complain loudly in the syslog but still go into the wait queue.
     The conflicting resource also has the name which can be printed
     so the inconsistent resource / region usage can be fixed.
   We can also just modify the __request_region() semantics, so:
   1 It accepts a pointer to an allocated resource or NULL.
     In the second case, the resource is allocated internally and can
     still fail.
   2 The above second point. But this may cause an error in code that
     expects the old semantics.

The window for request_muxed_region()+release_region() is so short
that the requested I/O port range would not show up in /proc/ioports.

All this would be to fix only 3 drivers in a no-error scenario and only
achieving the functionality of a mutex seems to be overkill.

Another alternative is to revert commit 2fee61d22e606fc99ade9079fda15fdee83ec33e
that caused the regression in sp5100_tco in the first place.

Best regards,
Zoltán Böszörményi
