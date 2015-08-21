Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbbHUIwV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Aug 2015 04:52:21 -0400
Date: Fri, 21 Aug 2015 14:22:17 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Dave Young <dyoung@redhat.com>,
	Don Zickus <dzickus@redhat.com>
Subject: Re: Query: Best way to know if a watchdog is active (kicked)
Message-ID: <20150821085217.GA5989@dhcppc13.redhat.com>
References: <20150818051532.GC27149@dhcppc13.redhat.com>
 <55D2C524.1060903@roeck-us.net>
 <20150818065743.GE27149@dhcppc13.redhat.com>
 <55D329FE.2050005@roeck-us.net>
 <20150818130807.GB12876@dhcppc13.redhat.com>
 <55D33FEA.8000809@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55D33FEA.8000809@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 18/08/2015:07:23:38 AM, Guenter Roeck wrote:
> Sounds good. We should have a 'name' attribute as well. We'll also need
> 'timeout', 'keepalive' to ping the watchdog, 'timeleft', and 'bootstatus'.
> Not sure what else.
> 
> The attributes should be implemented as class attributes, to ensure
> that they are created and removed automatically. That may require
> the watchdog class to be static instead of a pointer.

Should n't attributes be implemented as device attribute as they are properties
of each device. Under the class watchdog_class, we can have multiple device on a
system, and these attributes would be different for different devices. So, what
I am thinking is to create device in __watchdog_register_device using
device_create_with_groups instead of device_create. Here we can link a
attribute_group with all attributes you suggested.

~Pratyush
