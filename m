Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36631 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbHRFjz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 01:39:55 -0400
Message-ID: <55D2C524.1060903@roeck-us.net>
Date: Mon, 17 Aug 2015 22:39:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Pratyush Anand <panand@redhat.com>, linux-watchdog@vger.kernel.org
CC: Dave Young <dyoung@redhat.com>, Don Zickus <dzickus@redhat.com>
Subject: Re: Query: Best way to know if a watchdog is active (kicked)
References: <20150818051532.GC27149@dhcppc13.redhat.com>
In-Reply-To: <20150818051532.GC27149@dhcppc13.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/17/2015 10:15 PM, Pratyush Anand wrote:
> Hi,
>
> I am looking for the best way to know if a watchdog has been kicked and active.
>
> I can see a way is to read timeout(WDIOC_GETTIMEOUT) and  timeleft(
> WDIOC_GETTIMELEFT). If they do not match, it means that wdt is active.
>
> But what if we tried to read timeleft just in time when watchdog daemon/or some
> other application had kicked it. May be we read timeleft twice at the interval
> of 1 sec.
>
> Please let me know if there is any other alternative which could be a better way
> to know if watchdog is active?  Or may be it would be good to implement an ioctl
> WDIOC_ACTIVE?
>

Normally the watchdog is active if the watchdog device is open, unless the
application controlling it explicitly disabled it with WDIOC_SETOPTIONS.
Therefore, the controlling application should always know the status.
A different application can not open the watchdog device, so it won't be
able to get its status using an ioctl anyway.

Why is that insufficient ?

Guenter

