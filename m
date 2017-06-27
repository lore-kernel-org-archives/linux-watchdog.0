Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
From: Boszormenyi Zoltan <zboszor@pr.hu>
To: Paul Menzel <paulepanter@users.sourceforge.net>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Christian Fetzer <fetzer.ch@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org, 853122@bugs.debian.org,
 Wim Van Sebroeck <wim@iguana.be>, Tim Small <tim@seoss.co.uk>,
 Nehal Shah <nehal-bakulchandra.shah@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>,
 linux-kernel@vger.kernel.org
References: <1485728348.3220.10.camel@googlemail.com>
 <1488530782.2457.41.camel@users.sourceforge.net>
 <20170303101702.GA1669@katana>
 <1490944639.2653.182.camel@users.sourceforge.net>
 <585a27fb-be15-df9f-00a9-bd4c3a654142@roeck-us.net>
 <d1152062-77c5-f1b7-6be9-d24ee221ada9@pr.hu>
 <20170331150524.GA31555@roeck-us.net>
 <efce69fc-3899-43f4-c8ee-12b78a571e5a@pr.hu>
 <1491201299.2321.42.camel@users.sourceforge.net>
 <b42d979b-9172-48ba-dba9-a67d9a143bca@pr.hu>
Message-ID: <655c505d-8b2f-9377-4238-6c10790a8f45@pr.hu>
Date: Tue, 27 Jun 2017 13:52:06 +0200
MIME-Version: 1.0
In-Reply-To: <b42d979b-9172-48ba-dba9-a67d9a143bca@pr.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

2017-04-03 09:59 keltezéssel, Boszormenyi Zoltan írta:
> Hi,
> 
> 2017-04-03 08:34 keltezéssel, Paul Menzel írta:
>> Dear Zoltán,
>>
>>
>> Am Samstag, den 01.04.2017, 12:13 +0200 schrieb Boszormenyi Zoltan:
>>
>> […]
>>
>>> and have split the patch into three pieces now (USB quirks, i2c-piix4
>>> and sp5100_tco) and they were sent to the relevant mailing lists.
>>
>> Could you please add me to the receiver list of these patches, so that
>> I can test them? Maybe also Christian (the commit author introducing
>> the regression), Tim (bug reporter), and Nehal from AMD?
>>
>> If you uploaded them to the Kernel.org Bugtracker, that’d also work for
>> me.
> 
> did both.

There's a new set of packages sent to all relevant mailing lists and
also attached to the kernel bugtracker at
https://bugzilla.kernel.org/show_bug.cgi?id=170741

Hopefully this approach will work for everyone.

> 
> Best regards,
> Zoltán Böszörményi
> 
>>
>>
>> Thanks,
>>
>> Paul
>>
> 
