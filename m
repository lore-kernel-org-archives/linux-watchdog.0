Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36751 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbHROXq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 10:23:46 -0400
Message-ID: <55D33FEA.8000809@roeck-us.net>
Date: Tue, 18 Aug 2015 07:23:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Pratyush Anand <panand@redhat.com>
CC: linux-watchdog@vger.kernel.org, Dave Young <dyoung@redhat.com>,
	Don Zickus <dzickus@redhat.com>
Subject: Re: Query: Best way to know if a watchdog is active (kicked)
References: <20150818051532.GC27149@dhcppc13.redhat.com> <55D2C524.1060903@roeck-us.net> <20150818065743.GE27149@dhcppc13.redhat.com> <55D329FE.2050005@roeck-us.net> <20150818130807.GB12876@dhcppc13.redhat.com>
In-Reply-To: <20150818130807.GB12876@dhcppc13.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/18/2015 06:08 AM, Pratyush Anand wrote:
> On 18/08/2015:05:50:06 AM, Guenter Roeck wrote:
>> On 08/17/2015 11:57 PM, Pratyush Anand wrote:
>
> [...]
>
>>
>> One possible solution to your problem might be to have some sysfs attributes
>> associated with watchdog devices, one of which would be its state.
>> That has been on my mental task list for a while, but unfortunately
>> I never found the time to implement it.
>
> Well, I will give an attempt to implement state as a sysfs attributes associated
> with watchdog devices, having two values ACTIVE and INACTIVE. Will send the
> modification for review.
> We can always add latter on more attributes and more state values.
>

Sounds good. We should have a 'name' attribute as well. We'll also need
'timeout', 'keepalive' to ping the watchdog, 'timeleft', and 'bootstatus'.
Not sure what else.

The attributes should be implemented as class attributes, to ensure
that they are created and removed automatically. That may require
the watchdog class to be static instead of a pointer.

Thanks,
Guenter

