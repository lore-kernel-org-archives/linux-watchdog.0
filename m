Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbbHRNIQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 09:08:16 -0400
Date: Tue, 18 Aug 2015 18:38:07 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Dave Young <dyoung@redhat.com>,
	Don Zickus <dzickus@redhat.com>
Subject: Re: Query: Best way to know if a watchdog is active (kicked)
Message-ID: <20150818130807.GB12876@dhcppc13.redhat.com>
References: <20150818051532.GC27149@dhcppc13.redhat.com>
 <55D2C524.1060903@roeck-us.net>
 <20150818065743.GE27149@dhcppc13.redhat.com>
 <55D329FE.2050005@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55D329FE.2050005@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 18/08/2015:05:50:06 AM, Guenter Roeck wrote:
> On 08/17/2015 11:57 PM, Pratyush Anand wrote:

[...]

> 
> One possible solution to your problem might be to have some sysfs attributes
> associated with watchdog devices, one of which would be its state.
> That has been on my mental task list for a while, but unfortunately
> I never found the time to implement it.

Well, I will give an attempt to implement state as a sysfs attributes associated
with watchdog devices, having two values ACTIVE and INACTIVE. Will send the
modification for review.
We can always add latter on more attributes and more state values.

Thanks a lot for your suggestion.

~Pratyush
