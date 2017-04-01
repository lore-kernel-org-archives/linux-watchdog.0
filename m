Return-path: <zboszor@pr.hu>
From: Boszormenyi Zoltan <zboszor@pr.hu>
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
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
 Wolfram Sang <wsa@the-dreams.de>, Christian Fetzer <fetzer.ch@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org, 853122@bugs.debian.org,
 Wim Van Sebroeck <wim@iguana.be>, Tim Small <tim@seoss.co.uk>,
 Nehal Shah <nehal-bakulchandra.shah@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>,
 linux-kernel@vger.kernel.org
Message-ID: <efce69fc-3899-43f4-c8ee-12b78a571e5a@pr.hu>
Date: Sat, 1 Apr 2017 12:13:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170331150524.GA31555@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

2017-03-31 17:05 keltezéssel, Guenter Roeck írta:
> On Fri, Mar 31, 2017 at 04:46:02PM +0200, Boszormenyi Zoltan wrote:
>> 2017-03-31 14:49 keltezéssel, Guenter Roeck írta:
>>> request_muxed_region() can fail, and literally every other driver
>>> using it checks for that failure. Please do the same.
>>
>> In what circumstances can request_muxed_region() fail? As far as
>> I can see, only if two drivers use the same I/O port base and the
>> already present region did not use IORESOURCE_MUXED which is
>> not the case here. When request_muxed_region() is used consistently,
>> subsequent requests are put on a wait queue and the first one is
>> woken up when the region is released. So, it's basically a mutex.
>> Am I missing something here?
>>
>
> Yes. failure to allocate the resource is one.

So, a common mutex should be used.

I have also added synchronization to the USB PCI quirks code and
have split the patch into three pieces now (USB quirks, i2c-piix4 and
sp5100_tco) and they were sent to the relevant mailing lists.

I don't know which subsystem wants to take it, all 3 patches are
needed at once.

Best regards,
Zoltán Böszörményi
