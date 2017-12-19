Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
Subject: Re: [PATCH 2/5 v3] Modify behaviour of request_*muxed_region()
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
 Paul Menzel <paulepanter@users.sourceforge.net>,
 Christian Fetzer <fetzer.ch@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Nehal Shah <nehal-bakulchandra.shah@amd.com>, Tim Small <tim@seoss.co.uk>,
 kernel@ekass.net, wim@iguana.be, jlayton@poochiereds.net,
 marc.2377@gmail.com, cshorler@googlemail.com, wsa@the-dreams.de,
 regressions@leemhuis.info, Alex Williamson <alex.williamson@redhat.com>,
 lyude@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hpe.com>,
 Jiang Liu <jiang.liu@linux.intel.com>, Jakub Sitnicki <jsitnicki@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Simon Guinot <simon.guinot@sequanux.org>,
 Dan Williams <dan.j.williams@intel.com>, Mike Travis <travis@sgi.com>,
 Daeseok Youn <daeseok.youn@gmail.com>, Huang Rui <ray.huang@amd.com>,
 Andiry Xu <andiry.xu@amd.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 David Howells <dhowells@redhat.com>,
 Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
 Alexandre Desnoyers <alex@qtec.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Wan ZongShun <Vincent.Wan@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Lucas Stach <dev@lynxeye.de>,
 Denis Turischev <denis.turischev@compulab.co.il>
References: <20171218084841.9979-1-zboszor@pr.hu>
 <20171218084841.9979-2-zboszor@pr.hu> <20171218190741.GB6424@roeck-us.net>
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <cd1710e7-d317-ab69-27bb-17f645a83f91@pr.hu>
Date: Tue, 19 Dec 2017 07:11:11 +0100
MIME-Version: 1.0
In-Reply-To: <20171218190741.GB6424@roeck-us.net>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

2017-12-18 20:07 keltezéssel, Guenter Roeck írta:
> On Mon, Dec 18, 2017 at 09:48:38AM +0100, Zoltan Boszormenyi wrote:
>> From: Böszörményi Zoltán <zboszor@pr.hu>
>>
>> In order to make request_*muxed_region() behave more like
>> mutex_lock(), a possible failure case needs to be eliminated.
>> When drivers do not properly share the same I/O region, e.g.
>> one is using request_region() and the other is using
>> request_muxed_region(), the kernel didn't warn the user about it.
>> This change modifies IORESOURCE_MUXED behaviour so it always
>> goes to sleep waiting for the resuorce to be freed and the
> 
> resource
> 
>> inconsistent resource flag usage is logged with KERN_ERR.
>>
>> v2: Fixed checkpatch.pl warnings and extended the comment
>>      about request_declared_muxed_region.
>>
>> v3: Rebased for 4.15-rc4
>>
>> Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
>> ---
>>   kernel/resource.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 05db9c4e3992..0f26f887ac33 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -1143,6 +1143,7 @@ resource_size_t resource_alignment(struct resource *res)
>>    *
>>    * request_declared_muxed_region creates a new shared busy region
>>    * described in an existing resource descriptor.
>> + * It only returns if it succeeded.
>>    *
>>    * release_region releases a matching busy region.
>>    * The region is only freed if it was allocated.
>> @@ -1209,7 +1210,10 @@ struct resource *__request_declared_region(struct resource *parent,
>>   				continue;
>>   			}
>>   		}
>> -		if (conflict->flags & flags & IORESOURCE_MUXED) {
>> +		if (flags & IORESOURCE_MUXED) {
>> +			if (!(conflict->flags & IORESOURCE_MUXED))
>> +				pr_err("Resource conflict between muxed \"%s\" and non-muxed \"%s\" I/O regions!\n",
>> +					res->name, conflict->name);
> 
> With this, the muxed resource requestor will hang since the non-muxed
> requestor will not release the resource. I understand that you are trying
> to get rid of the error return, but is replacing it with a hang really
> better ?

I think it's a definite yes.

Consider the case of the regression this series is trying to fix.

Two drivers were trying to access a shared resource, both thinking
that it's the only one, which was almost true[1] initially.
An improvement in the i2c-piix4 driver in 4.4-rc3 broke sp5100_tco.
sp5100_tco was loaded second and failed outright.

This didn't make anyone to fix the situation, despite the fact
that there are at least three bugtrackers (kernel, Debian and Red Hat)
that point out the same problem.

So, a failing driver initialization is not horrifying enough to get
something fixed. Maybe a hang is.

Maybe this behaviour is still too weak, instead of doing it for an
inconsistent muxed/non-muxed case, it (at least the logging) should
be done for every case, to detect drivers that try to lock the same
resource.

In the case of an inconsistent resource flags usage, the bug is
not the hang itself, it's the inconsistent resource flags.

[1] The USB PCI quirks were accessing the same I/O resource without
locking and I found that on a Kabini machine, we got rare
"disabled by hub (EMI?), re-enabling..." reports that doesn't occur
with the locking applied. It is possible that two kernel threads were
doing I/O at the same time without synchronization.

> 
>>   			add_wait_queue(&muxed_resource_wait, &wait);
>>   			write_unlock(&resource_lock);
>>   			set_current_state(TASK_UNINTERRUPTIBLE);
>> -- 
>> 2.13.6
>>
> 
